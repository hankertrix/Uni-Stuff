/* Library for the radar scanner.
 *
 * The radar scanner consists of
 * a servo motor attached to
 * an ultrasonic sensor.
 * The servo motor is used to
 * sweep the ultrasonic sensor.
 *
 * The fall detector object takes
 * the pins for the servo motor
 * and the trigger and echo pins
 * for the ultrasonic sensor.
 */

#include "RadarScanner.h"

/* The constructor for the radar scanner.
 * The constructor takes the pins for the
 * servo motor, the trigger and echo pins
 * for the ultrasonic sensor, the start
 * angle, the end angle to sweep the servo
 * motor, and the delay in ms between each
 * angle of the servo motor.
 *
 * The servo motor delay in microseconds
 * is the delay for moving the servo motor
 * 1 degree.
 *
 * The current angle is initialised to the
 * start angle and is used in the sweep
 * function to determine how to move
 * the servo motor.
 *
 * The change in sweep angle is initialised
 * to 1 to move
 */
RadarScanner::RadarScanner(RadarScannerParameters parameters)
    : _servo_motor_pin(parameters.servo_motor_pin),
      _ultrasonic_sensor(parameters.ultrasonic_sensor),
      _start_angle(parameters.start_angle), _end_angle(parameters.end_angle),
      _servo_motor_delay_in_ms(parameters.servo_motor_delay_in_ms),
      _angle_range(parameters.end_angle - parameters.start_angle) {

  // Initialise the distances to 0
  for (unsigned int i = 0; i < RADAR_SCANNER_DISTANCE_ARRAY_SIZE; ++i) {
    this->_initial_distances_in_cm[i] = 0.0;
    this->_current_distances_in_cm[i] = 0.0;
  }

  // Initialise the previous sweep time to 0
  this->_previous_sweep_time = 0;

  // Set the current angle to the start angle
  this->_current_angle = this->_start_angle;

  // Set the change in sweep angle to 1
  this->_change_in_sweep_angle = 1;

  // Initialise the output pins
  pinMode(this->_servo_motor_pin, OUTPUT);

  // Create the servo object
  Servo servo;

  // Set the servo object to the state variable
  this->_servo = servo;

  // Attach the servo object to the servo motor pin
  this->_servo.attach(this->_servo_motor_pin);

  // Move the servo motor to the start angle
  this->_servo.write(this->_start_angle);

  // Wait for the servo motor to move to the start angle
  delay(this->_angle_range * this->_servo_motor_delay_in_ms);
}

// The function to get the angle range
unsigned int RadarScanner::get_angle_range() { return this->_angle_range; }

// The function to get the current angle
unsigned int RadarScanner::get_current_angle() { return this->_current_angle; }

// The function to get the data size of the array
unsigned int RadarScanner::get_data_array_size() {
  return RADAR_SCANNER_DISTANCE_ARRAY_SIZE;
}

/* The function to sweep the radar scanner.
 *
 * This function is non-blocking, and thus needs
 * to be called in the main loop of the program.
 *
 * This function returns whether a full sweep
 * has been completed.
 */
bool RadarScanner::sweep(bool save_initial_distances) {

  // If the current time minus the previous sweep time
  // is less than the servo motor delay, then exit the function
  if (millis() - this->_previous_sweep_time < this->_servo_motor_delay_in_ms) {
    return false;
  }

  // Get the start and end angles
  unsigned int start_angle = this->_start_angle;
  unsigned int end_angle = this->_end_angle;

  // Constrain the current angle to between the start angle
  // and the end angle.
  //
  // We technically shouldn't need to do this, since the angle
  // can't go past the start and end angle, but this is just
  // in case.
  unsigned int current_angle =
      constrain(this->_current_angle, start_angle, end_angle);

  // Initialise the variable to store
  // whether a full sweep has been completed
  bool full_sweep_completed = false;

  // Get the change in sweep angle
  int change_in_sweep_angle = this->_change_in_sweep_angle;

  // If the current angle is the same as the start angle
  if (current_angle == start_angle) {

    // Set the change in sweep angle to 1
    change_in_sweep_angle = 1;

    // Set the full sweep completed variable to true
    full_sweep_completed = true;
  }

  // Otherwise, if the current angle is the same as the end angle
  else if (current_angle == end_angle) {

    // Set the change in sweep angle to -1
    change_in_sweep_angle = -1;

    // Set the full sweep completed variable to true
    full_sweep_completed = true;
  }

  // We need to save the distance for the current angle first,
  // as the motor has moved to the current angle.
  //
  // But once you change the angle, the motor is no longer
  // in the position for the new angle to get the new
  // distance, since you need to wait for the motor
  // to move to the new angle.
  //
  // Hence we get the distance for the current angle
  // before changing the angle as we know that the
  // servo motor is definitely in the position
  // for the current angle.
  float distance_in_cm = this->_ultrasonic_sensor.get_distance_in_cm();

  // If the save initial distances variable is true
  if (save_initial_distances) {

    // Save the distance in cm to the initial distances array
    this->_initial_distances_in_cm[current_angle] = distance_in_cm;
  }

  // Otherwise
  else {

    // Set the distance in cm to the current distances array
    this->_current_distances_in_cm[current_angle] = distance_in_cm;
  }

  // Change the current angle by the change in sweep angle
  current_angle = current_angle + change_in_sweep_angle;

  // Move the motor to the new current angle
  this->_servo.write(current_angle);

  // Set the current angle and the change in sweep angle
  this->_current_angle = current_angle;
  this->_change_in_sweep_angle = change_in_sweep_angle;

  // Set the previous sweep time to the current time
  this->_previous_sweep_time = millis();

  // Return the full sweep completed variable
  return full_sweep_completed;
}

// The function to sweep the radar scanner
// without any arguments
bool RadarScanner::sweep() { return this->sweep(false); }

/* The function to compare the current distance
 * array to the initial distance array.
 *
 * It takes a pointer to an array of booleans
 * and modifies the array. It also takes the
 * size of the array.
 *
 * A true means that the distance in the
 * current distance array is less than the
 * distance in the initial distance array.
 *
 * A false means that the distance in the
 * current distance array is equal to,
 * or more than the distance in the initial distance array.
 * I'm not sure how it can be more, but it might happen.
 *
 * This function returns a bool to indicate
 * if the function was successful.
 */
void RadarScanner::compare_distance_arrays(bool boolean_array[]) {

  // Iterate from the start angle to the end angle
  for (unsigned int angle = this->_start_angle; angle <= this->_end_angle;
       ++angle) {

    // Get the initial distance for the angle
    float initial_distance_in_cm = this->_initial_distances_in_cm[angle];

    // Get the current distance for the angle
    float current_distance_in_cm = this->_current_distances_in_cm[angle];

    // Get the index for the boolean array
    unsigned int index = angle - this->_start_angle;

    // If the distance in the initial distance array
    // minus the distance in the current distance array
    // is less than or equal to the float tolerance
    if (initial_distance_in_cm - current_distance_in_cm <= FLOAT_TOLERANCE) {

      // Set the item in the boolean array to false,
      // as this means that the current distance
      // is the same as the initial distance,
      // or more than the initial distance somehow
      boolean_array[index] = false;

      // Continue the loop
      continue;
    }

    // Otherwise, the distance is less than
    // the initial distance, so set the item
    // in the boolean array to true
    boolean_array[index] = true;
  }
}
