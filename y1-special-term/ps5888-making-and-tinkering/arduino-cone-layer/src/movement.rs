// The module to handle the movement of the cone layer
//
// References:
// https://drive.google.com/drive/folders/1RO-_eqV296sZPlzBsY5cTNpsorFjTUqY

use heapless::Vec;

use crate::stepper_driver::StepperDriver;

/// The threshold to consider the joystick
/// to be moving the cone layer forward
const Y_AXIS_FORWARD_THRESHOLD: i16 = 0;

/// The threshold to consider the joystick
/// to be moving the cone layer backwards
const Y_AXIS_BACKWARD_THRESHOLD: i16 = 0;

/// The threshold to consider the joystick
/// to be moving the cone layer to the left
const X_AXIS_LEFT_THRESHOLD: i16 = 0;

/// The threshold to consider the joystick
/// to be moving the cone layer to the right
const X_AXIS_RIGHT_THRESHOLD: i16 = 0;

/// The struct of the movement handler
pub struct MovementHandler {
    left_side_motors: Vec<StepperDriver, 2>,
    right_side_motors: Vec<StepperDriver, 2>,
}

/// The implementation of the movement handler
impl MovementHandler {
    //

}
