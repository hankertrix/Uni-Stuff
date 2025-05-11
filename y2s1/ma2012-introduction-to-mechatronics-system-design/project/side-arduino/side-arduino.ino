// The code for the extra Arduino board on the side.
//
// This Arduino is just used to control a DC motor
// and nothing else.

// Include the libraries
#include "DcMotorDriver.h"

// Initialise the pins

// DC motor pins
static const unsigned int DC_MOTOR_DRIVER_PIN_A1 = 5;
static const unsigned int DC_MOTOR_DRIVER_PIN_A2 = 11;
static const unsigned int DC_MOTOR_PIN_A = 3;
static const unsigned int DC_MOTOR_PIN_B = 6;

// The DC motor toggle switch
static const unsigned int DC_MOTOR_TOGGLE_SWITCH_PIN = 4;

// Create the DC motor driver.
static DcMotorDriver DC_MOTOR_DRIVER(DcMotorDriverParameters{
    .dc_motor_driver_pin_a1 = DC_MOTOR_DRIVER_PIN_A1,
    .dc_motor_driver_pin_a2 = DC_MOTOR_DRIVER_PIN_A2,
    .dc_motor_pin_a = DC_MOTOR_PIN_A,
    .dc_motor_pin_b = DC_MOTOR_PIN_B,
    .eeprom_address = 0,
    .minimum_position = 0,
    .maximum_position = 94,
    .allowable_error_in_position = 5,
    .initial_speed = 75,
});

// The function to handle the DC motor encoder interrupt
void handle_dc_motor_encoder_interrupt() {

  // Disable interrupts
  noInterrupts();

  // Call the DC motor driver interrupt handler
  DC_MOTOR_DRIVER.interrupt_handler();

  // Enable interrupts
  interrupts();
}

// The setup function for the Arduino
void setup() {

  // Initialise the serial connection
  Serial.begin(9600);

  // Attach the DC motor encoder interrupt
  attachInterrupt(digitalPinToInterrupt(DC_MOTOR_DRIVER.get_interrupt_pin()),
                  handle_dc_motor_encoder_interrupt, RISING);

  // Reset the DC motor driver position
  DC_MOTOR_DRIVER.reset_position();

  // Print that the Arduino has initialised
  Serial.println("Arduino initialised");
}

// The loop function to run the Arduino
void loop() {

  // Get the state of the DC motor driver switch
  unsigned int dc_motor_toggle_switch_state =
      digitalRead(DC_MOTOR_TOGGLE_SWITCH_PIN);

  // If the toggle switch is set to high
  if (dc_motor_toggle_switch_state == HIGH) {

    // Move the DC motor to the maximum position
    DC_MOTOR_DRIVER.move_to_maximum_position();
  }

  // Otherwise
  else {

    // Move the DC motor to the minimum position
    DC_MOTOR_DRIVER.move_to_minimum_position();
  }

  // Run the DC motor driver
  DC_MOTOR_DRIVER.run();
}
