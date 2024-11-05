// The library for the fall detector

#ifndef FALL_DETECTOR_H
#define FALL_DETECTOR_H

#include "Accelerometer.h"
#include "RadarScanner.h"

// The default value for the previous fall time
static const unsigned long FALL_DETECTOR_DEFAULT_PREVIOUS_FALL_TIME = 0;

// The number of radar scanners
static const unsigned int FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS = 2;

// The structure to store the parameters
// to the fall detector
struct FallDetectorParameters {
  Accelerometer &accelerometer;
  RadarScanner (&radar_scanners)[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Interrupt pin
  unsigned int interrupt_pin;

  // Radar scanner parameters
  unsigned int minimum_number_of_blocked_segments;
  unsigned int maximum_number_of_breaks;
  unsigned int maximum_number_of_blocked_segments_for_empty_room;

  // Accelerometer parameters
  unsigned int minimum_acceleration_difference_for_force_spike_in_gs;
  unsigned int recency_of_accelerometer_data_in_ms;

  // Timing related parameters
  unsigned long minimum_time_to_be_considered_a_fall_without_force_spike_in_ms;
  unsigned long minimum_time_to_be_considered_a_fall_with_force_spike_in_ms;
};

class FallDetector {

private:
  //

  // Stored parameters
  Accelerometer &_accelerometer;
  RadarScanner (&_radar_scanners)[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS];

  // Interrupt pins
  const unsigned int _interrupt_pin;

  // Radar scanner parameters
  const unsigned int _minimum_number_of_blocked_segments;
  const unsigned int _maximum_number_of_breaks;
  const unsigned int _maximum_number_of_blocked_segments_for_empty_room;

  // Accelerometer parameters
  const unsigned int _minimum_acceleration_difference_for_force_spike_in_gs;
  const unsigned int _recency_of_accelerometer_data_in_ms;

  // Timing related parameters
  const unsigned int
      _minimum_time_to_be_considered_a_fall_without_force_spike_in_ms;
  const unsigned int
      _minimum_time_to_be_considered_a_fall_with_force_spike_in_ms;

  // State variables
  unsigned long _previous_fall_time;

  // Functions
  void _save_distances(unsigned int angle, bool is_initial_distances);
  void _get_radar_scanner_fall_data(
      unsigned int number_of_blocked_segments_array
          [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
      unsigned int
          number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]);
  bool _radar_scanners_detected_fall(
      unsigned int number_of_blocked_segments_array
          [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
      unsigned int
          number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]);
  bool _accelerometer_has_force_spike();
  bool _check_for_fall(
      unsigned int number_of_blocked_segments_array
          [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS],
      unsigned int
          number_of_breaks_array[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]);
  bool _room_is_empty(unsigned int number_of_blocked_segments_array
                          [FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS]);

public:
  //

  // Constructor
  FallDetector(FallDetectorParameters parameters);

  // Methods
  void initialise();
  bool run(unsigned int angle, bool is_initial_distances,
           bool full_sweep_completed);
};

#endif
