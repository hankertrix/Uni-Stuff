// The library for the fall detector

#include "FallDetector.h"

/* Constructor
 *
 * The constructor for the fall detector takes
 * an interrupt pin, ideally non-PWM one,
 * so digital pin 2 on the Arduino Uno.
 *
 * It also takes the minimum number of blocked segments
 * to be considered a fall,
 * the maximum number of breaks between sections of blocked segments,
 * the maximum number of segments in a break,
 * the minimum acceleration difference to be considered a force spike in g's,
 * and the minimum time to be considered a fall.
 */
FallDetector::FallDetector(FallDetectorParameters parameters)
    : _accelerometer(parameters.accelerometer),
      _radar_scanners(parameters.radar_scanners),
      _interrupt_pin(parameters.interrupt_pin),
      _minimum_number_of_blocked_segments(
          parameters.minimum_number_of_blocked_segments),
      _maximum_number_of_breaks(parameters.maximum_number_of_breaks),
      _maximum_number_of_blocked_segments_for_empty_room(
          parameters.maximum_number_of_blocked_segments_for_empty_room),
      _minimum_acceleration_difference_for_force_spike_in_gs(
          parameters.minimum_acceleration_difference_for_force_spike_in_gs),
      _recency_of_accelerometer_data_in_ms(
          parameters.recency_of_accelerometer_data_in_ms),
      _minimum_time_to_be_considered_a_fall_without_force_spike_in_ms(
          parameters
              .minimum_time_to_be_considered_a_fall_without_force_spike_in_ms),
      _minimum_time_to_be_considered_a_fall_with_force_spike_in_ms(
          parameters
              .minimum_time_to_be_considered_a_fall_with_force_spike_in_ms),
      _previous_fall_time(FALL_DETECTOR_DEFAULT_PREVIOUS_FALL_TIME) {

  // Initialise the interrupt pin to output
  pinMode(this->_interrupt_pin, OUTPUT);

  // Set the interrupt pin to low
  digitalWrite(this->_interrupt_pin, LOW);
}

// The function to initialise the fall detector.
// This function must be called before using the fall detector.
void FallDetector::initialise() {

  // Initialise the accelerometer
  this->_accelerometer.initialise();
}

// The function to get the number of blocked segments
// and the number of breaks from the radar scanners
void FallDetector::_get_radar_scanner_fall_data(
    unsigned int number_of_blocked_segments_array
        [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
    unsigned int
        number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]) {

  // Iterate over the number of radar scanners
  for (unsigned int radar_scanner_index = 0;
       radar_scanner_index < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;
       ++radar_scanner_index) {

    // Get the radar scanner
    RadarScanner &radar_scanner = this->_radar_scanners[radar_scanner_index];

    // Get the length of the boolean array
    unsigned int boolean_array_length = RADAR_SCANNER_ANGLE_RANGE + 1;

    // Create the boolean array to store the result
    bool boolean_array[boolean_array_length];

    // Create a boolean array to store the result
    // of the compare distance arrays function
    radar_scanner.compare_distance_arrays(boolean_array);

    // Initialise the given number of blocked segments array
    number_of_blocked_segments_array[radar_scanner_index] = 0;

    // Initialise the given number of breaks array
    number_of_breaks_array[radar_scanner_index] = 0;

    // Initialise the start segment of the current break
    unsigned int start_segment_of_current_break = 0;

    // Initialise the end segment of the current break
    unsigned int end_segment_of_current_break = 0;

    // Iterate over the boolean array
    for (unsigned int segment_number = 0; segment_number < boolean_array_length;
         ++segment_number) {

      // Get the whether the current segment is blocked
      bool is_blocked = boolean_array[segment_number];

      // If the current segment is blocked
      if (is_blocked) {

        // Increment the number of blocked segments
        ++number_of_blocked_segments_array[radar_scanner_index];

        // If the end segment of the current break is
        // less than the start segment, because the
        // start segment is set first before the end
        // segment is set, which means that we are now
        // ending a break, so we set the end segment
        // of the break.
        if (end_segment_of_current_break < start_segment_of_current_break) {

          // Set the end segment to the current segment number
          end_segment_of_current_break = segment_number;
        }

        // Continue the loop
        continue;
      }

      // Otherwise, if the start segment of the current break
      // is more than or equal to the end segment of the
      // current break, which means that the start segment
      // of the break has already been set, which means that
      // we are currently in a break, so continue the loop
      // as there is nothing to do.
      //
      // This is fine for the initial condition of both
      // the start segment and the end segment of the
      // current break being set to 0, as they are equal,
      // so the first "break" won't be considered a break.
      if (start_segment_of_current_break >= end_segment_of_current_break) {
        continue;
      }

      // Otherwise, that means the end segment of the current break
      // is past the start segment of the current break,
      // so we are currently in a new break,
      // so set the start segment of the current break
      // to the current segment number
      start_segment_of_current_break = segment_number;

      // Increment the number of breaks
      ++number_of_breaks_array[radar_scanner_index];
    }

    // If the end segment of the current break after the loop
    // is less than the start segment of the current break,
    // that means a break started but not ended, which means
    // the entire section from the start segment to the end
    // of the array is not blocked, which is not considered a break,
    // so we subtract one from the number of breaks if it is not
    // already 0 or less.
    if (end_segment_of_current_break < start_segment_of_current_break &&
        number_of_breaks_array[radar_scanner_index] > 0) {
      --number_of_breaks_array[radar_scanner_index];
    }
  }
}

// The function to check if the radar scanners detected a fall
bool FallDetector::_radar_scanners_detected_fall(
    unsigned int number_of_blocked_segments_array
        [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
    unsigned int
        number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]) {

  // Initialise the array to store the result
  // of whether the radar scanners detected a fall
  bool results_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Iterate over the number of radar scanners
  for (unsigned int radar_scanner_index = 0;
       radar_scanner_index < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;
       ++radar_scanner_index) {

    // Get the number of of blocked segments
    unsigned int number_of_blocked_segments =
        number_of_blocked_segments_array[radar_scanner_index];

    Serial.print("Number of blocked segments: ");
    Serial.println(number_of_blocked_segments);

    // Get the number of breaks
    unsigned int number_of_breaks = number_of_breaks_array[radar_scanner_index];

    // If the number of blocked segments is more than the
    // maximum number of blocked segments, and the number
    // of breaks is less than the maximum number of breaks,
    // then we have a fall, so add a true to the results array.
    if (number_of_blocked_segments >
            this->_minimum_number_of_blocked_segments &&
        number_of_breaks < this->_maximum_number_of_breaks) {
      results_array[radar_scanner_index] = true;
    }

    // Otherwise, set the result to false
    else {
      results_array[radar_scanner_index] = false;
    }
  }

  // Initialise the number of radar scanners that detected a fall
  unsigned int number_of_radar_scanners_that_detected_a_fall = 0;

  // Iterate over the results array
  for (unsigned int i = 0; i < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS; ++i) {

    // Get the result
    bool result = results_array[i];

    // If the result is true,
    // which means a fall was detected
    if (result) {

      // Increase the number of radar scanners that detected a fall
      ++number_of_radar_scanners_that_detected_a_fall;
    }
  }

  // Calculate the percentage of radar scanners detecting a fall
  int percentage_of_radar_scanners_detected_a_fall =
      number_of_radar_scanners_that_detected_a_fall * 100 /
      FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;

  // Initialise if a fall was detected
  bool fall_detected = false;

  // If the percentage of radar scanners that detected
  // a fall is greater or equal to 50 percent
  if (percentage_of_radar_scanners_detected_a_fall >= 50) {

    // Set that a fall was detected
    fall_detected = true;
  }

  // Return the fall detected variable
  return fall_detected;
}

// The function to check if the accelerometer has a force spike
bool FallDetector::_accelerometer_has_force_spike() {

  // Initialise the variable to store the largest acceleration value
  float largest_acceleration = 0;

  // Initialise the variable to store the smallest acceleration value
  float smallest_acceleration = 0;

  // Initialise the arrays to get the acceleration data
  float acceleration_data[ACCELEROMETER_DATA_ARRAY_SIZE];

  // Initialise the arrays to get the measurement time
  unsigned long measurement_time_array[ACCELEROMETER_DATA_ARRAY_SIZE];

  // Get the accelerometer data
  this->_accelerometer.get_accelerometer_data(acceleration_data,
                                              measurement_time_array);

  // Iterate over the accelerometer data
  for (unsigned int i = 0; i < ACCELEROMETER_DATA_ARRAY_SIZE; ++i) {

    // Get the acceleration value
    float acceleration = acceleration_data[i];

    // Get the measurement time
    unsigned long measurement_time = measurement_time_array[i];

    // If the acceleration data is past the recency of the accelerometer data,
    // which is how long ago the accelerometer data was taken,
    // then skip the data.
    if (millis() - measurement_time <
        this->_recency_of_accelerometer_data_in_ms) {
      continue;
    }

    // If the acceleration is larger than the largest acceleration,
    // then set the largest acceleration to the current acceleration
    if (acceleration > largest_acceleration) {
      largest_acceleration = acceleration;
    }

    // If the acceleration is smaller than the smallest acceleration,
    // then set the smallest acceleration to the current acceleration
    if (acceleration < smallest_acceleration) {
      smallest_acceleration = acceleration;
    }
  }

  // Get the difference between the largest and smallest acceleration
  float acceleration_difference = largest_acceleration - smallest_acceleration;

  // Initialise the result of the function
  bool result = false;

  // If the acceleration difference is more than the minimum acceleration
  // difference for a force spike, then return true.
  if (acceleration_difference >
      this->_minimum_acceleration_difference_for_force_spike_in_gs) {
    result = true;
  }

  // Return the result variable
  return result;
}

// The function to check for a fall
bool FallDetector::_check_for_fall(
    unsigned int number_of_blocked_segments_array
        [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
    unsigned int
        number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]) {

  // Initialise the variable to decide
  // whether there is a fall
  bool fall_detected = false;

  // Get whether the radar scanners detected a fall
  bool radar_scanners_detected_fall = this->_radar_scanners_detected_fall(
      number_of_blocked_segments_array, number_of_breaks_array);

  // Get whether the accelerometer has a force spike
  bool accelerometer_has_force_spike = this->_accelerometer_has_force_spike();

  // If the radar scanners did not detect a fall
  if (!radar_scanners_detected_fall) {

    // Set the previous fall time to the default value
    this->_previous_fall_time = FALL_DETECTOR_DEFAULT_PREVIOUS_FALL_TIME;

    // Return the fall detected variable
    return fall_detected;
  }

  // Otherwise, that means a fall has been detected

  // If the previous fall time is set to the default value,
  // that means that there was no previous fall detected,
  // set the previous fall time to the current time
  if (this->_previous_fall_time == FALL_DETECTOR_DEFAULT_PREVIOUS_FALL_TIME) {
    this->_previous_fall_time = millis();
  }

  // If the accelerometer has a force spike,
  // if the current time minus the previous fall time
  // is more than the minimum time to be considered a fall
  // with a force spike,
  // set the fall detected variable to true
  if (accelerometer_has_force_spike &&
      millis() - this->_previous_fall_time >
          this->_minimum_time_to_be_considered_a_fall_with_force_spike_in_ms) {
    fall_detected = true;
  }

  // Otherwise, if the current time minus the previous fall time
  // is more than the minimum time to be considered a fall
  // without a force spike,
  // set the fall detected variable to true
  else if (
      millis() - this->_previous_fall_time >
      this->_minimum_time_to_be_considered_a_fall_without_force_spike_in_ms) {
    fall_detected = true;
  }

  // Return the fall detected variable
  return fall_detected;
}

// The function to check if the room is empty
bool FallDetector::_room_is_empty(
    unsigned int number_of_blocked_segments_array
        [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]) {

  // Initialise the boolean array to store whether
  // the radar scanners detect the room as empty
  bool boolean_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Iterate over the radar scanners
  for (unsigned int radar_scanner_index = 0;
       radar_scanner_index < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;
       ++radar_scanner_index) {

    // Get the number of of blocked segments
    unsigned int number_of_blocked_segments =
        number_of_blocked_segments_array[radar_scanner_index];

    // If the number of blocked segments is greater than the maximum
    // number of blocked segments to consider the room as empty
    if (number_of_blocked_segments >
        this->_maximum_number_of_blocked_segments_for_empty_room) {

      // Set the boolean array to false
      boolean_array[radar_scanner_index] = false;
    }

    // Otherwise
    else {

      // Set the boolean array to true
      boolean_array[radar_scanner_index] = true;
    }
  }

  // Initialise the number of radar scanners deem a room as empty
  unsigned int number_of_radar_scanners_that_deem_room_as_empty = 0;

  // Iterate over the results array
  for (unsigned int i = 0; i < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS; ++i) {

    // Get the result
    bool result = boolean_array[i];

    // If the result is true,
    // which the room is considered as empty
    if (result) {

      // Increase the number of radar scanners that
      // deem the room as empty
      ++number_of_radar_scanners_that_deem_room_as_empty;
    }
  }

  // Calculate the percentage of radar scanners
  // that deem the room as empty
  int percentage_of_radar_scanners_deem_room_as_empty =
      number_of_radar_scanners_that_deem_room_as_empty * 100 /
      FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;

  // Initialise if the room is considered as empty
  bool room_is_empty = false;

  // If the percentage of radar scanners that deem
  // a room as empty is greater or equal to 50 percent
  if (percentage_of_radar_scanners_deem_room_as_empty >= 50) {

    // Set that the room is considered as empty
    room_is_empty = true;
  }

  // Return the room is empty variable
  return room_is_empty;
}

// The function to save the distances for the radar scanners.
void FallDetector::_save_distances(unsigned int angle,
                                   bool is_initial_distances) {

  // Iterate over the radar scanners
  for (unsigned int radar_scanner_index = 0;
       radar_scanner_index < FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS;
       ++radar_scanner_index) {

    // Get the radar scanner
    RadarScanner &radar_scanner = this->_radar_scanners[radar_scanner_index];

    // Set the distances in the radar scanners
    radar_scanner.save_to_distances_array(angle, is_initial_distances);
  }
}

// The function to run the fall detector.
//
// This function runs the sweep method of
// the radar scanner, so it should be
// called every loop.
//
// This function returns whether the
// fall detector should continue to run.
bool FallDetector::run(unsigned int angle, bool is_initial_distances,
                       bool full_sweep_completed) {

  // Save the distances for the radar scanners
  this->_save_distances(angle, is_initial_distances);

  // Call the measure and store data function on the accelerometer
  this->_accelerometer.measure_and_store_data();

  // If a full sweep has not completed,
  // then return that the fall detector should continue to run,
  // since it has not checked that the room is empty
  if (!full_sweep_completed) {
    return true;
  }

  // Initialise the array to store the number of blocked segments
  unsigned int
      number_of_blocked_segments_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Initialise the array to store the number of breaks
  unsigned int number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Get the number of blocked segments and the number of breaks
  // from the radar scanners
  this->_get_radar_scanner_fall_data(number_of_blocked_segments_array,
                                     number_of_breaks_array);

  // Get whether there is a fall
  bool fall_detected = this->_check_for_fall(number_of_blocked_segments_array,
                                             number_of_breaks_array);

  // Get if the the fall detector should continue to run,
  // which is just the inverse of whether the room is empty.
  //
  // No point running the fall detector if the room is empty.
  bool fall_detector_should_continue_to_run =
      !this->_room_is_empty(number_of_blocked_segments_array);

  // If there is no fall detected
  if (!fall_detected) {

    // Set the interrupt pin to low
    // to indicate that there is no fall
    digitalWrite(this->_interrupt_pin, LOW);

    // Return if the fall detector should continue to run
    return fall_detector_should_continue_to_run;
  }

  // Otherwise, set the interrupt pin to high
  // to indicate that a fall has been detected
  digitalWrite(this->_interrupt_pin, HIGH);

  // Return if the fall detector should continue to run
  return fall_detector_should_continue_to_run;
}
