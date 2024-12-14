// The library for the DC motor driver

#include "DcMotorDriver.h"
#include "EEPROM.h"

// The constructor for the DC motor driver
DcMotorDriver::DcMotorDriver(DcMotorDriverParameters parameters)
    : _dc_motor_driver_pin_a1(parameters.dc_motor_driver_pin_a1),
      _dc_motor_driver_pin_a2(parameters.dc_motor_driver_pin_a2),
      _dc_motor_pin_a(parameters.dc_motor_pin_a),
      _dc_motor_pin_b(parameters.dc_motor_pin_b),
      _eeprom_address(parameters.eeprom_address),
      _minimum_position(parameters.minimum_position),
      _maximum_position(parameters.maximum_position),
      _allowable_error_in_position(parameters.allowable_error_in_position),
      _dc_motor_is_on_its_first_step(true), _position(0), _target_position(0),
      _speed(parameters.initial_speed), _last_time_written_to_eeprom(0) {

  // Initialise the position
  unsigned int position = 0;

  // Read the current position from the EEPROM
  EEPROM.get(this->_eeprom_address, position);

  // If the position is the maximum value, set it to 0
  if (position == UINT16_MAX) {
    position = 0;
  }

  // Write the position to the EEPROM
  EEPROM.put(this->_eeprom_address, position);

  // Save the position to the DC motor driver
  this->_position = position;

  // Set the target position to be the same as the position
  this->_target_position = position;

  // Initialise the driver pins to output
  pinMode(this->_dc_motor_driver_pin_a1, OUTPUT);
  pinMode(this->_dc_motor_driver_pin_a2, OUTPUT);

  // Initialise the DC motor pins to input
  pinMode(this->_dc_motor_pin_a, INPUT);
  pinMode(this->_dc_motor_pin_b, INPUT);
}

// The function to constrain a given position
int DcMotorDriver::_constrain_position(int position) {

  // Constrain the given position to be
  // between the minimum and maximum positions
  return constrain(position, this->_minimum_position, this->_maximum_position);
}

// The function to set the target position
void DcMotorDriver::_set_target_position(int absolute_target_position) {

  // Clamp the given target position to be
  // between the minimum and maximum positions
  this->_target_position = this->_constrain_position(absolute_target_position);
}

// The function to get the interrupt pin for the DC motor.
// We are interrupting on pin A, so return the DC motor pin A.
unsigned int DcMotorDriver::get_interrupt_pin() {
  return this->_dc_motor_pin_a;
}

// The function to set the speed of the DC motor.
// The speed of the DC motor is an integer between -255 and 255.
void DcMotorDriver::set_speed(unsigned int speed) { this->_speed = speed; }

// The function to write the position to the EEPROM
void DcMotorDriver::write_position_to_eeprom() {

  // If the time since the last write to the EEPROM is less than the minimum
  // time between writes to the EEPROM,
  // exit the function
  if (millis() - this->_last_time_written_to_eeprom <
      DC_MOTOR_DRIVER_MINIMUM_TIME_BETWEEN_WRITES_TO_EEPROM_IN_MS) {
    return;
  }

  // Otherwise, write the position to the EEPROM
  EEPROM.put(this->_eeprom_address, this->_position);
}

// The interrupt handler for the DC motor driver.
// The interrupt handler is attached to the DC motor pin A.
void DcMotorDriver::interrupt_handler() {

  // Disable interrupts
  noInterrupts();

  // If the DC motor pin B is HIGH,
  // which means that pin B is leading pin A,
  // or pin A is lagging pin B,
  // which means the DC motor is turning
  // clockwise, so increase the encoder position
  if (digitalRead(this->_dc_motor_pin_b) == HIGH) {
    this->_position++;
  }

  // Otherwise if the DC motor pin B is LOW,
  // which means that pin B is lagging pin A,
  // or pin A is leading pin B,
  // which means the DC motor is turning
  // anti-clockwise, so decrease the encoder position
  else if (digitalRead(this->_dc_motor_pin_b) == LOW) {
    this->_position--;
  }

  // Enable interrupts
  interrupts();
}

// The function to stop the DC motor
void DcMotorDriver::stop() {

  // Set both driver pins to low
  digitalWrite(this->_dc_motor_driver_pin_a1, LOW);
  digitalWrite(this->_dc_motor_driver_pin_a2, LOW);

  // Set that the DC motor is on its first step
  this->_dc_motor_is_on_its_first_step = true;
}

// The function to run the DC motor.
//
// This function needs to be called in the main loop.
void DcMotorDriver::run() {

  // Get the distance to go
  int distance_to_go = this->_target_position - this->_position;

  // If the speed is 0,
  // or if the distance to go is
  // within the allowable error in position
  if (this->_speed == 0 ||
      abs(distance_to_go) <= this->_allowable_error_in_position) {

    // Stop the DC motor
    this->stop();

    // Exit the function
    return;
  }

  // Initialise the speed fo the motor
  unsigned int motor_speed = this->_speed;

  // If the DC motor is on its first step
  if (this->_dc_motor_is_on_its_first_step) {

    // Set the absolute speed of the DC motor to 200
    // to overcome the friction of the DC motor
    motor_speed = 255;

    // Set that the DC motor is not on its first step
    this->_dc_motor_is_on_its_first_step = false;
  }

  // Clamp the absolute speed to be between
  // the minimum and maximum absolute speed
  motor_speed = constrain(motor_speed, DC_MOTOR_DRIVER_MINIMUM_ABSOLUTE_SPEED,
                          DC_MOTOR_DRIVER_MAXIMUM_ABSOLUTE_SPEED);

  // Initialise the direction of the motor
  // to be clockwise by default
  DcMotorDirection direction = distance_to_go < 0 ? ANTICLOCKWISE : CLOCKWISE;

  // Try to write the position to the EEPROM
  this->write_position_to_eeprom();

  // If the direction is clockwise
  if (direction == CLOCKWISE) {

    // Write the speed to the motor driver pin A1
    analogWrite(this->_dc_motor_driver_pin_a1, motor_speed);

    // Set the motor driver pin A2 to low
    digitalWrite(this->_dc_motor_driver_pin_a2, LOW);

    // Exit the function
    return;
  }

  // Otherwise, that means the direction is anticlockwise

  // Write the speed to the motor driver pin A2
  analogWrite(this->_dc_motor_driver_pin_a2, motor_speed);

  // Set the motor driver pin A1 to low
  digitalWrite(this->_dc_motor_driver_pin_a1, LOW);
}

// The function to move the DC motor to a specified position,
// which can be positive or negative
void DcMotorDriver::move_to_absolute_position(int absolute_position) {

  // Set the target position to be the given absolute position
  this->_set_target_position(absolute_position);
}

// The function to move the DC motor by a relative number of steps,
// which can be positive or negative
void DcMotorDriver::move_by_steps(int number_of_steps) {

  // Get the current position
  int current_position = this->_position;

  // Get the target position
  int target_position = current_position + number_of_steps;

  // Move to the target position
  this->move_to_absolute_position(target_position);
}

// Function to move the motor to the minimum position
void DcMotorDriver::move_to_minimum_position() {
  this->move_to_absolute_position(this->_minimum_position);
}

// Function to move the motor to the maximum position
void DcMotorDriver::move_to_maximum_position() {
  this->move_to_absolute_position(this->_maximum_position);
}

// Function to reset the position
void DcMotorDriver::reset_position() {

  // Set the position to be 0
  this->_position = 0;

  // Write the position to the EEPROM
  this->write_position_to_eeprom();
}
