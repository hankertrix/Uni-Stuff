// The library for the ultrasonic sensor

#include "UltrasonicSensor.h"

// Constructor
UltrasonicSensor::UltrasonicSensor(unsigned int trigger_pin,
                                   unsigned int echo_pin)
    : _trigger_pin(trigger_pin), _echo_pin(echo_pin) {

  // Initialise the output pins
  pinMode(this->_trigger_pin, OUTPUT);

  // Initialise the input pins
  pinMode(this->_echo_pin, INPUT);
}

// Function to get the distance in cm from the ultrasonic sensor
unsigned int UltrasonicSensor::get_distance_in_cm() {

  // Reset the state of the ultrasonic sensor
  digitalWrite(this->_trigger_pin, LOW);

  // Delay for 2 microseconds for the ultrasonic sensor to respond
  delayMicroseconds(2);

  // Set the trigger pin to HIGH
  digitalWrite(this->_trigger_pin, HIGH);

  // Delay for 10 microseconds so that
  // the ultrasonic sensor will send an ultrasonic burst
  delayMicroseconds(10);

  // Set the trigger pin to LOW to reset it's state
  digitalWrite(this->_trigger_pin, LOW);

  // Read the echo pin to get the time taken
  // for the ultrasonic sensor burst to return
  unsigned int time_taken_in_us = pulseIn(this->_echo_pin, HIGH);

  // Calculate the distance from the time taken
  // using the speed of sound in air, which is 343 m/s
  // or 34300 cm/s.
  // The speed of sound of 34300 cm/s needs to be divided
  // by 1,000,000 to convert it to cm/us or cm per microsecond,
  // which is 0.0343 cm/us.
  // The distance needs to be divided by 2 because
  // the time taken is the time for the sound wave to travel
  // to the object and back to the sensor.
  float distance_in_cm = time_taken_in_us * 0.0343 / 2;

  // Return the distance in cm from the ultrasonic sensor
  return distance_in_cm;
}
