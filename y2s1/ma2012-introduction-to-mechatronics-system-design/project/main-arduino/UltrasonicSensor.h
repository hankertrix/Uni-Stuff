// The library for the ultrasonic sensor

#ifndef ULTRASONIC_SENSOR_H
#define ULTRASONIC_SENSOR_H

// Libraries to include
#include "Arduino.h"

// The class for the ultrasonic sensor
class UltrasonicSensor {

private:
  //

  // Saved parameters
  const unsigned int _trigger_pin;
  const unsigned int _echo_pin;

public:
  //

  // Constructor
  UltrasonicSensor(unsigned int trigger_pin, unsigned int echo_pin);

  // Functions
  unsigned int get_distance_in_cm();
};

#endif
