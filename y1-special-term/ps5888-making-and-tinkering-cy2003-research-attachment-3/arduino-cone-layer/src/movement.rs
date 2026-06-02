// The module to handle the movement of the cone layer
//
// References:
// https://drive.google.com/drive/folders/1RO-_eqV296sZPlzBsY5cTNpsorFjTUqY

use core::iter::Chain;
use core::iter::Once;
use heapless::Vec;

use crate::{
    console::println, constants::ALTERNATE_MOTORS, serial::program_stopped,
    serial::UsartWriterInterface, stepper_driver::StepperDriver,
};

/// The radius of the joypad
/// used for the joystick.
///
/// This value needs to be updated
/// when the joypad radius on the
/// phone application is changed.
const JOYPAD_RADIUS: i16 = 150;

/// The threshold to consider the joystick
/// to be moving the cone layer forward
const Y_AXIS_FORWARD_THRESHOLD: i16 = JOYPAD_RADIUS;

/// The threshold to consider the joystick
/// to be moving the cone layer backwards
const Y_AXIS_BACKWARD_THRESHOLD: i16 = JOYPAD_RADIUS;

/// The maximum value for the Y axis.
/// The negative of this value is the minimum
/// value of the Y axis.
const Y_AXIS_MAX: i16 = 300;

/// The threshold to consider the joystick
/// to be moving the cone layer to the left
const X_AXIS_LEFT_THRESHOLD: i16 = JOYPAD_RADIUS;

/// The threshold to consider the joystick
/// to be moving the cone layer to the right
const X_AXIS_RIGHT_THRESHOLD: i16 = JOYPAD_RADIUS;

/// The maximum value for the X axis.
/// The negative of this value is the minimum
/// value of the X axis.
const X_AXIS_MAX: i16 = 300;

/// The maximum speed of the motor when the joystick is used
/// in steps per second.
/// 5000 steps per second is the theoretical maximum speed of
/// the motor drivers.
/// The current practical maximum speed of the motor driver
/// is 470 steps per second.
const JOYSTICK_CONTROL_MAX_SPEED: i16 = 500;

// The maximum motor speed difference between the motors
const MAXIMUM_MOTOR_SPEED_DIFFERENCE: i16 = 100;

/// The acceleration of the motors
/// in steps per second squared.
const ACCELERATION: f32 = 1000.0;

/// The maximum speed for laying cones in steps per second
const MAXIMUM_SPEED_FOR_LAYING_CONES: f32 = 500.0;

/// The default speed for dropping a cone in steps per second
const DEFAULT_SPEED_FOR_DROPPING_CONE: i16 = 50;

/// The number of milliseconds to continue moving for
/// when controlling the movement motors with the joystick
const MILLISECONDS_TO_CONTINUE_MOVING_FOR: i32 = 250;

/// The wheel diameter in centimetres
const WHEEL_DIAMETER_IN_CM: f32 = 6.8;

/// The angle of a single step
const STEP_ANGLE_IN_DEGREES: f32 = 1.8;

/// The number of step per revolution
const NUMBER_OF_STEPS_PER_REVOLUTION: f32 = 360.0 / STEP_ANGLE_IN_DEGREES;

/// The distance travelled in one step
const STEP_DISTANCE_IN_CM: f32 = (WHEEL_DIAMETER_IN_CM / 2.0)
    * (STEP_ANGLE_IN_DEGREES * (core::f32::consts::PI / 180.0));

/// The buffer percentage for the motors
const BUFFER_PERCENTAGE: f32 = 0.10;

/// The number of buffer steps for the dispenser motor
const DISPENSER_MOTOR_BUFFER_STEPS: i16 =
    (BUFFER_PERCENTAGE * NUMBER_OF_STEPS_PER_REVOLUTION as f32) as i16;

/// The default dispenser speed to drop a cone
/// in steps per second
const DISPENSER_MOTOR_DEFAULT_SPEED: f32 = 100.0;

/// The struct to contain the arguments for the handle_joystick function
pub struct HandleJoystickArgs {
    pub x_coordinate: i16,
    pub y_coordinate: i16,
}

/// The struct to contain the arguments
/// for the lay_cones_in_a_straight_line function
pub struct LayConesInAStraightLineArgs {
    pub cone_spacing_in_cm: i16,
    pub number_of_cones_to_lay: i16,
}

/// The struct to contain the arguments for the drop_cone function
pub struct DropConeArgs {
    pub dispenser_motor_speed: i16,
}

/// The enum for the commands that the arduino cone layer can handle
pub enum Command {
    HandleJoystick(HandleJoystickArgs),
    LayConesInAStraightLine(LayConesInAStraightLineArgs),
    DropCone(DropConeArgs),
    Stop,
}

/// The struct of the movement handler
pub struct MovementHandler {
    left_side_motors: Vec<StepperDriver, 2>,
    right_side_motors: Vec<StepperDriver, 2>,
    dispenser_motor: StepperDriver,
}

/// The function to map a value from one range to another
fn map_range(
    value: i16,
    old_range_min: i16,
    old_range_max: i16,
    new_range_min: i16,
    new_range_max: i16,
) -> i16 {
    //

    // If the given value is equal to the end of the old range,
    // return the end of the new range.
    if value == old_range_max {
        return new_range_max;
    }

    // Otherwise, set the value to add when finding the new range
    // so that the new range maps properly to the old range
    let range_correction = if new_range_min >= new_range_max {
        1
    } else {
        -1
    };

    // Calculate the value in the new range
    let new_value = ((value - old_range_min) as i32
        * (new_range_max - new_range_min + range_correction) as i32
        / (old_range_max - old_range_min) as i32)
        + new_range_min as i32;

    // Return the value in the new range
    return new_value as i16;
}

/// The implementation of the movement handler
impl MovementHandler {
    //

    /// The function to create a new instance of the movement handler
    pub fn new(
        left_side_motors: Vec<StepperDriver, 2>,
        right_side_motors: Vec<StepperDriver, 2>,
        dispenser_motor: StepperDriver,
        enable_movement_motors: bool,
        enable_dispenser_motors: bool,
    ) -> Self {
        //

        // Initialise the movement handler
        let mut movement_handler = Self {
            left_side_motors,
            right_side_motors,
            dispenser_motor,
        };

        // Set the acceleration to the joystick control acceleration
        movement_handler.all_motors_do(|driver| {
            driver.set_acceleration(ACCELERATION);
        });

        // Enable the movement motors if the enable_movement_motors
        // flag is true and disable them otherwise
        if enable_movement_motors {
            movement_handler.enable_all_motors();
        } else {
            movement_handler.disable_movement_motors();
        }

        // Enable the dispenser motor if the enable_dispenser_motors
        // flag is true and disable it otherwise
        if enable_dispenser_motors {
            movement_handler.dispenser_motor.enable();
        } else {
            movement_handler.dispenser_motor.disable();
        }

        // Return the movement handler
        return movement_handler;
    }

    /// The function to execute a function for the left side motors
    fn left_side_motors_do<Closure>(&mut self, closure: Closure)
    where
        Closure: Fn(&mut StepperDriver),
    {
        //

        // Iterate over all of the left side motors
        for motor in self.left_side_motors.iter_mut() {
            //

            // Execute the closure on the motor
            closure(motor);
        }
    }

    /// The function to execute a function for the right side motors
    fn right_side_motors_do<Closure>(&mut self, closure: Closure)
    where
        Closure: Fn(&mut StepperDriver),
    {
        //

        // Iterate over all of the left side motors
        for motor in self.right_side_motors.iter_mut() {
            //

            // Execute the closure on the motor
            closure(motor);
        }
    }

    /// The function to return an iterator over all of the movement motors
    fn iter_movement_motors(
        &mut self,
        run_right_motors_first: bool,
    ) -> Chain<
        core::slice::IterMut<'_, StepperDriver>,
        core::slice::IterMut<'_, StepperDriver>,
    > {
        //

        // If running the right side motors first,
        // return the right side motors chained
        // with the left side motors
        if run_right_motors_first {
            return self
                .right_side_motors
                .iter_mut()
                .chain(self.left_side_motors.iter_mut());
        }

        // Otherwise, return the left side motors
        // chained with the right side motors
        return self
            .left_side_motors
            .iter_mut()
            .chain(self.right_side_motors.iter_mut());
    }

    /// The function to execute a function for the movement motors
    fn movement_motors_do<Closure>(
        &mut self,
        closure: Closure,
        alternate_motors: bool,
    ) where
        Closure: Fn(&mut StepperDriver),
    {
        //

        // Initialise the boolean to store whether to run
        // the right side motors first
        let mut run_right_motors_first = false;

        // Iterate over all of the movement motors
        for motor in self.iter_movement_motors(run_right_motors_first) {
            //

            // Execute the closure on the motor
            closure(motor);

            // If alternating the motors is wanted,
            // set the run_right_motors_first variable to
            // the opposite of its current value
            if alternate_motors {
                run_right_motors_first = !run_right_motors_first;
            }
        }
    }

    /// The function to return an iterator over all of the motors
    pub fn iter_all_motors(
        &mut self,
    ) -> Chain<
        Chain<
            core::slice::IterMut<'_, StepperDriver>,
            core::slice::IterMut<'_, StepperDriver>,
        >,
        Once<&mut StepperDriver>,
    > {
        return self
            .left_side_motors
            .iter_mut()
            .chain(self.right_side_motors.iter_mut())
            .chain(core::iter::once(&mut self.dispenser_motor));
    }

    /// The function to execute a function for the right side motors
    fn all_motors_do<Closure>(&mut self, closure: Closure)
    where
        Closure: Fn(&mut StepperDriver),
    {
        //

        // Iterate over all of the motors
        for motor in self.iter_all_motors() {
            //

            // Execute the closure on the motor
            closure(motor);
        }
    }

    /// The function to enable all of the motors
    pub fn enable_all_motors(&mut self) {
        self.all_motors_do(|driver| driver.enable());
    }

    /// The function to enable the left side motors
    pub fn enable_left_side_motors(&mut self) {
        self.left_side_motors_do(|driver| driver.enable());
    }

    /// The function to enable the right side motors
    pub fn enable_right_side_motors(&mut self) {
        self.right_side_motors_do(|driver| driver.enable());
    }

    /// The function to enable the movement motors
    pub fn enable_movement_motors(&mut self) {
        //

        // Enable the left side motors
        self.enable_left_side_motors();

        // Enable the right side motors
        self.enable_right_side_motors();
    }

    /// The function to disable all of the motors
    pub fn disable_all_motors(&mut self) {
        self.all_motors_do(|driver| driver.disable());
    }

    /// The function to disable the left side motors
    pub fn disable_left_side_motors(&mut self) {
        self.left_side_motors_do(|driver| driver.disable());
    }

    /// The function to disable the right side motors
    pub fn disable_right_side_motors(&mut self) {
        self.right_side_motors_do(|driver| driver.disable());
    }

    /// The function to disable the movement motors
    pub fn disable_movement_motors(&mut self) {
        //

        // Disable the left side motors
        self.disable_left_side_motors();

        // Disable the right side motors
        self.disable_right_side_motors();
    }

    /// The function to check if the left side motors are enabled
    pub fn left_side_motors_are_enabled(&self) -> bool {
        //

        // Initialise the variable to store whether
        // the left side motors are enabled
        let mut left_side_motors_enabled = false;

        // Iterate over all of the left side motors
        for motor in self.left_side_motors.iter() {
            //

            // If the motor is enabled,
            // set the left side motors enabled variable to true
            if motor.is_enabled() {
                left_side_motors_enabled = true;
            }
        }

        // Return the left side motors enabled variable
        return left_side_motors_enabled;
    }

    /// The function to check if the right side motors are enabled
    pub fn right_side_motors_are_enabled(&self) -> bool {
        //

        // Initialise the variable to store whether
        // the right side motors are enabled
        let mut right_side_motors_enabled = false;

        // Iterate over all of the right side motors
        for motor in self.right_side_motors.iter() {
            //

            // If the motor is enabled,
            // set the right side motors enabled variable to true
            if motor.is_enabled() {
                right_side_motors_enabled = true;
            }
        }

        // Return the right side motors enabled variable
        return right_side_motors_enabled;
    }

    /// The function to check if the movement motors are enabled
    pub fn movement_motors_are_enabled(&self) -> bool {
        //

        // Get whether the left side motors are enabled
        let left_side_motors_enabled = self.left_side_motors_are_enabled();

        // Get whether the right side motors are enabled
        let right_side_motors_enabled = self.right_side_motors_are_enabled();

        // Return if any of the motors are enabled
        return left_side_motors_enabled || right_side_motors_enabled;
    }

    /// The function to check if all of the motors are enabled
    pub fn all_motors_are_enabled(&self) -> bool {
        //

        // Get whether the movement motors are enabled
        let movement_motors_enabled = self.movement_motors_are_enabled();

        // Get whether the dispenser motor is enabled
        let dispenser_motor_enabled = self.dispenser_motor.is_enabled();

        // Return if any of the motors are enabled
        return movement_motors_enabled || dispenser_motor_enabled;
    }

    /// The function to handle the joystick.
    ///
    /// This function takes two arguments,
    /// the x coordinate and the y coordinate
    /// as f32 floats.
    ///
    /// This function does not block execution, hence
    /// the run_movement_motors
    /// function must be called to actually run the movement motors.
    ///
    /// The enable_movement_motors must be called to enable
    /// the motors before calling this function.
    pub fn handle_joystick(
        &mut self,
        HandleJoystickArgs {
            x_coordinate,
            y_coordinate,
        }: HandleJoystickArgs,
    ) {
        //

        // Initialise the motor speed to 0
        let mut motor_speed = 0;

        // If the y coordinate is more than the forward threshold
        if y_coordinate > Y_AXIS_FORWARD_THRESHOLD {
            //

            // Get the motor speed to move forward
            motor_speed = map_range(
                y_coordinate,
                Y_AXIS_FORWARD_THRESHOLD,
                Y_AXIS_MAX,
                0,
                JOYSTICK_CONTROL_MAX_SPEED,
            );
        }
        //

        // Otherwise, if the y coordinate is less than the backward threshold
        else if y_coordinate < Y_AXIS_BACKWARD_THRESHOLD {
            //

            // Get the motor speed to move backward
            motor_speed = map_range(
                y_coordinate,
                0,
                Y_AXIS_BACKWARD_THRESHOLD,
                -JOYSTICK_CONTROL_MAX_SPEED,
                0,
            );
        }

        // Initialise the motor speed difference
        // between the left and right side motors
        let mut motor_speed_difference = 0;

        // If the x coordinate is less than the left threshold
        if x_coordinate < X_AXIS_LEFT_THRESHOLD {
            //

            // Get the motor speed difference between the left and right motors.
            // The motor speed difference should be negative for a left turn.
            motor_speed_difference = map_range(
                x_coordinate,
                0,
                X_AXIS_LEFT_THRESHOLD,
                -MAXIMUM_MOTOR_SPEED_DIFFERENCE,
                0,
            );
        }
        //

        // Otherwise, if the x coordinate is more than the right threshold
        else if x_coordinate > X_AXIS_RIGHT_THRESHOLD {
            //

            // Get the motor speed difference between the left and right motors.
            // The motor speed difference should be positive for a right turn.
            motor_speed_difference = map_range(
                x_coordinate,
                X_AXIS_RIGHT_THRESHOLD,
                X_AXIS_MAX,
                0,
                MAXIMUM_MOTOR_SPEED_DIFFERENCE,
            );
        }

        // To move left, decrease the left motor speed and
        // increase the right motor speed.
        //
        // To move right, decrease the right motor speed and
        // increase the left motor speed.

        // Get the left side motor speed.
        // Since the motor speed difference is negative when
        // moving left, the left motor speed should add
        // the motor speed difference when it is moving
        // forward and subtract the motor speed difference
        // when it is moving backward.
        let left_side_motor_speed = if motor_speed >= 0 {
            motor_speed + motor_speed_difference
        } else {
            motor_speed - motor_speed_difference
        };

        // Get the right side motor speed.
        // Since the motor speed difference is positive when
        // moving right, the right motor speed should subtract
        // the motor speed difference when it is moving
        // forward and add the motor speed difference
        // when it is moving backward.
        let right_side_motor_speed = if motor_speed >= 0 {
            motor_speed - motor_speed_difference
        } else {
            motor_speed + motor_speed_difference
        };

        // Enable the movement motors if they are disabled
        if !self.movement_motors_are_enabled() {
            self.enable_movement_motors();
        }

        // If both the left and right side motor speeds are 0,
        // then stop the movement motors and exit the function.
        if left_side_motor_speed == 0 && right_side_motor_speed == 0 {
            return self.movement_motors_do(
                |driver| driver.stop(false),
                ALTERNATE_MOTORS,
            );
        }

        // Get the number of milli steps to move for the left side motor
        let left_side_milli_steps_to_move =
            left_side_motor_speed as i32 * MILLISECONDS_TO_CONTINUE_MOVING_FOR;

        // Get the number of steps to move for the left side motor
        let left_side_steps_to_move =
            (left_side_milli_steps_to_move as f32 / 1000.0) as i32;

        // Get the number of milli steps to move for the right side motor
        let right_side_milli_steps_to_move =
            right_side_motor_speed as i32 * MILLISECONDS_TO_CONTINUE_MOVING_FOR;

        // Get the number of steps to move for the right side motor
        let right_side_steps_to_move =
            (right_side_milli_steps_to_move as f32 / 1000.0) as i32;

        // Otherwise, set the maximum speed on the left side motors
        // to the motor speed calculated for the left side motors
        // and move the motor by the motor speed number of steps.
        self.left_side_motors_do(|driver| {
            driver.reset_current_position(0);
            driver.set_maximum_speed(left_side_motor_speed as f32);
            driver.set_constant_speed(left_side_motor_speed as f32);
            driver.move_by_steps(left_side_steps_to_move, true);
        });

        // Set the maximum speed on the right side motors to the motor speed
        // calculated for the right side motors and move the motor by
        // the motor speed number of steps.
        self.right_side_motors_do(|driver| {
            driver.reset_current_position(0);
            driver.set_maximum_speed(right_side_motor_speed as f32);
            driver.set_constant_speed(right_side_motor_speed as f32);
            driver.move_by_steps(right_side_steps_to_move, true);
        });
    }

    /// The function to lay cones
    ///
    /// This function does not block execution, hence
    /// the run_all_motors function must be called
    /// to actually run the movement and dispenser motors.
    pub fn lay_cones(
        &mut self,
        dispenser_motor_speed: f32,
        number_of_steps_to_move: i32,
    ) {
        //

        // Enable the dispenser motor if it is disabled
        if !self.dispenser_motor.is_enabled() {
            self.dispenser_motor.enable();
        }

        // Set the maximum speed of the dispenser motor
        // to the given dispenser motor speed
        self.dispenser_motor
            .set_maximum_speed(dispenser_motor_speed);

        // Set the constant speed of the dispenser motor
        // to the given dispenser motor speed
        self.dispenser_motor
            .set_constant_speed(dispenser_motor_speed);

        // Move the dispenser motor by the number of steps to lay the cone
        self.dispenser_motor
            .move_by_steps(number_of_steps_to_move, true);
    }

    /// The function to lay cones in a straight line.
    ///
    /// This function takes two arguments,
    /// the spacing between the cones in centimetres
    /// and the number of cones to lay.
    ///
    /// This function does not block execution, hence
    /// the run_all_motors function must be called
    /// to actually run the movement and dispenser motors.
    pub fn lay_cones_in_a_straight_line(
        &mut self,
        LayConesInAStraightLineArgs {
            cone_spacing_in_cm,
            number_of_cones_to_lay,
        }: LayConesInAStraightLineArgs,
    ) {
        //

        // Enable all motors if they are disabled
        if !self.all_motors_are_enabled() {
            self.enable_all_motors();
        }

        // Get the minimum distance to travel to lay the cones in centimetres
        let minimum_distance_to_travel_in_cm =
            cone_spacing_in_cm * (number_of_cones_to_lay - 1);

        // Get the minimum number of steps to lay the cones
        let minimum_number_of_steps_to_lay_cones =
            minimum_distance_to_travel_in_cm as f32 / STEP_DISTANCE_IN_CM;

        // Get the amount of time it takes to reach
        // the maximum speed for laying cones
        let time_taken_to_reach_maximum_speed_in_seconds =
            MAXIMUM_SPEED_FOR_LAYING_CONES / ACCELERATION;

        // Get the buffer time,
        // which is twice the time taken to reach the maximum speed
        // plus the buffer percentage of that time taken
        let buffer_time_in_seconds =
            2.0 * time_taken_to_reach_maximum_speed_in_seconds;

        // Get the number of steps to move to lay the cones,
        // including the buffer time
        let number_of_steps_to_move = minimum_number_of_steps_to_lay_cones
            + (buffer_time_in_seconds * MAXIMUM_SPEED_FOR_LAYING_CONES) as f32;

        // Get the time taken to travel the cone spacing in seconds
        let time_taken_to_travel_cone_spacing_in_seconds = cone_spacing_in_cm
            as f32
            / (MAXIMUM_SPEED_FOR_LAYING_CONES as f32 * STEP_DISTANCE_IN_CM);

        // Get the speed to run the dispenser motor at in steps per second
        let dispenser_motor_speed = NUMBER_OF_STEPS_PER_REVOLUTION as f32
            / time_taken_to_travel_cone_spacing_in_seconds;

        // Get the number of steps to run the dispenser motor for
        let number_of_steps_to_run_dispenser_motor = dispenser_motor_speed
            * NUMBER_OF_STEPS_PER_REVOLUTION as f32
            * number_of_cones_to_lay as f32
            + DISPENSER_MOTOR_BUFFER_STEPS as f32;

        // Set the maximum speed of the movement motors
        // to the maximum speed for laying cones and
        // move the movement motors by the number of steps to lay the cones
        self.movement_motors_do(
            |driver| {
                driver.set_maximum_speed(MAXIMUM_SPEED_FOR_LAYING_CONES);
                driver.move_by_steps(number_of_steps_to_move as i32, false);
            },
            ALTERNATE_MOTORS,
        );

        // Lay the cones
        self.lay_cones(
            dispenser_motor_speed,
            number_of_steps_to_run_dispenser_motor as i32,
        );
    }

    /// The function drop a single cone
    ///
    /// This function BLOCKS execution,
    /// so do not call this in a loop.
    pub fn drop_cone(
        &mut self,
        DropConeArgs {
            dispenser_motor_speed,
        }: DropConeArgs,
    ) {
        //

        // Set the dispenser motor speed to the default
        // if the speed given is 0.0
        let dispenser_motor_speed = if dispenser_motor_speed == 0 {
            DISPENSER_MOTOR_DEFAULT_SPEED
        } else {
            dispenser_motor_speed as f32
        };

        // Call the function to lay the cones
        self.lay_cones(
            dispenser_motor_speed,
            NUMBER_OF_STEPS_PER_REVOLUTION as i32,
        );

        // While the dispenser motor is running
        // and the program isn't stopped
        while self.dispenser_motor.distance_to_go() != 0 && !program_stopped() {
            //

            // Lay the cone
            self.dispenser_motor
                .run_at_constant_speed_to_target_position();
        }

        // Disable the dispenser motor
        self.dispenser_motor.disable();
    }

    /// The function to run the movement motors
    pub fn run_movement_motors(
        &mut self,
        run_at_constant_speed: bool,
        alternate_motors: bool,
    ) -> bool {
        //

        // Initialise the variable to store whether any motor is still running
        let mut any_motor_is_still_running = false;

        // Initialise whether or not to run the right side motors first
        let mut run_right_motors_first = false;

        // Iterate over all of the movement motors
        for motor in self.iter_movement_motors(run_right_motors_first) {
            //

            // If running the motors at constant speed is wanted,
            // run the motors at constant speed
            if run_at_constant_speed {
                motor.run_at_constant_speed();
            }
            //

            // Otherwise, run the motor normally
            else {
                motor.run();
            }

            // If the motor still has a distance to go
            if motor.distance_to_go() != 0 {
                //

                // Set the any_motor_is_still_running variable to true
                any_motor_is_still_running = true;
            }

            // If alternating the motors is wanted,
            // set the run_right_motors_first variable to
            // the opposite of its current value
            if alternate_motors {
                run_right_motors_first = !run_right_motors_first;
            }
        }

        // Return if any of the motors are still running
        return any_motor_is_still_running;
    }

    /// The function to lay cones in a straight line,
    /// but the cone layer stops to drop the cone
    /// instead of moving and dropping the cone
    /// at the same time.
    ///
    /// This function takes two arguments,
    /// the spacing between the cones in centimetres
    /// and the number of cones to lay.
    ///
    /// This function BLOCKS execution until the cones
    /// have been laid, so do not call this function
    /// in a loop.
    pub fn lay_cones_in_a_straight_line_blocking(
        &mut self,
        LayConesInAStraightLineArgs {
            cone_spacing_in_cm,
            number_of_cones_to_lay,
        }: LayConesInAStraightLineArgs,
    ) {
        //

        // Get the number of steps to move
        // to drop one cone
        let number_of_steps_before_dropping_cone =
            (cone_spacing_in_cm as f32 / STEP_DISTANCE_IN_CM) as i32;

        // Iterate over the number of cones to lay
        for _ in 0..number_of_cones_to_lay {
            //

            // If the program has been stopped, exit the function
            if program_stopped() {
                return;
            }

            // Drop the cone at the current position
            self.drop_cone(DropConeArgs {
                dispenser_motor_speed: DEFAULT_SPEED_FOR_DROPPING_CONE,
            });

            // Use the movement motors do function
            self.movement_motors_do(
                |driver| {
                    //

                    // Enable the movement motors
                    driver.enable();

                    // Set the maximum speed for the movement motors
                    driver.set_maximum_speed(MAXIMUM_SPEED_FOR_LAYING_CONES);

                    // Move the motors by the number of steps
                    // before dropping a cone
                    driver.move_by_steps(
                        number_of_steps_before_dropping_cone,
                        false,
                    )
                },
                ALTERNATE_MOTORS,
            );

            // Block the execution of all other code
            // and run the movement motors if
            // the program is not stopped
            while self.run_movement_motors(false, ALTERNATE_MOTORS) {
                //

                // If the program is stopped
                if program_stopped() {
                    //

                    // Stop all the movement motors
                    self.movement_motors_do(
                        |driver| driver.stop(false),
                        ALTERNATE_MOTORS,
                    );

                    // Exit the function
                    return;
                }
            }
        }

        // Disable the movement motors
        self.movement_motors_do(|driver| driver.disable(), ALTERNATE_MOTORS);
    }

    /// The function to run all of the motors.
    ///
    /// This function needs to be called as often as
    /// possible in the main loop to keep the motors running.
    pub fn run_all_motors(
        &mut self,
        run_movement_motors_at_constant_speed: bool,
        alternate_motors: bool,
    ) -> bool {
        //

        // Initialise the variable to store whether any motor is still running
        let mut any_motor_is_still_running = false;

        // Initialise the variable to store whether
        // all the movement motors have reached their maximum speed
        let mut all_movement_motors_have_reached_maximum_speed = false;

        // Initialise whether or not to run the right side motors first
        let mut run_right_motors_first = false;

        // Iterate over all of the movement motors
        for motor in self.iter_movement_motors(run_right_motors_first) {
            //

            // If running the movement motors at constant speed
            // is wanted, run the motor at constant speed
            if run_movement_motors_at_constant_speed {
                motor.run_at_constant_speed();
            }
            //

            // Otherwise, run the motor
            else {
                motor.run();
            }

            // If the motor still has a distance to go
            if motor.distance_to_go() != 0 {
                //

                // Set the any_motor_is_still_running variable to true
                any_motor_is_still_running = true
            }

            // If the motor has not reached its maximum speed
            if motor.speed() != motor.maximum_speed() {
                //

                // Set the all_movement_motors_have_reached_maximum_speed
                // variable to false
                all_movement_motors_have_reached_maximum_speed = false;
            }

            // If alternating the motors is wanted,
            // set the run_right_motors_first variable to
            // the opposite of its current value
            if alternate_motors {
                run_right_motors_first = !run_right_motors_first;
            }
        }

        // Run the dispenser motor at a constant speed
        // only if the movement motors have reached maximum speed
        // and set the any_motor_is_still_running variable
        // to true if it is still running
        if self.dispenser_motor.run_at_constant_speed()
            && all_movement_motors_have_reached_maximum_speed
        {
            any_motor_is_still_running = true;
        };

        // Return if any of the motors are still running
        return any_motor_is_still_running;
    }

    /// The function to stop all of the motors
    pub fn stop_all_motors(
        &mut self,
        movement_motors_are_constant_speed: bool,
    ) {
        self.movement_motors_do(
            |driver| driver.stop(movement_motors_are_constant_speed),
            ALTERNATE_MOTORS,
        );
        self.dispenser_motor.stop(true);
    }
}
