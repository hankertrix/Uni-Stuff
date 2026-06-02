/*
 * Exercise 2: Gantry Crane
 * Write a program to perform the following tasks:
 * - An operator uses the potentiometer to control the servomotor
 *   which positions the hoist of a Gantry Crane over an object placed
 *   around the mid point across the width of the crane (i.e.
 *   servomotor position between 80-100 deg).
 * - When the hoist is in position, activating the push button shall
 *   rotate the DC motor to raise/lower the cable to grab the object.
 *   Releasing the push button shall stop the DC motor.
 * - A toggle switch is used to control the direction of the cable:
 *      HIGH = raising; LOW = lowering.
 * - The push button shall not activate the DC
 *   motor if the servomotor is not in position
 *   (outside 80-100 deg)
 *
 * With reference to the above exercise:
 * - Replace the servo motor with a DC motor with encoder
 * - Replace the DC motor with a stepper motor
 */

// Assuming circuit 2A is used
// with the potentiometer connected to analog pin A5,
// the push button being connected like in circuit 1A
// to pin 9 (active low), and the toggle switch
// being connected to pin 10.
//
// Not connecting the switches in this way will cause
// the switches to have inconsistent output.

// Libraries
#include "UCN5804.h"
#include <Servo.h>
#include <EEPROM.h>

// Define the pins
#define SERVO_MOTOR_PIN 4
#define DC_MOTOR_DRIVER_PIN_A1 5
#define DC_MOTOR_DRIVER_PIN_A2 11
#define DC_MOTOR_PIN_A 2
#define DC_MOTOR_PIN_B 3
#define STEPPER_MOTOR_DIRECTION_PIN 13
#define STEPPER_MOTOR_STEP_PIN 12
#define STEPPER_MOTOR_ENABLE_PIN 8
#define STEPPER_MOTOR_HALF_STEP_PIN 7
#define STEPPER_MOTOR_PHASE_PIN 6
#define POTENTIOMETER_PIN A5
#define TOGGLE_SWITCH_PIN 9
#define PUSH_BUTTON_PIN 10

// Define the stepper motor speed
#define STEPPER_MOTOR_SPEED 300

// Define the number of steps for the stepper motor
#define STEPPER_MOTOR_NUMBER_OF_STEPS 200

// Define the number of degrees per step for the stepper motor
#define STEPPER_MOTOR_DEGREES_PER_STEP 1.8

// Define the DC motor speed
#define DC_MOTOR_SPEED 75

// Define the number of degrees per step for the DC motor with encoder
#define DC_MOTOR_ENCODER_STEPS_PER_DEGREE 374.0 / 360.0

// Define the error for the DC motor with encoder
#define DC_MOTOR_ENCODER_ERROR 5

// Define the motor type
#define MOTOR_TYPE SERVO_MOTOR_AND_DC_MOTOR

// Define the EEPROM address
#define EEPROM_ADDRESS 0

// The enum representing the motor type to use
enum MotorType {
    SERVO_MOTOR_AND_DC_MOTOR,
    DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR,
};

// Initialise the encoder position,
// positive is clockwise and
// negative is anti-clockwise.
//
// Initialising at 90 degrees so that the starting position
// is in the middle of 45 and 135 degrees
int encoder_position = 90.0 * DC_MOTOR_ENCODER_STEPS_PER_DEGREE;

// Initialise the variable to store whether the DC motor is
// on its first step
bool dc_motor_is_first_step = true;

// Initialise the servo motor
Servo servo_motor;

// Initialise the stepper motor
UCN5804 stepper_motor(STEPPER_MOTOR_NUMBER_OF_STEPS,
                      STEPPER_MOTOR_DIRECTION_PIN, STEPPER_MOTOR_STEP_PIN,
                      STEPPER_MOTOR_HALF_STEP_PIN, STEPPER_MOTOR_PHASE_PIN);

// The interrupt service routine
// on the DC motor pin A
// to increase or decrease the encoder position
void encoder_interrupt() {

    // If the DC motor pin B is HIGH,
    // which means that pin B is leading pin A,
    // or pin A is lagging pin B,
    // which means the DC motor is turning
    // clockwise, so increase the encoder position
    if (digitalRead(DC_MOTOR_PIN_B) == HIGH) {
        encoder_position++;
    }

    // Otherwise if the DC motor pin B is LOW,
    // which means that pin B is lagging pin A,
    // or pin A is leading pin B,
    // which means the DC motor is turning
    // anti-clockwise, so decrease the encoder position
    else if (digitalRead(DC_MOTOR_PIN_B) == LOW) {
        encoder_position--;
    }
}

// Function to set up the Arduino
void setup() {

    // Initialise the output pins
    pinMode(SERVO_MOTOR_PIN, OUTPUT);
    pinMode(DC_MOTOR_DRIVER_PIN_A1, OUTPUT);
    pinMode(DC_MOTOR_DRIVER_PIN_A2, OUTPUT);
    pinMode(STEPPER_MOTOR_DIRECTION_PIN, OUTPUT);
    pinMode(STEPPER_MOTOR_STEP_PIN, OUTPUT);
    pinMode(STEPPER_MOTOR_ENABLE_PIN, OUTPUT);
    pinMode(STEPPER_MOTOR_HALF_STEP_PIN, OUTPUT);
    pinMode(STEPPER_MOTOR_PHASE_PIN, OUTPUT);

    // Initialise the input pins
    pinMode(DC_MOTOR_PIN_A, INPUT);
    pinMode(DC_MOTOR_PIN_B, INPUT);
    pinMode(POTENTIOMETER_PIN, INPUT);
    pinMode(PUSH_BUTTON_PIN, INPUT);
    pinMode(TOGGLE_SWITCH_PIN, INPUT);

    // Set the stepper motor speed to the default motor speed
    stepper_motor.setSpeed(STEPPER_MOTOR_SPEED);

    // If the motor type is DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR
    if (MOTOR_TYPE == DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR) {

        // Attach the interrupt service routine
        // for the encoder when the DC motor pin A is rising
        attachInterrupt(digitalPinToInterrupt(DC_MOTOR_PIN_A),
                encoder_interrupt,
                RISING);

        // Read the EEPROM for the stored encoder position
        int stored_encoder_position = EEPROM.read(EEPROM_ADDRESS);

        // If the encoder position is 255
        if (stored_encoder_position == 255) {

            // Save the encoder position
            EEPROM.write(EEPROM_ADDRESS, encoder_position);
        }
    }

    // Otherwise, if the motor type is SERVO_MOTOR_AND_DC_MOTOR
    else if (MOTOR_TYPE == SERVO_MOTOR_AND_DC_MOTOR) {

        // Attach the servo motor to the pin
        servo_motor.attach(SERVO_MOTOR_PIN);
    }

    // Initialise the serial connection
    Serial.begin(9600);

    // Print that the Arduino has been initialised
    Serial.println("Arduino initialised");
}

// Function to move the DC motor.
// The speed is an integer between -255 and 255
void move_dc_motor(int speed) {

    // Set the minimum speed of the DC motor to 60
    // as that is needed to move the motor,
    // so if the absolute value of the speed is less than 60
    if (abs(speed) < 60) {

        // Set both pins to LOW
        digitalWrite(DC_MOTOR_DRIVER_PIN_A1, LOW);
        digitalWrite(DC_MOTOR_DRIVER_PIN_A2, LOW);

        // Set that the DC motor is on its first step
        dc_motor_is_first_step = true;

        // Exit the function
        return;
    }

    // Otherwise, the absolute value of the speed is greater than 60
    // so if the speed is positive
    if (speed > 0) {

        // If the DC motor is on its first step
        if (dc_motor_is_first_step) {

            // Set the DC motor speed to 200
            speed = 200;

            // Set that the DC motor is not on its first step
            dc_motor_is_first_step = false;
        }

        // Write the speed to the motor driver pin A1
        analogWrite(DC_MOTOR_DRIVER_PIN_A1, speed);

        // Set the motor driver pin A2 to LOW
        digitalWrite(DC_MOTOR_DRIVER_PIN_A2, LOW);

        // Exit the function
        return;
    }

    // Otherwise, the speed is negative,
    // so if the DC motor is on its first step
    if (dc_motor_is_first_step) {

        // Set the DC motor speed to -200
        speed = -200;

        // Set that the DC motor is not on its first step
        dc_motor_is_first_step = false;
    }

    // Write the speed to the motor driver pin A2
    analogWrite(DC_MOTOR_DRIVER_PIN_A2, abs(speed));

    // Set the motor driver pin A1 to LOW
    digitalWrite(DC_MOTOR_DRIVER_PIN_A1, LOW);
}

// Function to position the hoist with the DC motor
void position_hoist_with_dc_motor(int position_in_degrees) {

    // Convert the position in degrees to the encoder position
    int target_position = float(position_in_degrees) *
        DC_MOTOR_ENCODER_STEPS_PER_DEGREE;

    // Initialise the direction multiplier
    int direction_multiplier = 1;

    // Initialise the DC motor speed
    int dc_motor_speed = 0;

    // If the difference between the current position and the target position
    // is less than the error
    if (abs(encoder_position - target_position) < DC_MOTOR_ENCODER_ERROR) {

        // Reset the DC motor by running it at zero speed
        move_dc_motor(0);

        // Save the encoder position
        EEPROM.write(EEPROM_ADDRESS, encoder_position);

        // Exit the function
        return;
    }

    // Otherwise, the DC motor needs to be moved,
    // so if the target position is greater than the current position,
    if (target_position > encoder_position) {

        // Set the direction multiplier to 1 to move the DC motor clockwise
        direction_multiplier = 1;
    }

    // Otherwise, the target position is less than the current position,
    else if (target_position < encoder_position) {

        // Set the direction multiplier to -1
        // to move the DC motor anti-clockwise
        direction_multiplier = -1;
    }

    // Set the DC motor speed to the motor speed
    dc_motor_speed = DC_MOTOR_SPEED;

    // Move the DC motor
    move_dc_motor(dc_motor_speed * direction_multiplier);
}

// Function to position the hoist to the desired position in degrees
void position_hoist(int position_in_degrees) {

    // If the motor type is SERVO_MOTOR_AND_DC_MOTOR
    if (MOTOR_TYPE == SERVO_MOTOR_AND_DC_MOTOR) {

        // Move the servo motor to the desired position
        servo_motor.write(position_in_degrees);

        // Wait for the servo motor to reach the desired position
        delay(1500);
    }

    // Otherwise if the motor type is DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR
    else if (MOTOR_TYPE == DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR) {

        // Call the function to position the hoist with the DC motor
        position_hoist_with_dc_motor(position_in_degrees);
    }
}

// The function to raise and lower the cable
void move_cable() {

    // While the push button is pressed
    while (digitalRead(PUSH_BUTTON_PIN) == LOW) {

        // If the motor type is SERVO_MOTOR_AND_DC_MOTOR
        if (MOTOR_TYPE == SERVO_MOTOR_AND_DC_MOTOR) {

            // If the toggle switch is HIGH, raise the cable
            // using the DC motor
            if (digitalRead(TOGGLE_SWITCH_PIN) == HIGH) {
                move_dc_motor(DC_MOTOR_SPEED);
            }

            // Otherwise, lower the cable using the DC motor
            else {
                move_dc_motor(-DC_MOTOR_SPEED);
            }
        }

        // Otherwise if the motor type is
        // DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR
        else if (MOTOR_TYPE == DC_MOTOR_WITH_ENCODER_AND_STEPPER_MOTOR) {

            // If the toggle switch is HIGH, raise the cable
            // using the stepper motor
            if (digitalRead(TOGGLE_SWITCH_PIN) == HIGH) {
                stepper_motor.step(10);
            }

            // Otherwise, lower the cable using the stepper motor
            else {
                stepper_motor.step(-10);
            }
        }
    }

    // If the motor type is SERVO_MOTOR_AND_DC_MOTOR
    if (MOTOR_TYPE == SERVO_MOTOR_AND_DC_MOTOR) {

        // Stop the DC motor
        move_dc_motor(0);
    }
}

// The main loop function
void loop() {

    // Read the potentiometer value
    int potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // Map the potentiometer value to the range 45 - 135.
    int position_in_degrees = map(potentiometer_value, 0, 1023, 45, 135);

    // Position the hoist
    position_hoist(position_in_degrees);

    // If the hoist is in position
    if (position_in_degrees >= 80 && position_in_degrees <= 100) {

        // Call the function to move the cable
        move_cable();
    }
}
