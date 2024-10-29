// The code for the main Arduino board

#include "DcMotorDriver.h"
#include "FallDetector.h"

// Initialise the pins
static const unsigned int DC_MOTOR_1_DRIVER_PIN_A1 = 2;
static const unsigned int DC_MOTOR_1_DRIVER_PIN_A2 = 4;
static const unsigned int DC_MOTOR_1_PIN_A = 3;
static const unsigned int DC_MOTOR_1_PIN_B = 5;

// Create the DC motor driver
static const DcMotorDriver DC_MOTOR_DRIVER_1(DcMotorDriverParameters{
    .dc_motor_driver_pin_a1 = DC_MOTOR_1_DRIVER_PIN_A1,
    .dc_motor_driver_pin_a2 = DC_MOTOR_1_DRIVER_PIN_A2,
    .dc_motor_pin_a = DC_MOTOR_1_PIN_A,
    .dc_motor_pin_b = DC_MOTOR_1_PIN_B,
    .eeprom_address = 0,
    .minimum_position = -1000,
    .maximum_position = 1000,
    .allowable_error_in_position = 10,
    .initial_speed = 75,
});

void setup() {}

void loop() {}
