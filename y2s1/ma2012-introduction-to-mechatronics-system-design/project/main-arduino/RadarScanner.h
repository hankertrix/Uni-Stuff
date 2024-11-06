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
static const unsigned int RADAR_SCANNER_SERVO_MOTOR_DELAY_IN_MS = 30;

class RadarScanner {

private:
  //

  // Saved parameters
  UltrasonicSensor &_ultrasonic_sensor;

  // State variables
  unsigned int _initial_distances_in_cm[RADAR_SCANNER_ANGLE_RANGE + 1];
  unsigned int _current_distances_in_cm[RADAR_SCANNER_ANGLE_RANGE + 1];

public:
  //

  // Constructor
  RadarScanner(RadarScannerParameters parameters);

  // Methods
  unsigned int get_data_array_size();
  void save_to_distances_array(unsigned int angle, bool is_initial_distances);
  void compare_distance_arrays(bool boolean_array[]);
};

#endif
