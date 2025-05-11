// The module for the console serial handler
// Reference: https://github.com/Rahix/avr-hal/blob/main/examples/arduino-uno/src/bin/uno-println.rs

use crate::serial::SerialHandler;
use core::cell::RefCell;

// The console serial handler
pub static CONSOLE: avr_device::interrupt::Mutex<
    RefCell<Option<SerialHandler>>,
> = avr_device::interrupt::Mutex::new(RefCell::new(None));

// The macro to print to the console
macro_rules! print {
    ($($arg:tt)*) => {

        // Get the console serial handler in a critical section
        avr_device::interrupt::free(|critical_section_token| {
            if let Some(ref mut console) = crate::console::CONSOLE
                .borrow(critical_section_token)
                .borrow_mut()
                .as_mut()
            {

                // Write to the serial transmitter
                crate::utils::enum_dispatch!(
                    &mut console.serial_transmitter,
                    UsartWriterInterface,
                    USART0,
                    USART1,
                    USART2,
                    USART3,
                    |serial_transmitter| {
                        ufmt::uwrite!(serial_transmitter, $($arg)*)
                            .unwrap_or_default();
                    }
                );
            }
        })
    };
}

// The macro to print to the console with a newline
macro_rules! println {
    ($($arg:tt)*) => {

        // Get the console serial handler in a critical section
        avr_device::interrupt::free(|critical_section_token| {
            if let Some(ref mut console) = crate::console::CONSOLE
                .borrow(critical_section_token)
                .borrow_mut()
                .as_mut()
            {

                // Write to the serial transmitter
                crate::utils::enum_dispatch!(
                    &mut console.serial_transmitter,
                    UsartWriterInterface,
                    USART0,
                    USART1,
                    USART2,
                    USART3,
                    |serial_transmitter| {
                        ufmt::uwriteln!(serial_transmitter, $($arg)*)
                            .unwrap_or_default();
                    }
                );
            }
        })
    };
}

// The function to put the console serial handler in the global variable
pub fn put_console_serial_handler(serial_handler: SerialHandler) {
    avr_device::interrupt::free(|critical_section_token| {
        *CONSOLE.borrow(critical_section_token).borrow_mut() =
            Some(serial_handler);
    });
}

pub(crate) use print;
pub(crate) use println;
