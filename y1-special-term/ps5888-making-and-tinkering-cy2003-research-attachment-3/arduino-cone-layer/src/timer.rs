// The module for the timer.
//
// References:
// https://blog.rahix.de/005-avr-hal-millis/
// https://github.com/Rahix/avr-hal/blob/main/examples/arduino-uno/src/bin/uno-millis.rs
// https://github.com/Cryptjar/avr-progmem-rs/blob/v0.4/examples/time/mod.rs

use core::{cell::RefCell, ops::Deref};

use arduino_hal::{pac::TC0, simple_pwm::Prescaler};
use avr_device::interrupt::Mutex;

// Some possible values for the prescaler and the timer counts:
//
// ╔═══════════╦══════════════╦═══════════════════╗
// ║ PRESCALER ║ TIMER_COUNTS ║ Overflow Interval ║
// ╠═══════════╬══════════════╬═══════════════════╣
// ║        64 ║          250 ║              1 ms ║
// ║       256 ║          125 ║              2 ms ║
// ║       256 ║          250 ║              4 ms ║
// ║      1024 ║          125 ║              8 ms ║
// ║      1024 ║          250 ║             16 ms ║
// ╚═══════════╩══════════════╩═══════════════════╝

/// Set the prescaler.
///
/// The prescaler, also called a clock divider,
/// is used to "slow down" the clock to get larger
/// intervals of time between each overflow.
const PRESCALER: Prescaler = Prescaler::Prescale64;

/// Set the number of times the timer will count
/// before it overflows, triggering an interrupt.
///
/// For example, a value of 250 means the timer will
/// count from 0 - 249 (250 steps), and overflow when
/// the timer value hits 250 and trigger an interrupt.
const TIMER_COUNTS: u32 = 250;

/// Set the clock frequency.
/// The clock frequency on most Arduino boards is 16MHz.
const CLOCK_FREQUENCY: u32 = 16_000_000;

/// The increment size for the milliseconds.
/// This increment is equal to the overflow interval
/// in the table above.
/// The multiplication by 1000 is to convert the
/// seconds to milliseconds.
/// Make sure that the multiplication is done first,
/// otherwise the value will be 0.
const MILLISECOND_INCREMENT: u32 =
    1_000 * get_prescaler_value(PRESCALER) * TIMER_COUNTS / CLOCK_FREQUENCY;

/// The number of microseconds per timer counter value
/// The multiplication by 1,000,000 is to convert
/// from seconds to microseconds.
/// Make sure that the multiplication is done first,
/// otherwise the value will be 0.
const MICROSECONDS_PER_COUNTER_VALUE: u32 =
    1_000_000 * get_prescaler_value(PRESCALER) / CLOCK_FREQUENCY;

/// The global variable to store the number of milliseconds elapsed
/// since the program started.
static TIMER_STRUCTURE: Mutex<RefCell<Option<Timer>>> =
    Mutex::new(RefCell::new(None));

/// Constant function to convert the prescaler
/// enum to a value.
const fn get_prescaler_value(prescaler: Prescaler) -> u32 {
    match prescaler {
        Prescaler::Direct => 1,
        Prescaler::Prescale8 => 8,
        Prescaler::Prescale64 => 64,
        Prescaler::Prescale256 => 256,
        Prescaler::Prescale1024 => 1024,
    }
}

/// The structure of the timer object
pub struct Timer {
    timer_interface: TC0,
    millisecond_counter: u32,
}

/// The function to initialise the timer and start it
pub fn init_and_start(tc0_interface: TC0) {
    //

    // Set the overflow behaviour in the TCCR0A register to
    // CTC mode, or "Clear Timer on Compare mode"
    tc0_interface.tccr0a.write(|w| w.wgm0().ctc());

    // Configure the "maximum" value of the timer in the OCR0A register
    tc0_interface.ocr0a.write(|w| w.bits(TIMER_COUNTS as u8));

    // Configure the prescaling factor on the TCCR0B register
    // to the prescaling factor used above
    tc0_interface.tccr0b.write(|w| match PRESCALER {
        Prescaler::Direct => w.cs0().direct(),
        Prescaler::Prescale8 => w.cs0().prescale_8(),
        Prescaler::Prescale64 => w.cs0().prescale_64(),
        Prescaler::Prescale256 => w.cs0().prescale_256(),
        Prescaler::Prescale1024 => w.cs0().prescale_1024(),
    });

    // Enable the overflow interrupt on the TIMSK0 register
    tc0_interface.timsk0.write(|w| w.ocie0a().set_bit());

    // Initialise the timer structure
    avr_device::interrupt::free(|critical_section_token| {
        //

        // Borrow the global timer structure and replace it with
        // an initialised timer structure.
        TIMER_STRUCTURE
            .borrow(critical_section_token)
            .replace(Some(Timer {
                timer_interface: tc0_interface,
                millisecond_counter: 0,
            }))
    });
}

/// The implementation of the timer
impl Timer {
    //

    /// Function to return the number of milliseconds that have passed
    /// since the program started.
    /// This is an implementation of the Arduino millis function.
    fn millis(&self) -> u32 {
        self.millisecond_counter
    }

    /// Function to return the number of microseconds that have passed
    /// since the program started.
    /// This is an implementation of the Arduino micros function.
    fn micros(&self) -> u32 {
        //

        // Get the number of milliseconds that have passed since the
        // program started running.
        let mut milliseconds: u32 = self.millis();

        // Get the current timer counter value from the TCNT0 register
        let current_timer_counter_value =
            self.timer_interface.tcnt0.read().bits();

        // Get the value of the timer output compare flag.
        //
        // If the value of this output compare flag is true,
        // that means current timer counter value has
        // already hit its maximum value (set by TIMER_COUNTS above).
        // Otherwise, the maximum value has not been hit yet.
        let timer_output_compare_flag =
            self.timer_interface.tifr0.read().ocf0a().bit();

        // Get the number of microseconds from the timer counter value
        let microseconds_from_timer_counter_value =
            u32::from(current_timer_counter_value)
                * MICROSECONDS_PER_COUNTER_VALUE;

        // If the timer output compare flag is true,
        // that means the current timer counter value has already
        // hit its maximum value set by TIMER_COUNTS constant above.
        //
        // If the current timer counter value is less than the
        // maximum value set by the TIMER_COUNTS constant above,
        // that usually means the timer has wrapped around without
        // the millisecond counter being incremented.
        //
        // This is because an interrupt is supposed to happen,
        // but the code above is in an interrupt-free context,
        // which means that the millisecond counter will not increase
        // since the interrupt service routine to increase the
        // millisecond counter cannot run while the above code is running.
        //
        // The interrupt service routine will run later,
        // as the interrupt is pending,
        // but that means that the current millisecond counter is
        // wrong and needs to be increased by the overflow interval,
        // which is the MILLISECOND_INCREMENT constant set above.
        //
        // Thus, we have to increment the millisecond counter ourselves.
        if timer_output_compare_flag
            && current_timer_counter_value < TIMER_COUNTS as u8
        {
            milliseconds += MILLISECOND_INCREMENT;
        }

        // Return the number of microseconds that have passed
        // since the program started running
        return milliseconds * 1000 + microseconds_from_timer_counter_value;
    }
}

/// Function to return the number of milliseconds that have passed
/// since the program started.
/// This function just calls the millis function on the timer structure.
/// This is an implementation of the Arduino millis function.
pub fn millis() -> u32 {
    //

    // Run the function in an interrupt-free context since
    // it is borrowing the global timer structure.
    avr_device::interrupt::free(|critical_section_token| {
        //

        // Get the timer structure if it exists
        if let Some(ref timer_structure) = TIMER_STRUCTURE
            .borrow(critical_section_token)
            .borrow()
            .deref()
        {
            // Get the number of milliseconds that have passed since
            // the program has started by calling the millis function
            // on the timer structure and returning the result
            return timer_structure.millis();
        }

        // Otherwise, return 0
        return 0;
    })
}

/// Function to return the number of microseconds that have passed
/// since the program started.
/// This function just calls the micros function on the timer structure.
/// This is an implementation of the Arduino micros function.
pub fn micros() -> u32 {
    //

    // Run the function in an interrupt-free context since
    // it is borrowing the global timer structure.
    avr_device::interrupt::free(|critical_section_token| {
        //

        // Get the timer structure if it exists
        if let Some(ref timer_structure) = TIMER_STRUCTURE
            .borrow(critical_section_token)
            .borrow()
            .deref()
        {
            // Get the number of microseconds that have passed since
            // the program has started and return the result
            return timer_structure.micros();
        }

        // Otherwise, return 0
        return 0;
    })
}

/// The module to store the interrupt service routines for the timer
mod timer_isr {
    use super::{MILLISECOND_INCREMENT, TIMER_STRUCTURE};
    use core::ops::DerefMut;

    /// Create the interrupt service routine on the TC0 interface.
    ///
    /// This TC0 interface is in "Clear Timer on Compare mode",
    /// CTC mode for short, so we have create the
    /// interrupt service routine on TIMER0_COMPA instead of TIMER0_OVR.
    ///
    /// TIMER0_OVR only triggers when the timer reaches 255, which will
    /// never happen in CTC mode as the TIMER_COUNTS variable above
    /// is less than 255.
    /// TIMER0_OVR doesn't take into account our TIMER_COUNTS variable above,
    /// so it is not very useful for us as we want overflow intervals that
    /// are integer values.
    #[avr_device::interrupt(atmega2560)]
    fn TIMER0_COMPA() {
        //

        // Execute the interrupt service routine in an interrupt-free context
        avr_device::interrupt::free(|critical_section_token| {
            //

            // Get the timer structure if it exists
            if let Some(ref mut timer_structure) = TIMER_STRUCTURE
                .borrow(critical_section_token)
                .borrow_mut()
                .deref_mut()
            {
                // Add the millisecond increment to the timer structure
                timer_structure.millisecond_counter += MILLISECOND_INCREMENT;
            }
        });
    }
}
