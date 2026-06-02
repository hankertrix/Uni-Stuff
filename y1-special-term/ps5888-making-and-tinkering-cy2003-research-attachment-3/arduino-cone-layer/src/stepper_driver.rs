// The module to control the stepper motor
//
// References:
// https://github.com/waspinator/AccelStepper/blob/1255ab56820746137aba3d5d788f5d0b9baf6d4a/src/AccelStepper.cpp#L72
// https://www.airspayce.com/mikem/arduino/AccelStepper/classAccelStepper.html
// https://www.tommycoolman.com/2021/07/31/control-two-independent-stepper-motors-with-an-arduino/
// https://github.com/laurb9/StepperDriver/blob/master/src/MultiDriver.cpp
// https://github.com/laurb9/StepperDriver/blob/master/src/BasicStepperDriver.cpp
// https://wokwi.com/projects/363948225373532161
//
// References for equations:
// All the equations referred to in the code
// come from the first PDF file below:
// https://web.archive.org/web/20140705143928/http://fab.cba.mit.edu/classes/MIT/961.09/projects/i0/Stepper_Motor_Speed_Profile.pdf
// https://ww1.microchip.com/downloads/en/Appnotes/doc8017.pdf

use arduino_hal::{
    hal::port::{
        PA2, PA4, PA6, PC1, PC3, PC7, PD7, PF0, PF1, PF2, PF6, PF7, PK0, PL1,
        PL3,
    },
    port::{mode::Output, Pin},
};
use num::Float;

use crate::{
    console::println, serial::program_stopped, serial::UsartWriterInterface,
    timer::micros, utils::enum_dispatch,
};

/// The enum containing the step resolution.
/// The number each variant corresponds to
/// is the number of steps per revolution
/// in each resolution mode.
#[derive(Copy, Clone)]
pub enum StepResolution {
    FullStep = 200,
    HalfStep = 400,
    QuarterStep = 800,
    EighthStep = 1600,
    SixteenthStep = 3200,
}

/// The enum containing the direction of the stepper motor
#[derive(PartialEq, Copy, Clone)]
pub enum Direction {
    Clockwise,
    AntiClockwise,
}

/// The struct containing the state
/// needed for the driver to function.
#[derive(Copy, Clone)]
pub struct StepperDriverState {
    ///

    // Public variables

    /// The boolean to represent whether the motor
    /// is enabled or disabled.
    enabled: bool,

    /// The speed of the motor in steps/s
    speed: f32,

    /// The maximum speed of the motor in steps/s.
    /// The motor will accelerate up to this maximum speed.
    /// This is NOT the theoretical maximum speed of the motor.
    /// Each stepper motor driver takes about 67.2 - 68 microseconds
    /// to run at constant speed.
    /// Each stepper motor takes about 425.6 - 427.2 microseconds
    /// to run with acceleration.
    maximum_speed: f32,

    /// The acceleration is in steps/s^2
    acceleration: f32,

    /// The current motor position in steps.
    /// The initial position of the motor is considered 0.
    ///
    /// The position being positive means that
    /// the position is clockwise from the 0 position and
    /// negative means the position is anti-clockwise from the 0 position.
    current_position: i32,

    /// The target motor position in steps.
    /// The initial position of the motor is considered 0.
    ///
    /// The position being positive means that
    /// the position is clockwise from the 0 position and
    /// negative means the position is anti-clockwise from the 0 position.
    target_position: i32,

    /// The minimum pulse width allowed by the stepper driver in microseconds.
    /// The practical minimum pulse with is 20 microseconds.
    /// Pulse widths under 20 microseconds usually result in pulse
    /// widths of around 20 microseconds anyway.
    minimum_pulse_width_in_us: u32,
    ///

    // Private variables

    /// The direction that the motor is spinning in
    direction: Direction,

    /// The time interval between each step in microseconds.
    ///
    /// This is essentially the value of
    /// the current_step_interval_in_us variable,
    /// but as an unsigned integer instead of a float.
    step_interval_in_us: u32,

    /// The step number.
    ///
    /// This number is the sequence number in the
    /// formula to calculate the time interval between
    /// each step of the motor.
    ///
    /// This number increases every time the motor takes a step.
    /// If the number is positive, the motor is accelerating.
    /// If the number is negative, the motor is decelerating.
    ///
    /// This is n in the formulas in the PDF file.
    step_number: i32,

    /// The initial time interval between two steps.
    ///
    /// This is the time interval between two steps
    /// when the motor is starting to speed up from rest.
    /// It sets the initial acceleration of the motor
    /// and ultimately determines the speed profile of the motor.
    ///
    /// This is c_0 in the formulas.
    initial_step_interval_in_us: f32,

    /// The current time interval between two steps.
    ///
    /// This is the time interval between two steps
    /// when the motor is already moving.
    ///
    /// This value is recomputed every single time
    /// the motor takes a step as the step number increases.
    ///
    /// This is c_n in the formulas in the PDF file.
    current_step_interval_in_us: f32,

    /// The minimum time interval between two steps.
    ///
    /// This is the time interval between two steps
    /// when the speed has reached the maximum speed.
    ///
    /// This is c_min in the formulas in the PDF file.
    minimum_step_interval_in_us: f32,

    /// The time of the previous step taken by the motor.
    previous_step_time_in_us: u32,

    /// The step resolution of the motor
    step_resolution: StepResolution,
}

/// The implementation of the default trait for the stepper driver state.
/// The step resolution will default to the step resolution set in the
/// constants file.
impl Default for StepperDriverState {
    fn default() -> Self {
        Self {
            //

            // Public variables
            enabled: false,
            speed: 0.0,
            maximum_speed: 0.0,
            acceleration: 0.0,
            current_position: 0,
            target_position: 0,
            minimum_pulse_width_in_us: 1,

            // Private variables
            direction: Direction::Clockwise,
            step_interval_in_us: 0,
            step_number: 0,
            initial_step_interval_in_us: 0.0,
            current_step_interval_in_us: 0.0,
            minimum_step_interval_in_us: 0.0,
            previous_step_time_in_us: 0,
            step_resolution: StepResolution::FullStep,
        }
    }
}

/// The struct for the E0 stepper motor driver
pub struct E0 {
    pub state: StepperDriverState,
    pub enable_pin: Pin<Output, PA2>,
    pub direction_pin: Pin<Output, PA6>,
    pub step_pin: Pin<Output, PA4>,
}

/// The struct for the E1 stepper motor driver
pub struct E1 {
    pub state: StepperDriverState,
    pub enable_pin: Pin<Output, PC7>,
    pub direction_pin: Pin<Output, PC3>,
    pub step_pin: Pin<Output, PC1>,
}

/// The struct for the X stepper motor driver
pub struct X {
    pub state: StepperDriverState,
    pub enable_pin: Pin<Output, PD7>,
    pub direction_pin: Pin<Output, PF1>,
    pub step_pin: Pin<Output, PF0>,
}

/// The struct for the Y stepper motor driver
pub struct Y {
    pub state: StepperDriverState,
    pub enable_pin: Pin<Output, PF2>,
    pub direction_pin: Pin<Output, PF7>,
    pub step_pin: Pin<Output, PF6>,
}

/// The struct for the Z stepper motor driver
pub struct Z {
    pub state: StepperDriverState,
    pub enable_pin: Pin<Output, PK0>,
    pub direction_pin: Pin<Output, PL1>,
    pub step_pin: Pin<Output, PL3>,
}

/// The enum for the possible stepper motor drivers
pub enum StepperDriver {
    E0(E0),
    E1(E1),
    X(X),
    Y(Y),
    Z(Z),
}

/// Macro to create a new stepper motor with the correct pins
/// on the Arduino Mega Pololu Shield
macro_rules! new_stepper_driver {
    //

    // The stepper motor on the E0 stepper driver
    (E0, $pins:expr) => {
        crate::stepper_driver::StepperDriver::E0(crate::stepper_driver::E0 {
            enable_pin: $pins.d24.into_output(),
            direction_pin: $pins.d28.into_output(),
            step_pin: $pins.d26.into_output(),
            state: crate::stepper_driver::StepperDriverState::default(),
        })
    };

    // The stepper motor on the E1 stepper driver
    (E1, $pins:expr) => {
        crate::stepper_driver::StepperDriver::E1(crate::stepper_driver::E1 {
            enable_pin: $pins.d30.into_output(),
            direction_pin: $pins.d34.into_output(),
            step_pin: $pins.d36.into_output(),
            state: crate::stepper_driver::StepperDriverState::default(),
        })
    };

    // The stepper motor on the X stepper driver
    (X, $pins:expr) => {
        crate::stepper_driver::StepperDriver::X(crate::stepper_driver::X {
            enable_pin: $pins.d38.into_output(),
            direction_pin: $pins.a1.into_output(),
            step_pin: $pins.a0.into_output(),
            state: crate::stepper_driver::StepperDriverState::default(),
        })
    };

    // The stepper motor on the Y stepper driver
    (Y, $pins:expr) => {
        crate::stepper_driver::StepperDriver::Y(crate::stepper_driver::Y {
            enable_pin: $pins.a2.into_output(),
            direction_pin: $pins.a7.into_output(),
            step_pin: $pins.a6.into_output(),
            state: crate::stepper_driver::StepperDriverState::default(),
        })
    };

    // The stepper motor on the Z stepper driver
    (Z, $pins:expr) => {
        crate::stepper_driver::StepperDriver::Z(crate::stepper_driver::Z {
            enable_pin: $pins.a8.into_output(),
            direction_pin: $pins.d48.into_output(),
            step_pin: $pins.d46.into_output(),
            state: crate::stepper_driver::StepperDriverState::default(),
        })
    };
}

/// The macro to dispatch using the stepper driver enum.
/// This is simply a wrapper around the enum dispatch macro
/// so that there's no need to keep writing the enum
/// and the enum variants.
macro_rules! stepper_driver_dispatch {
    ($match_variable:ident, |$enum_variant_obj:ident| $body:block) => {
        enum_dispatch!(
            $match_variable,
            StepperDriver,
            E0,
            E1,
            X,
            Y,
            Z,
            |$enum_variant_obj| $body
        )
    };
}

/// Implementation of the stepper motor driver
impl StepperDriver {
    //

    /// The function to enable the motor (pin change).
    /// Somehow, the enable pin when set to low enables the stepper motor,
    /// not when it is set to high.
    pub fn enable(&mut self) {
        stepper_driver_dispatch!(self, |driver| {
            driver.enable_pin.set_low();
            driver.state.enabled = true;
        })
    }

    /// The function to disable the motor (pin change)
    /// Somehow, the enable pin when set to high disables the stepper motor,
    /// not when it is set to low.
    pub fn disable(&mut self) {
        stepper_driver_dispatch!(self, |driver| {
            driver.enable_pin.set_high();
            driver.state.enabled = false;
        })
    }

    /// The function to get whether the motor is enabled
    pub fn is_enabled(&self) -> bool {
        stepper_driver_dispatch!(self, |driver| { driver.state.enabled })
    }

    /// The function to get the current position
    pub fn current_position(&self) -> i32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_position
        })
    }

    /// The function to set the current position
    pub fn set_current_position(&mut self, new_position: i32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_position = new_position
        })
    }

    /// The function to increment the current position by a given value
    fn increment_current_position(&mut self, increment: u32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_position += increment as i32
        })
    }

    /// The function to decrement the current position
    fn decrement_current_position(&mut self, decrement: u32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_position -= decrement as i32
        })
    }

    /// The function to reset the current position to a position given
    pub fn reset_current_position(&mut self, new_position: i32) {
        stepper_driver_dispatch!(self, |driver| {
            //

            // Set the target position to the new position
            driver.state.target_position = new_position;

            // Set the current position to the new position
            driver.state.current_position = new_position;

            // Set the step number to 0
            driver.state.step_number = 0;

            // Set the step interval to 0
            driver.state.step_interval_in_us = 0;

            // Set the speed to 0
            driver.state.speed = 0.0;
        })
    }

    /// The function to move the stepper motor one step
    fn step(&mut self) {
        //

        // Use the stepper driver dispatch macro to get the driver
        stepper_driver_dispatch!(self, |driver| {
            //

            // Get the current direction of the stepper motor
            let current_direction = driver.state.direction;

            // Match statement to set the direction pin according
            // to the current stepper motor direction.
            //
            // Setting the direction pin should be done first
            // to prevent rogue pulses.
            match current_direction {
                Direction::Clockwise => driver.direction_pin.set_high(),
                Direction::AntiClockwise => driver.direction_pin.set_low(),
            }

            // Set the step pin to high
            driver.step_pin.set_high();

            // Delay the minimum pulse width in microseconds
            arduino_hal::delay_us(driver.state.minimum_pulse_width_in_us);

            // Set the step pin to low again
            driver.step_pin.set_low();
        })
    }

    /// The function to move the motor one step in the clockwise direction.
    /// The function returns the current position of the motor.
    pub fn step_forward(&mut self) -> i32 {
        //

        // Increment the current position by 1
        self.increment_current_position(1);

        // Step the motor by 1 step
        self.step();

        // Set the previous step time
        self.set_previous_step_time_in_us(micros());

        // Return the current position
        return self.current_position();
    }

    /// The function to move the motor one step
    /// in the anti-clockwise direction.
    /// The function returns the current position of the motor.
    pub fn step_backward(&mut self) -> i32 {
        //

        // Decrement the current position by 1
        self.decrement_current_position(1);

        // Step the motor by 1 step
        self.step();

        // Set the previous step time
        self.set_previous_step_time_in_us(micros());

        // Return the current position
        return self.current_position();
    }

    /// The function to get the target position
    pub fn target_position(&self) -> i32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.target_position
        })
    }

    /// The function to set the target position
    fn set_target_position(&mut self, target_position: i32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.target_position = target_position
        })
    }

    /// The function to get the minimum pulse width in microseconds
    pub fn minimum_pulse_width_in_us(&self) -> u32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.minimum_pulse_width_in_us
        })
    }

    /// The function to set the minimum pulse width
    pub fn set_minimum_pulse_width_in_us(
        &mut self,
        new_minimum_pulse_width_in_us: u32,
    ) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.minimum_pulse_width_in_us =
                new_minimum_pulse_width_in_us
        })
    }

    /// The function to get the number of steps to go before
    /// reaching the target position.
    /// A positive value means the target position is clockwise
    /// from the current location,
    /// while a negative value means the target position is
    /// anti-clockwise from the current location.
    pub fn distance_to_go(&self) -> i32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.target_position - driver.state.current_position
        })
    }

    /// The function to get the direction of the stepper motor
    fn direction(&self) -> Direction {
        stepper_driver_dispatch!(self, |driver| { driver.state.direction })
    }

    /// The function to set the direction of the stepper motor
    fn set_direction(&mut self, new_direction: Direction) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.direction = new_direction
        })
    }

    /// The function to get the step interval in microseconds
    pub fn step_interval_in_us(&self) -> u32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.step_interval_in_us
        })
    }

    /// The function to set the step interval in microseconds
    fn set_step_interval_in_us(&mut self, new_step_interval_in_us: u32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.step_interval_in_us = new_step_interval_in_us
        })
    }

    /// The function to get the step number
    fn step_number(&self) -> i32 {
        stepper_driver_dispatch!(self, |driver| { driver.state.step_number })
    }

    /// The function to set the step number
    fn set_step_number(&mut self, new_step_number: i32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.step_number = new_step_number
        })
    }

    /// The function to increment the step number by a given value
    fn increment_step_number(&mut self, increment: u32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.step_number += increment as i32
        })
    }

    /// The function to get the initial step interval in microseconds
    fn initial_step_interval_in_us(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.initial_step_interval_in_us
        })
    }

    /// The function to get the current step interval in microseconds
    fn current_step_interval_in_us(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_step_interval_in_us
        })
    }

    /// The function to set the current step interval in microseconds
    fn set_current_step_interval_in_us(
        &mut self,
        new_current_step_interval_in_us: f32,
    ) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.current_step_interval_in_us =
                new_current_step_interval_in_us
        })
    }

    /// The function to get the minimum step interval in microseconds
    fn minimum_step_interval_in_us(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.minimum_step_interval_in_us
        })
    }

    /// The function to get the time of the previous motor step
    fn previous_step_time_in_us(&self) -> u32 {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.previous_step_time_in_us
        })
    }

    /// The function to set the time of the previous motor step
    fn set_previous_step_time_in_us(&mut self, new_time: u32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.previous_step_time_in_us = new_time
        })
    }

    /// The function to set the step resolution
    pub fn set_step_resolution(&mut self, new_step_resolution: StepResolution) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.step_resolution = new_step_resolution
        })
    }

    /// The function to get the motor speed in steps/s
    pub fn speed(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| { driver.state.speed })
    }

    /// The function to set the motor speed in steps/s
    fn set_speed(&mut self, new_speed: f32) {
        stepper_driver_dispatch!(self, |driver| {
            driver.state.speed = new_speed
        })
    }

    /// The function to get the maximum speed in steps/s
    pub fn maximum_speed(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| { driver.state.maximum_speed })
    }

    /// The function to get the acceleration of the motor in steps/^2
    pub fn acceleration(&self) -> f32 {
        stepper_driver_dispatch!(self, |driver| { driver.state.acceleration })
    }

    /// The function to set a constant motor speed in steps/s
    pub fn set_constant_speed(&mut self, new_constant_speed: f32) {
        //

        // If the new speed given is the same as the current one,
        // exit the function to skip the calculations below.
        if new_constant_speed == self.speed() {
            return;
        }

        // Otherwise, clamp the given constant speed
        // down to be within the maximum speed set, in both directions.
        // The speed being negative means the direction is anti-clockwise.
        let new_constant_speed = new_constant_speed
            .clamp(-self.maximum_speed(), self.maximum_speed());

        // If the new constant speed given is zero,
        // then set the step interval to 0
        if new_constant_speed == 0.0 {
            self.set_step_interval_in_us(0);
        }
        //

        // Otherwise, a non-zero constant speed is given
        else {
            //

            // Calculate the step interval by getting the reciprocal of
            // the given constant speed
            // and multiplying it by 1,000,000 to turn it into
            // microseconds per step
            self.set_step_interval_in_us(
                (1_000_000.0 / new_constant_speed).abs() as u32,
            );

            // Set the direction depending on whether the speed is positive
            // or negative.
            //
            // If the speed is positive, set it to clockwise, otherwise,
            // set the direction to anti-clockwise.
            self.set_direction(if new_constant_speed > 0.0 {
                Direction::Clockwise
            } else {
                Direction::AntiClockwise
            });
        }

        // Set the speed to the new constant speed given
        self.set_speed(new_constant_speed);
    }

    /// The function to compute the new speed of the motor.
    ///
    /// This returns the interval between the next step
    /// of the stepper motor in microseconds.
    pub fn calculate_new_speed(&mut self) -> u32 {
        //

        // Get the distance to go
        let distance_to_go = self.distance_to_go();

        // Get the speed and the acceleration
        let (speed, acceleration) = (self.speed(), self.acceleration());

        // If the acceleration is 0,
        // return the step interval and exit the function
        if acceleration == 0.0 {
            return self.step_interval_in_us();
        }

        // Calculate the number of steps needed to stop moving.
        // Uses equation 16 from the PDF file.
        let steps_to_stop_moving =
            ((speed * speed) / (2.0 * acceleration)) as i32;

        // If the distance to go is 0 and the steps to stop
        // is less than or equal to 1.
        // That means we are at the target and it's time to stop.
        if distance_to_go == 0 && steps_to_stop_moving <= 1 {
            //

            // Call the stepper driver dispatch macro
            // to access the state of the motor driver.
            stepper_driver_dispatch!(self, |driver| {
                //

                // Set the step interval to 0
                driver.state.step_interval_in_us = 0;

                // Set the speed to 0
                driver.state.speed = 0.0;

                // Set the step number to 0
                driver.state.step_number = 0;
            });

            // Return the step interval in microseconds
            return self.step_interval_in_us();
        }

        // Otherwise, if the distance to go is more than 0,
        // this means that we are anti-clockwise with respect
        // to the target position, and need to move clockwise.
        if distance_to_go > 0 {
            //

            // If the step number is greater than zero,
            // that means we are currently accelerating.
            if self.step_number() > 0 {
                //

                // If the number of steps to stop moving is greater than
                // or equal to the distance to go,
                // or if the direction is wrong (anti-clockwise),
                // start decelerating by setting the step number to the
                // negative of the number of steps to stop.
                if steps_to_stop_moving >= distance_to_go
                    || self.direction() == Direction::AntiClockwise
                {
                    self.set_step_number(-steps_to_stop_moving);
                }
            }
            //

            // Otherwise, if the step number is less than 0,
            // that means we are currently decelerating.
            else if self.step_number() < 0 {
                //

                // If the steps to stop moving is less than the distance to go,
                // and the direction is in the correct direction (clockwise),
                // set the step number to the absolute value of the current
                // step number. Basically, just make the step number
                // positive to start accelerating again.
                if steps_to_stop_moving < distance_to_go
                    && self.direction() == Direction::Clockwise
                {
                    self.set_step_number(-self.step_number());
                }
            }
        }
        //

        // Otherwise, if the distance to go is less than zero,
        // that means that we are clockwise with respect
        // to the target position, and need to move anti-clockwise.
        else if distance_to_go < 0 {
            //

            // If the step number is more than 0,
            // that means we are currently accelerating.
            if self.step_number() > 0 {
                //

                // If the number of steps to stop moving
                // is more than or equal to the negative of
                // the distance to go (distance to go is negative),
                // or if the direction is wrong (clockwise),
                // start decelerating by setting the step number to the
                // negative of the number of steps to stop.
                if steps_to_stop_moving >= -distance_to_go
                    || self.direction() == Direction::Clockwise
                {
                    self.set_step_number(-steps_to_stop_moving);
                }
            }
            //

            // Otherwise, if the step number is less than 0,
            // that means we are currently decelerating.
            else if self.step_number() < 0 {
                //

                // If the steps to stop moving is less than the distance to go,
                // and the direction is in the right direction (anti-clockwise),
                // set the step number to the absolute value of the current
                // step number. Basically, just make the step number
                // positive to start accelerating again.
                if steps_to_stop_moving < distance_to_go
                    && self.direction() == Direction::AntiClockwise
                {
                    self.set_step_number(-self.step_number());
                }
            }
        }

        // If the step number is 0,
        // that means there's a need to accelerate or decelerate.
        if self.step_number() == 0 {
            //

            // The motor is starting from the stopped or rest position,
            // so we use the initial step interval.
            self.set_current_step_interval_in_us(
                self.initial_step_interval_in_us(),
            );

            // Set the direction of the based on the distance to go.
            // If the distance to go is positive, the direction is clockwise.
            // Otherwise, the direction is anti-clockwise.
            self.set_direction(if self.distance_to_go() > 0 {
                Direction::Clockwise
            } else {
                Direction::AntiClockwise
            });
        }
        //

        // Otherwise, the motor is in the step after the first step
        else {
            //

            // Pull out the variables needed to compute
            // the current step interval
            let c_n = self.current_step_interval_in_us();
            let n = self.step_number() as f32;

            // Compute the current step interval using equation 13
            // from the PDF file
            let mut new_step_interval = c_n - ((2.0 * c_n) / ((4.0 * n) + 1.0));

            // Get the maximum value between the new step interval
            // and the minimum step interval
            new_step_interval =
                new_step_interval.max(self.minimum_step_interval_in_us());

            // Set the new step interval to the current step interval
            self.set_current_step_interval_in_us(new_step_interval);
        }

        // Increment the step number
        self.increment_step_number(1);

        // Otherwise, set the step interval to the current step interval
        self.set_step_interval_in_us(self.current_step_interval_in_us() as u32);

        // If the step interval is 0,
        if self.step_interval_in_us() == 0 {
            //

            // Set the speed to 0
            self.set_speed(0.0);

            // Return the step interval in microseconds
            return self.step_interval_in_us();
        }

        // Otherwise, set the new speed to the reciprocal of
        // the current step interval which is in microseconds per step,
        // to get the speed in steps per microsecond,
        // then multiply it by 1,000,000 to get the speed in steps/s
        self.set_speed(1_000_000.0 / self.current_step_interval_in_us());

        // If the direction is anti-clockwise,
        // set the speed to be negative of the current speed
        // to move in the anti-clockwise direction.
        if self.direction() == Direction::AntiClockwise {
            self.set_speed(-self.speed());
        }

        // Return the step interval in microseconds
        return self.step_interval_in_us();
    }

    /// The function to set the maximum speed of the motor in steps/s.
    /// This maximum speed is the speed that the motor will
    /// accelerate up to.
    pub fn set_maximum_speed(&mut self, new_maximum_speed: f32) {
        //

        // Initialise the variable to store the new maximum speed
        let mut new_maximum_speed = new_maximum_speed;

        // If the maximum speed given is negative,
        // set the speed to positive.
        if new_maximum_speed < 0.0 {
            new_maximum_speed = -new_maximum_speed;
        }

        // If the current maximum speed is the same as the given maximum speed,
        // then exit the function
        if new_maximum_speed == self.maximum_speed() {
            return;
        }

        // Otherwise, use the stepper driver dispatch macro
        // to access the state.
        stepper_driver_dispatch!(self, |driver| {
            //

            // Set the maximum speed to the given maximum speed
            driver.state.maximum_speed = new_maximum_speed;

            // Recompute the minimum step interval,
            // which is the time interval between two steps when
            // the motor has reached its maximum speed.
            //
            // It is the reciprocal of the new maximum speed
            // multiplied by 1,000,000 to convert it to microseconds.
            //
            // If the new maximum speed is 0,
            // set the minimum step interval to 0
            driver.state.minimum_step_interval_in_us =
                if new_maximum_speed == 0.0 {
                    0.0
                } else {
                    1_000_000.0 / new_maximum_speed
                };
        });

        // If the step number is zero or negative,
        // which means we are decelerating or stopped,
        // exit the function.
        if self.step_number() <= 0 {
            return;
        }

        // Otherwise, we want to recompute the step number
        // so that we can accelerate to
        // this new maximum speed that has been set.

        // Get the current motor speed
        let current_motor_speed = self.speed();

        // Get the acceleration
        let acceleration = self.acceleration();

        // If the acceleration is 0, exit the function
        if acceleration == 0.0 {
            return;
        }

        // Recompute the step number by using equation 16
        // from the PDF file.
        let new_step_number = ((current_motor_speed * current_motor_speed)
            / (2.0 * acceleration)) as i32;

        // Set the step number to the new step number
        self.set_step_number(new_step_number);

        // Call the function to calculate the new motor speed
        self.calculate_new_speed();
    }

    /// The function to set the acceleration of the motor.
    /// This function call is expensive due to having to compute
    /// a square root, so avoid calling this function if possible.
    pub fn set_acceleration(&mut self, new_acceleration: f32) {
        //

        // If the acceleration given is 0, then just exit the function
        if new_acceleration == 0.0 {
            return;
        }

        // Initialise the variable to store the new acceleration
        let mut new_acceleration = new_acceleration;

        // If the acceleration given is negative, then set it to positive
        if new_acceleration < 0.0 {
            new_acceleration = -new_acceleration;
        }

        // Get the current acceleration
        let current_acceleration = self.acceleration();

        // If the acceleration given is the same as the current acceleration,
        // exit the function as we don't want to waste time computing
        // a square root.
        if new_acceleration == current_acceleration {
            return;
        }

        // Otherwise, we need to recompute the step number
        // using equation 17 from the PDF file.
        let new_step_number = (self.step_number() as f32
            * (current_acceleration / new_acceleration))
            as i32;

        // Compute the new minimum step interval in microseconds
        // using equation 7, with the correction from equation 15
        // in the PDF file.
        // The result is multiplied by 1,000,000 to convert it to microseconds
        let new_initial_step_interval_in_us =
            0.676 * (2.0 / new_acceleration).sqrt() * 1_000_000.0;

        // Use the stepper driver dispatch macro to access the state
        stepper_driver_dispatch!(self, |driver| {
            //

            // Set the step number to the new step number
            driver.state.step_number = new_step_number;

            // Set the initial step interval to the new one
            driver.state.initial_step_interval_in_us =
                new_initial_step_interval_in_us;

            // Set the acceleration to the new acceleration
            driver.state.acceleration = new_acceleration;
        });

        // Calculate the new motor speed required for the new acceleration
        self.calculate_new_speed();
    }

    /// The function to move to an absolute position.
    /// A positive absolute position is clockwise
    /// from the initial motor position,
    /// and a negative absolute position is anticlockwise
    /// from the initial motor position.
    pub fn move_to_absolute_position(
        &mut self,
        new_absolute_position: i32,
        constant_speed: bool,
    ) {
        //

        // If the target position is the same as the given position,
        // exit the function.
        if self.target_position() == new_absolute_position {
            return;
        }

        // Otherwise, set the target position to the new absolute position
        self.set_target_position(new_absolute_position);

        // If the constant speed flag is true,
        // exit the function.
        if constant_speed {
            return;
        }

        // Otherwise, recalculate the speed to reach the new target position
        self.calculate_new_speed();
    }

    /// The function to move the motor by a given number of steps.
    /// A positive number of steps means move the motor clockwise
    /// by the given number of steps, and a negative number of steps
    /// means to move the motor anticlockwise by the given number of steps.
    pub fn move_by_steps(
        &mut self,
        number_of_steps: i32,
        constant_speed: bool,
    ) {
        //

        // Call the function to move to the absolute position
        // set by the current position
        // plus the given number of steps
        self.move_to_absolute_position(
            self.current_position() + number_of_steps,
            constant_speed,
        );
    }

    /// The function to run the motor at constant speed.
    /// The speed that the motor runs at is the speed set
    /// by the most recent call to the set_constant_speed function.
    ///
    /// If there is no call to the set_constant_speed function.
    /// It will use the most recent speed computed
    /// by the calculate_new_speed function.
    ///
    /// This function must be called at least once per step,
    /// preferably in the main loop.
    /// This function returns whether a step has been taken by the motor.
    pub fn run_at_constant_speed(&mut self) -> bool {
        //

        // If there is no step interval, return false
        if self.step_interval_in_us() == 0 {
            return false;
        }

        // Otherwise, get the current time in microseconds
        let current_time_in_us = micros();

        // Get the previous step time
        let previous_step_time_in_us = self.previous_step_time_in_us();

        // Get the difference between the current time
        // and the previous step time
        let time_difference_in_us = match current_time_in_us
            .checked_sub(previous_step_time_in_us)
        {
            Some(value) => value,
            None => {
                println!("Integer overflow: current time - previous step time");
                return false;
            }
        };

        // If the time difference in microseconds is smaller than
        // the step interval, return false
        if time_difference_in_us < self.step_interval_in_us() {
            return false;
        }

        // Otherwise, the current time minus the last step time is more
        // than or equal to the step interval,
        // so we increment or decrement the current position
        // based on the current direction of the motor
        match self.direction() {
            Direction::Clockwise => self.increment_current_position(1),
            Direction::AntiClockwise => self.decrement_current_position(1),
        }

        // Move the motor one step
        self.step();

        // Set the previous step time to the current time
        self.set_previous_step_time_in_us(micros());

        // Return true to signify that a step has been taken
        return true;
    }

    /// The function to run the motor.
    /// This run function implements acceleration to get to the
    /// target position instead of running the motor at constant speed.
    ///
    /// This function must be called at least once per step,
    /// preferably in the main loop.
    ///
    /// This function returns whether the motor is still on the
    /// way to the target position.
    pub fn run(&mut self) -> bool {
        //

        // Calls the run at constant speed function
        // to run using the speed that has already been calculated
        // in the previous call of this function.
        //
        // If a step has been taken, recalculate the motor speed
        if self.run_at_constant_speed() {
            self.calculate_new_speed();
        }

        // Returns true if the speed is not 0 (the motor is still moving)
        // or if the distance to go is not 0 (the motor still needs to move)
        return self.speed() != 0.0 || self.distance_to_go() != 0;
    }

    /// The function to stop the motor
    pub fn stop(&mut self, constant_speed: bool) {
        //

        // Get the speed of the motor
        let speed = self.speed();

        // If the current speed is zero, that means the motor has stopped,
        // so exit the function
        if speed == 0.0 {
            return;
        }

        // Reset the current position
        self.reset_current_position(0);

        // If the constant speed flag is true
        if constant_speed {
            //

            // Set the constant speed to 0
            self.set_constant_speed(0.0);

            // Exit the function
            return;
        }

        // Otherwise, the motor needs to stop,
        // so calculate the number of steps to stop moving
        // using equation 16 from the PDF file.
        // We add 1 to account for integer rounding.
        let steps_to_stop_moving =
            ((speed * speed) / (2.0 * self.acceleration())) as i32 + 1;

        // If the speed is positive
        if speed > 0.0 {
            //

            // Move the number of steps to stop moving
            self.move_by_steps(steps_to_stop_moving, false);
        }
        //

        // Otherwise, the speed is negative
        else {
            //

            // Move by the negative of the number of steps to stop moving
            self.move_by_steps(steps_to_stop_moving, false);
        }
    }

    /// The function to run the motor until the target position is reached.
    /// This function BLOCKS, so this should not be called in a loop.
    pub fn run_until_target_position_is_reached(&mut self) {
        //

        // If the program is stopped,
        // exit the function
        if program_stopped() {
            return;
        }

        // Run the motor until the target position is reached
        while self.run() {
            //

            // If the program is stopped
            if program_stopped() {
                //

                // Stop the motor
                self.stop(false);

                // Exit the function
                return;
            }
        }
    }

    /// The function to run at a constant speed to the target position.
    /// This function returns true if a step has been taken by the motor,
    /// just like the run_at_constant_speed function.
    pub fn run_at_constant_speed_to_target_position(&mut self) -> bool {
        //

        // If the target position is the same as the current position,
        // then return false immediately.
        if self.target_position() == self.current_position() {
            return false;
        }

        // Otherwise, check if the current position is greater
        // than the target position, which means that
        // the motor is anti-clockwise with respect to the target position
        // and needs to move clockwise.
        if self.target_position() > self.current_position() {
            //

            // Set the direction to clockwise
            self.set_direction(Direction::Clockwise);
        }
        //

        // Otherwise, the current position is less than the target position,
        // which means that the motor is clockwise with respect to
        // the target position and needs to move anti-clockwise.
        else {
            //

            // Set the direction to anti-clockwise
            self.set_direction(Direction::AntiClockwise);
        }

        // Return the result of the run_at_constant_speed
        return self.run_at_constant_speed();
    }

    /// The function to run until the given position is reached.
    /// This function BLOCKS, so it shouldn't be called in a loop.
    pub fn run_until_given_position_is_reached(
        &mut self,
        new_absolute_position: i32,
    ) {
        //

        // Move to the new absolute position
        self.move_to_absolute_position(new_absolute_position, false);

        // Call the function to run until the target position is reached
        self.run_until_target_position_is_reached();
    }

    /// The function to return if the motor is running
    pub fn is_running(&self) -> bool {
        //

        // If the speed is zero and the target position and the
        // current position are the same, that means the motor is not running.
        // So return the inverse of that.
        return !(self.speed() == 0.0
            && self.target_position() == self.current_position());
    }
}

pub(crate) use new_stepper_driver;
