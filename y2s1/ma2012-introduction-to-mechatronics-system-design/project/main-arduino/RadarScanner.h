// The defintion file for the fall detector library.
//
// Look at the .cpp file for the implementation,
// and the documentation.

#include "Arduino.h"
#include "Servo.h"
#include "UltrasonicSensor.h"

#ifndef RADAR_SCANNER_H
#define RADAR_SCANNER_H

// The struct to wrap the arguments to
// the constructor of the RadarScanner class
struct RadarScannerParameters {
  unsigned int servo_motor_pin;
  UltrasonicSensor &ultrasonic_sensor;
};

// The start angle of the radar scanner
static const unsigned int RADAR_SCANNER_START_ANGLE = 45;

// The end angle of the radar scanner
static const unsigned int RADAR_SCANNER_END_ANGLE = 135;

// The size of the distance array
static const unsigned int RADAR_SCANNER_ANGLE_RANGE =
    RADAR_SCANNER_END_ANGLE - RADAR_SCANNER_START_ANGLE;

// The servo motor delay in milliseconds
static const unsigned int RADAR_SCANNER_SERVO_MOTOR_DELAY_IN_MS = 15;

class RadarScanner {

private:
  //

  // Saved parameters
  const unsigned int _servo_motor_pin;
  UltrasonicSensor &_ultrasonic_sensor;

  // State variables
  unsigned int _initial_distances_in_cm[RADAR_SCANNER_ANGLE_RANGE + 1];
  unsigned int _current_distances_in_cm[RADAR_SCANNER_ANGLE_RANGE + 1];
  unsigned long _previous_sweep_time;
  unsigned int _current_angle;
  int _change_in_sweep_angle;
  Servo _servo;

public:
  //

  // Constructor
  RadarScanner(RadarScannerParameters parameters);

  // Methods
  unsigned int get_current_angle();
  unsigned int get_data_array_size();
  unsigned int get_servo_motor_delay_in_ms();
  void save_initial_distances();
  bool sweep(bool save_initial_distances);
  bool sweep();
  void compare_distance_arrays(bool boolean_array[]);
};

#endif
