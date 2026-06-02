// The module containing the serial handler
//
// References:
// https://github.com/derchr/EQPlatform-Guiding/blob/master/firmware/src/serial.rs
// https://github.com/derchr/EQPlatform-Guiding/blob/master/firmware/src/main.rs
// https://github.com/Rahix/avr-hal/issues/248

use crate::{
    console::println,
    movement::{
        Command, DropConeArgs, HandleJoystickArgs, LayConesInAStraightLineArgs,
        MovementHandler,
    },
};
use avr_device::interrupt::Mutex;
use core::{
    cell::{Cell, RefCell},
    ops::DerefMut,
};
use heapless::Vec;

use arduino_hal::{
    hal::{
        port::{PD2, PD3, PE0, PE1, PH0, PH1, PJ0, PJ1},
        usart::{UsartReader, UsartWriter},
    },
    pac::{USART0, USART1, USART2, USART3},
    port::{mode, Pin},
    prelude::_embedded_hal_serial_Read,
};

use crate::utils::enum_dispatch;

/// The stop command.
/// The new line character is because the buffer is considered
/// complete when the new line character is read.
const STOP_COMMAND: &str = "stop";

/// The variable to store whether the program has been stopped
static PROGRAM_STOPPED: Mutex<Cell<bool>> = Mutex::new(Cell::new(false));

/// The serial buffer to store the received data from the computer console
/// through the serial to USB port
static CONSOLE_SERIAL_BUFFER: Mutex<RefCell<Option<SerialBuffer>>> =
    Mutex::new(RefCell::new(None));

/// The serial buffer to store the received data from the phone application
/// via bluetooth
static BLUETOOTH_SERIAL_BUFFER: Mutex<RefCell<Option<SerialBuffer>>> =
    Mutex::new(RefCell::new(None));

/// The enum for the serial buffer type
#[derive(Copy, Clone)]
pub enum SerialBufferType {
    Console,
    Bluetooth,
}

/// The enum for the possible USART writers
pub enum UsartWriterInterface {
    USART0(
        UsartWriter<
            USART0,
            Pin<mode::Input<mode::AnyInput>, PE0>,
            Pin<mode::Output, PE1>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART1(
        UsartWriter<
            USART1,
            Pin<mode::Input<mode::AnyInput>, PD2>,
            Pin<mode::Output, PD3>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART2(
        UsartWriter<
            USART2,
            Pin<mode::Input<mode::AnyInput>, PH0>,
            Pin<mode::Output, PH1>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART3(
        UsartWriter<
            USART3,
            Pin<mode::Input<mode::AnyInput>, PJ0>,
            Pin<mode::Output, PJ1>,
            arduino_hal::DefaultClock,
        >,
    ),
}

/// The enum for the possible USART writers
pub enum UsartReaderInterface {
    USART0(
        UsartReader<
            USART0,
            Pin<mode::Input<mode::AnyInput>, PE0>,
            Pin<mode::Output, PE1>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART1(
        UsartReader<
            USART1,
            Pin<mode::Input<mode::AnyInput>, PD2>,
            Pin<mode::Output, PD3>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART2(
        UsartReader<
            USART2,
            Pin<mode::Input<mode::AnyInput>, PH0>,
            Pin<mode::Output, PH1>,
            arduino_hal::DefaultClock,
        >,
    ),
    USART3(
        UsartReader<
            USART3,
            Pin<mode::Input<mode::AnyInput>, PJ0>,
            Pin<mode::Output, PJ1>,
            arduino_hal::DefaultClock,
        >,
    ),
}

/// The structure of the serial buffer object
pub struct SerialBuffer {
    pub serial_receiver: UsartReaderInterface,
    pub buffer: heapless::String<256>,
    pub is_complete: bool,
}

/// The structure of the serial handler object
pub struct SerialHandler {
    pub serial_buffer_type: SerialBufferType,
    pub serial_transmitter: UsartWriterInterface,
}

/// The function to get the correct serial buffer
/// based on the serial buffer type given
pub fn get_serial_buffer(
    serial_buffer_type: SerialBufferType,
) -> &'static Mutex<RefCell<Option<SerialBuffer>>> {
    match serial_buffer_type {
        SerialBufferType::Console => &CONSOLE_SERIAL_BUFFER,
        SerialBufferType::Bluetooth => &BLUETOOTH_SERIAL_BUFFER,
    }
}

/// The function to get whether the program has been stopped.
/// This function must be called periodically called by the functions that
/// run in the main loop so that they can stop execution immediately
/// when the stop command is issued.
/// The function must be called in an interrupt free context to get
/// the PROGRAM_STOPPED global variable.
pub fn program_stopped() -> bool {
    avr_device::interrupt::free(|critical_section_token| {
        PROGRAM_STOPPED.borrow(critical_section_token).get()
    })
}

/// The function to set the PROGRAM_STOPPED global variable to true,
/// which stops the arduino from continuing to execute further commands.
/// The function must be called in an interrupt free context to set
/// the PROGRAM_STOPPED global variable.
pub fn stop_program() {
    avr_device::interrupt::free(|critical_section_token| {
        PROGRAM_STOPPED.borrow(critical_section_token).set(true)
    })
}

/// The function to set the PROGRAM_STOPPED variable back to false,
/// which allows the arduino to start executing commands again.
/// The function must be called in an interrupt free context to set
/// the PROGRAM_STOPPED global variable.
pub fn start_program() {
    avr_device::interrupt::free(|critical_section_token| {
        PROGRAM_STOPPED.borrow(critical_section_token).set(false)
    })
}

/// The macro to easily dispatch the function to the right USART interface.
/// This macro is just a wrapper around the enum dispatch macro
/// with the enum and enum variants filled in.
macro_rules! usart_dispatch {
    (
        $match_variable:expr,
        $enum_name:ident,
        |$enum_variant_obj:ident| $body:block) => {
        enum_dispatch!(
            $match_variable,
            $enum_name,
            USART0,
            USART1,
            USART2,
            USART3,
            |$enum_variant_obj| $body
        )
    };
}

/// The macro to initialise a serial handler
macro_rules! new_serial_handler {
    //

    // USART0
    // Pins on the Pololu Shield:
    // D1 for the RX (receiving) pin
    // D2 for the TX (transmitting) pin
    (USART0, $peripherals:expr, $pins:expr) => {{
        //

        // Initialise the USART0 interface
        let mut usart = arduino_hal::Usart::new(
            $peripherals.USART0,
            $pins.d0,
            $pins.d1.into_output(),
            arduino_hal::hal::usart::BaudrateArduinoExt::into_baudrate(
                crate::constants::BAUDRATE,
            ),
        );

        // Initialise the serial interface
        let serial_handler = new_serial_handler!(
            @init_serial usart,
            USART0,
            crate::serial::SerialBufferType::Console
        );

        // Return the serial handler
        serial_handler
    }};
    //

    // USART1
    // Pins on the Pololu Shield:
    // Z-MAX for the RX (receiving) pin
    // Z-MIN for the TX (transmitting) pin
    (USART1, $peripherals:expr, $pins:expr) => {{
        //

        // Initialise the USART interface
        let mut usart = ::arduino_hal::Usart::new(
            $peripherals.USART1,
            $pins.d19,
            $pins.d18.into_output(),
            arduino_hal::hal::usart::BaudrateArduinoExt::into_baudrate(
                crate::constants::BAUDRATE,
            ),
        );

        // Initialise the serial interface
        let serial_handler = new_serial_handler!(
            @init_serial usart,
            USART1,
            crate::serial::SerialBufferType::Bluetooth
        );

        // Return the serial handler
        serial_handler
    }};
    //

    // USART2
    // Pins on the Pololu Shield:
    // D17 for the RX (receiving) pin
    // D16 for the TX (transmitting) pin
    (USART2, $peripherals:expr, $pins:expr) => {{
        //

        // Initialise the USART interface
        let mut usart = arduino_hal::hal::Usart::new(
            $peripherals.USART2,
            $pins.d17,
            $pins.d16.into_output(),
            arduino_hal::hal::usart::BaudrateArduinoExt::into_baudrate(
                crate::constants::BAUDRATE,
            ),
        );

        // Initialise the serial interface
        let serial_handler = new_serial_handler!(
            @init_serial usart,
            USART2,
            crate::serial::SerialBufferType::Bluetooth
        );

        // Return the serial handler
        serial_handler
    }};
    //

    // USART3
    // Pins on the Pololu Shield:
    // Y-MAX for the RX (receiving) pin
    // Y-MIN for the TX (transmitting) pin
    (USART3, $peripherals:expr, $pins:expr) => {{
        //

        // Initialise the USART interface
        let mut usart = arduino_hal::Usart::new(
            $peripherals.USART3,
            $pins.d15,
            $pins.d14.into_output(),
            arduino_hal::hal::usart::BaudrateArduinoExt::into_baudrate(
                crate::constants::BAUDRATE,
            ),
        );

        // Initialise the serial interface
        let serial_handler = new_serial_handler!(
            @init_serial usart,
            USART3,
            crate::serial::SerialBufferType::Bluetooth
        );

        // Return the serial handler
        serial_handler
    }};
    //

    // The match arm to initialise the serial handler
    (
        @init_serial $usart_variable:ident,
        $usart_interface:ident,
        $serial_buffer_type:path
    ) => {{
        //

        // Listen for the RX complete event
        $usart_variable.listen(arduino_hal::hal::usart::Event::RxComplete);

        // Split the USART into the receiver and the transmitter
        let (usart_receiver, usart_transmitter) = $usart_variable.split();

        // Initialise the serial buffer with the USART receiver,
        // and execute the block in an interrupt-free context
        avr_device::interrupt::free(|critical_section_token| {
            //

            // Grab the global serial buffer object and replace it
            // with a new SerialBuffer object to initialise it
            crate::serial::get_serial_buffer($serial_buffer_type)
                .borrow(critical_section_token)
                .replace(Some(crate::serial::SerialBuffer {
                    serial_receiver:
                        crate::serial::UsartReaderInterface::$usart_interface(
                            usart_receiver,
                        ),
                    buffer: heapless::String::new(),
                    is_complete: false,
                }))
        });

        // Return the serial handler with the USART transmitter
        crate::serial::SerialHandler {
            serial_buffer_type: $serial_buffer_type,
            serial_transmitter:
                crate::serial::UsartWriterInterface::$usart_interface(
                    usart_transmitter,
                ),
        }}
    };
}

/// Implement the read function for the USART reader interface
impl UsartReaderInterface {
    pub fn read(&mut self) -> Result<u8, nb::Error<core::convert::Infallible>> {
        usart_dispatch!(self, UsartReaderInterface, |reader| { reader.read() })
    }
}

/// The function to parse the input
pub fn parse_input(input: &str) -> Option<Command> {
    //

    // Split the string at the whitespace character
    let splitted_string = input.trim().split_whitespace();

    // Initialise the vector to store the arguments
    let mut arguments: Vec<&str, 3> = Vec::new();

    // Push the arguments to the vector
    for argument in splitted_string {
        arguments.push(argument).unwrap_or_default();
    }

    // Add empty strings until the vector has 3 elements
    while arguments.len() < 3 {
        arguments.push("").unwrap_or_default();
    }

    // Get the command and
    // the first and second arguments from the splitted string.
    // If they don't exist, then return None.
    let [command_str, first_arg_str, second_arg_str] = arguments[..] else {
        return None;
    };

    // Parse the first and second arguments into floats
    let first_arg = first_arg_str.parse::<i16>().unwrap_or_default();
    let second_arg = second_arg_str.parse::<i16>().unwrap_or_default();

    // Match the command
    match command_str {
        "handle_joystick" => {
            Some(Command::HandleJoystick(HandleJoystickArgs {
                x_coordinate: first_arg,
                y_coordinate: second_arg,
            }))
        }
        "lay_cones_in_a_straight_line" => Some(
            Command::LayConesInAStraightLine(LayConesInAStraightLineArgs {
                cone_spacing_in_cm: first_arg,
                number_of_cones_to_lay: second_arg,
            }),
        ),
        "drop_cone" => Some(Command::DropCone(DropConeArgs {
            dispenser_motor_speed: first_arg,
        })),
        "stop" => Some(Command::Stop),
        _ => None,
    }
}

/// The function to handle input from the serial connection
pub fn handle_input(serial_buffer_type: SerialBufferType) -> Option<Command> {
    //

    // Initialise the variable to store the parsed input
    let mut parsed_input: Option<Command> = None;

    // Execute the code to handle the input in an
    // interrupt-free context.
    avr_device::interrupt::free(|critical_section_token| {
        //

        // Borrow the global serial buffer object
        if let Some(ref mut serial_buffer) =
            get_serial_buffer(serial_buffer_type)
                .borrow(critical_section_token)
                .borrow_mut()
                .deref_mut()
        {
            // If the serial buffer is complete
            if serial_buffer.is_complete {
                //

                // Get the string from the buffer
                let buffer = serial_buffer.buffer.as_str();

                // Start the program to get ready
                // to handle the incoming command
                start_program();

                // Parse the input and set the variable
                parsed_input = parse_input(buffer);

                // Clear the buffer
                serial_buffer.buffer.clear();

                // Set the serial buffer to incomplete
                serial_buffer.is_complete = false;
            }
        }
    });

    // Return the parsed input
    return parsed_input;
}

// The function to dispatch the commands
pub fn dispatch_commands(
    input: Option<Command>,
    movement_handler: &mut MovementHandler,
    run_movement_motors_at_constant_speed: &mut bool,
) {
    //

    // Match on the input given
    match input {
        Some(Command::HandleJoystick(arguments)) => {
            //

            // Print that the Arduino is handling the joystick
            println!("Handling Joystick");

            // Set the run movement motors at
            // constant speed variable to true
            *run_movement_motors_at_constant_speed = true;

            // Handle the joystick
            movement_handler.handle_joystick(arguments);
        }
        Some(Command::LayConesInAStraightLine(arguments)) => {
            //

            // Print that the Arduino is laying cones in a straight line
            println!("Laying cones in a straight line");

            // Set the run movement motors at constant speed variable
            // to false as we want acceleration
            *run_movement_motors_at_constant_speed = false;

            // Lay cones in a straight line
            movement_handler.lay_cones_in_a_straight_line_blocking(arguments);
        }
        Some(Command::DropCone(arguments)) => {
            //

            // Print that the Arduino is dropping a cone
            println!("Dropping cone");

            // Set the run movement motors at constant speed variable
            // to false just in case we need to stop
            *run_movement_motors_at_constant_speed = false;

            // Drop the cone
            movement_handler.drop_cone(arguments);
        }
        Some(Command::Stop) => {
            //

            // Print that the Arduino is stopping
            println!("Stopping");

            // Stop all the motors
            movement_handler
                .stop_all_motors(*run_movement_motors_at_constant_speed);
        }
        None => {}
    }
}

/// The implementation of the serial handler class
impl SerialHandler {
    //

    /// The function to handle input from the serial connection
    pub fn handle_input(&mut self) -> Option<Command> {
        return handle_input(self.serial_buffer_type);
    }

    /// The function to write a string to the serial connection
    pub fn write_string(&mut self, string: &str) {
        usart_dispatch!(
            &mut self.serial_transmitter,
            UsartWriterInterface,
            |serial_transmitter| {
                ufmt::uwrite!(serial_transmitter, "{}", string).ok();
            }
        )
    }

    /// The function to write a number to the serial connection
    pub fn write_number<T: num::Integer + ufmt::uDisplay>(&mut self, value: T) {
        usart_dispatch!(
            &mut self.serial_transmitter,
            UsartWriterInterface,
            |serial_transmitter| {
                ufmt::uwrite!(serial_transmitter, "{}", value).ok();
            }
        )
    }
}

/// The module containing
/// the interrupt service routines needed for serial communication
mod serial_isr {
    use core::ops::DerefMut;

    use super::{
        get_serial_buffer, stop_program, SerialBufferType, STOP_COMMAND,
    };

    // The interrupt service routine to write to the serial buffer
    fn interrupt_service_routine(serial_buffer_type: SerialBufferType) {
        //

        // Write to the serial buffer in an interrupt-free context
        avr_device::interrupt::free(|critical_section_token| {
            //

            // Borrow the global serial buffer
            if let Some(ref mut serial_buffer) =
                get_serial_buffer(serial_buffer_type)
                    .borrow(critical_section_token)
                    .borrow_mut()
                    .deref_mut()
            {
                // Get the byte
                let byte = serial_buffer.serial_receiver.read().unwrap();

                // If the byte is the newline character
                // or the backslash character
                if byte == b'\n' || byte == b'\\' {
                    //

                    // Set the serial buffer to complete
                    serial_buffer.is_complete = true;

                    // If the serial buffer is the stop command,
                    // stop the program.
                    if serial_buffer.buffer == STOP_COMMAND {
                        stop_program();
                    }
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
                        serial_buffer
                            .buffer
                            .push(character)
                            .ok()
                            .unwrap_or_default();
                    }
                }
            }
        });
    }

    // Place the interrupt service routine on the console interface (USART0)
    #[avr_device::interrupt(atmega2560)]
    fn USART0_RX() {
        //

        // Call the interrupt service routine with the console
        // serial buffer type
        interrupt_service_routine(SerialBufferType::Console);
    }

    // Place the interrupt service routine on the bluetooth interface.
    // Change the function name to the correct USART interface
    // when it is changed.
    #[avr_device::interrupt(atmega2560)]
    fn USART2_RX() {
        //

        // Call the interrupt service routine with the bluetooth
        // serial buffer type
        interrupt_service_routine(SerialBufferType::Bluetooth);
    }
}

pub(crate) use new_serial_handler;
pub(crate) use usart_dispatch;
