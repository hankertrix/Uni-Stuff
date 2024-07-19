// The module to handle the movement of the cone layer

use heapless::Vec;

// The threshold to consider the joystick
// to be moving the cone layer forward
const Y_AXIS_FORWARD_THRESHOLD: i16 = 0;

// The threshold to consider the joystick
// to be moving the cone layer backwards
const Y_AXIS_BACKWARD_THRESHOLD: i16 = 0;

// The threshold to consider the joystick
// to be moving the cone layer to the left
const X_AXIS_FORWARD_THRESHOLD: i16 = 0;

// The threshold to consider the joystick
// to be moving the cone layer to the right
const X_AXIS_BACKWARD_THRESHOLD: i16 = 0;

/// The function to handle the movement of the joystick
pub fn handle_joystick(args: &str) {
    //

    // Try to convert the arguments to an integer
    let parsed_args = args
        .split_whitespace()
        .into_iter()
        .map(|arg| arg.parse::<i16>().unwrap_or_default())
        .collect::<Vec<_, 2>>();

    // If the arguments exist
    if let [x_axis, y_axis] = parsed_args[..] {
        //

        // 
    }
}
