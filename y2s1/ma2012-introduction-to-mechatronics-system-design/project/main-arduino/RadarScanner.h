// The defintion file for the fall detector library.
//
// Look at the .cpp file for the implementation,
// and the documentation.

#include "Arduino.h"
#include "Servo.h"

#ifndef RADAR_SCANNER_H
#define RADAR_SCANNER_H

// The struct to wrap the arguments to
// the constructor of the RadarScanner class
struct RadarScannerParameters {
  unsigned int servo_motor_pin;
  unsigned int ultrasonic_trigger_pin;
  unsigned int ultrasonic_echo_pin;
  unsigned int start_angle;
  unsigned int end_angle;
  unsigned int servo_motor_delay_in_ms;
};

// The size of the distance array
static const unsigned int RADAR_SCANNER_DISTANCE_ARRAY_SIZE = 180 + 1;

// The float tolerance for the calculations
// involving the distances
static const float FLOAT_TOLERANCE = 0.01;

class RadarScanner {

private:
  //

  // Saved parameters
  const unsigned int _servo_motor_pin;
  const unsigned int _ultrasonic_trigger_pin;
  const unsigned int _ultrasonic_echo_pin;
  const unsigned int _start_angle;
  const unsigned int _end_angle;
  const unsigned int _servo_motor_delay_in_ms;

  // Calculated parameters
  const unsigned int _angle_range;

  // State variables
  float _initial_distances_in_cm[RADAR_SCANNER_DISTANCE_ARRAY_SIZE];
  float _current_distances_in_cm[RADAR_SCANNER_DISTANCE_ARRAY_SIZE];
  unsigned long _previous_sweep_time;
  unsigned int _current_angle;
  int _change_in_sweep_angle;
  Servo _servo;

  // Methods
  float _get_distance_in_cm();

public:
  //

  // Constructor
  RadarScanner(RadarScannerParameters parameters);

  // Methods
  unsigned int get_angle_range();
  unsigned int get_current_angle();
  unsigned int get_data_array_size();
  void save_initial_distances();
  bool sweep();
  void compare_distance_arrays(bool boolean_array[]);
};

#endif
