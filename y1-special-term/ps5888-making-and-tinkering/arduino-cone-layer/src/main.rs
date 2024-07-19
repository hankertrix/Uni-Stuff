#![no_std]
#![no_main]
#![feature(abi_avr_interrupt)]

// Modules
mod serial;
mod movement;

// Use declarations
use panic_halt as _;

/// Function to execute
#[arduino_hal::entry]
fn main() -> ! {

    // Setup code

    // Get the peripherals and the pins on the arduino
    let peripherals = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(peripherals);

    /*
     * For examples (and inspiration), head to
     *
     *     https://github.com/Rahix/avr-hal/tree/main/examples
     *
     * NOTE: Not all examples were ported to all boards!  There is a good chance though, that code
     * for a different board can be adapted for yours.  The Arduino Uno currently has the most
     * examples available.
     */

    let mut led = pins.d13.into_output();

    loop {
        led.toggle();
        arduino_hal::delay_ms(1000);
    }
}
