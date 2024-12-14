// The library for the DC motor driver

#ifndef DC_MOTOR_DRIVER_H
#define DC_MOTOR_DRIVER_H

#include "Arduino.h"

// The minimum speed for the DC motor
static const int DC_MOTOR_DRIVER_MINIMUM_ABSOLUTE_SPEED = 60;

// The maximum speed for the DC motor
static const int DC_MOTOR_DRIVER_MAXIMUM_ABSOLUTE_SPEED = 255;

// The minimum time between writes to the EEPROM in milliseconds
static const unsigned long
    DC_MOTOR_DRIVER_MINIMUM_TIME_BETWEEN_WRITES_TO_EEPROM_IN_MS =
        300ul * 1000ul;

// The DC motor direction
enum DcMotorDirection { CLOCKWISE, ANTICLOCKWISE };

// The parameters for the DC motor driver
struct DcMotorDriverParameters {
  unsigned int dc_motor_driver_pin_a1;
  unsigned int dc_motor_driver_pin_a2;
  unsigned int dc_motor_pin_a;
  unsigned int dc_motor_pin_b;
  unsigned int eeprom_address;
  int minimum_position;
  int maximum_position;

  // The allowable error in the position
  // should be 5 - 10
  int allowable_error_in_position;

  // The initial speed of the DC motor
  unsigned int initial_speed;
};

// The class for the DC motor driver
class DcMotorDriver {

private:
  //

  // Saved parameters
  const unsigned int _dc_motor_driver_pin_a1;
  const unsigned int _dc_motor_driver_pin_a2;
  const unsigned int _dc_motor_pin_a;
  const unsigned int _dc_motor_pin_b;
  const unsigned int _eeprom_address;
  const int _minimum_position;
  const int _maximum_position;
  const unsigned int _allowable_error_in_position;

  // State variables
  bool _dc_motor_is_on_its_first_step;
  int _position;
  int _target_position;
  unsigned int _speed;
  unsigned long _last_time_written_to_eeprom;

  // Functions
  int _constrain_position(int position);
  void _set_target_position(int absolute_target_position);

public:
  //

  // Constructor
  DcMotorDriver(DcMotorDriverParameters parameters);

  // Methods
  unsigned int get_interrupt_pin();
  void set_speed(unsigned int speed);
  void write_position_to_eeprom();
  void interrupt_handler();
  void stop();
  void run();
  void move_to_absolute_position(int absolute_position);
  void move_by_steps(int number_of_steps);
  void move_to_minimum_position();
  void move_to_maximum_position();
  void reset_position();
};

#endif
