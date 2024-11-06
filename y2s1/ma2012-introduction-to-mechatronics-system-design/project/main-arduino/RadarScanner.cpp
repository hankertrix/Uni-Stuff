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
    : _ultrasonic_sensor(parameters.ultrasonic_sensor) {

  // Initialise the distances to 0
  for (unsigned int i = 0; i < RADAR_SCANNER_ANGLE_RANGE + 1; ++i) {
    this->_initial_distances_in_cm[i] = 0;
    this->_current_distances_in_cm[i] = 0;
  }
}

// The function to get the data size of the array
unsigned int RadarScanner::get_data_array_size() {
  return RADAR_SCANNER_ANGLE_RANGE + 1;
}

// The function to save to the distances array
void RadarScanner::save_to_distances_array(unsigned int angle,
                                           bool is_initial_distances) {

  // Get the index of the list from the angle
  unsigned int index = angle - RADAR_SCANNER_START_ANGLE;

  // Get the distance from the ultrasonic sensor
  unsigned int distance = this->_ultrasonic_sensor.get_distance_in_cm();

  // If the initial distances are to be saved
  if (is_initial_distances) {

    // Save the distance to the array
    this->_initial_distances_in_cm[index] = distance;
  }

  // Otherwise
  else {

    // Save the distance to the array
    this->_current_distances_in_cm[index] = distance;
  }
}

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

  // Iterate over the entire array
  for (unsigned int index = 0; index < RADAR_SCANNER_ANGLE_RANGE + 1; ++index) {

    // Get the initial distance for the angle
    unsigned int initial_distance_in_cm = this->_initial_distances_in_cm[index];

    // Get the current distance for the angle
    unsigned int current_distance_in_cm = this->_current_distances_in_cm[index];

    // If the distance in the current distance array
    // is less than or equal to the distance in the initial distance array
    // is more than 0.
    if (current_distance_in_cm < initial_distance_in_cm) {

      // Set the item in the boolean array to true,
      // as this means that the current distance
      // is the less than the initial distance,
      // so it is blocked
      boolean_array[index] = true;

      // Continue the loop
      continue;
    }

    // Otherwise, the distance is more than
    // or equal to the initial distance,
    // so set the item
    // in the boolean array to false
    boolean_array[index] = false;
  }
}
