// The module containing the serial handler

use avr_device::interrupt::Mutex;
use core::{cell::RefCell, ops::DerefMut};

use arduino_hal::{
    hal::{
        port::{PD2, PD3},
        usart::{Event, UsartReader, UsartWriter},
    },
    pac::USART1,
    port::{mode, Pin},
    Peripherals, Pins, Usart,
};

/// The structure of the serial buffer object
struct SerialBuffer {
    usart_receiver: UsartReader<
        USART1,
        Pin<mode::Input<mode::AnyInput>, PD2>,
        Pin<mode::Output, PD3>,
        arduino_hal::DefaultClock,
    >,
    buffer: heapless::String<512>,
    is_complete: bool,
}

/// The structure of the serial handler object
pub struct SerialHandler {
    usart_transmitter: UsartWriter<
        USART1,
        Pin<mode::Input<mode::AnyInput>, PD2>,
        Pin<mode::Output, PD3>,
        arduino_hal::DefaultClock,
    >,
}

/// The enum containing the different types of commands
/// that can be executed
pub enum Command {
    Move,
}

/// The serial buffer to store the received data
static SERIAL_BUFFER: Mutex<RefCell<Option<SerialBuffer>>> =
    Mutex::new(RefCell::new(None));

/// The serial handler class
impl SerialHandler {
    //

    // The constructor for the serial handler
    pub fn new(peripherals: Peripherals, pins: Pins) -> Self {
        //

        // Initialise the serial connection
        let mut serial_connection = Usart::new(
            peripherals.USART1,
            pins.d19,
            pins.d18.into_output(),
            arduino_hal::hal::usart::BaudrateArduinoExt::into_baudrate(57600),
        );

        // Enable interrupts
        serial_connection.listen(Event::RxComplete);

        // Split the USART connection into the transmitter and receiver
        let (usart_receiver, usart_transmitter) = serial_connection.split();

        // Initialise the serial buffer with the USART receiver,
        // and execute the block in an interrupt-free context
        avr_device::interrupt::free(|critical_section| {
            //

            // Grab the global serial buffer object and replace it
            SERIAL_BUFFER
                .borrow(critical_section)
                .replace(Some(SerialBuffer {
                    usart_receiver,
                    buffer: heapless::String::new(),
                    is_complete: false,
                }))
        });

        // Return the serial handler with the USART transmitter
        Self { usart_transmitter }
    }

    /// The function to handle input from the serial connection
    pub fn handle_input(&mut self) {
        //

        // Execute the code to handle the input in an
        // interrupt-free context.
        avr_device::interrupt::free(|critcal_section| {
            //

            // Borrow the global serial buffer object
            if let Some(ref mut serial_buffer) = SERIAL_BUFFER
                .borrow(critcal_section)
                .borrow_mut()
                .deref_mut()
            {
                // If the serial buffer is complete
                if serial_buffer.is_complete {
                    //

                    // Get the string from the buffer
                    let buffer = serial_buffer.buffer.as_str();

                    // Clear the buffer
                    serial_buffer.buffer.clear();

                    // Set the serial buffer to incomplete
                    serial_buffer.is_complete = false;
                }
            }
        });
    }
}

/// The module containing
/// the interrupt service routines needed for serial communication
mod serial_isr {
    use arduino_hal::prelude::_embedded_hal_serial_Read;
    use core::ops::DerefMut;

    use super::SERIAL_BUFFER;

    // The interrupt service routine on the USART1 interface
    #[avr_device::interrupt(atmega2560)]
    fn USART1_RX() {
        //

        // Write to the serial buffer in an interrupt-free context
        avr_device::interrupt::free(|critical_section| {
            //

            // Borrow the global serial buffer
            if let Some(ref mut serial_buffer) = SERIAL_BUFFER
                .borrow(critical_section)
                .borrow_mut()
                .deref_mut()
            {
                // Get the byte
                let byte = serial_buffer.usart_receiver.read().unwrap();

                // If the byte is the newline character,
                // set the serial buffer to complete
                if byte == b'\n' {
                    serial_buffer.is_complete = true;
                }
                //

                // Otherwise
                else {
                    //

                    // Try to convert the byte to a character
                    if let Some(character) = core::char::from_u32(byte as u32) {
                        //

                        // Try to push to the buffer.
                        // If the push fails, which means the buffer
                        // is full, ignore the characters.
                        match serial_buffer.buffer.push(character) {
                            Ok(_) => (),
                            Err(_) => (),
                        }
                    }
                }
            }
        });
    }
}
