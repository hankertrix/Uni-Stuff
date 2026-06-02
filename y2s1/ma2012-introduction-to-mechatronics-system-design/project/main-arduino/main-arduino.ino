// The code for the main Arduino board

// Include the libraries
#include "DcMotorDriver.h"
#include "FallDetector.h"
#include "PiezoBuzzer.h"
#include "Servo.h"

// Initialise the pins

// DC motor
static const unsigned int DC_MOTOR_DRIVER_PIN_A1 = 5;
static const unsigned int DC_MOTOR_DRIVER_PIN_A2 = 6;
static const unsigned int DC_MOTOR_PIN_A = 3;
static const unsigned int DC_MOTOR_PIN_B = 4;

// Ultrasonic sensor 1 (connected to servo motor)
static const unsigned int ULTRASONIC_SENSOR_1_TRIGGER_PIN = 8;
static const unsigned int ULTRASONIC_SENSOR_1_ECHO_PIN = 13;
static const unsigned int SERVO_MOTOR_1_PIN = A0;

// Ultrasonic sensor 2 (connected to servo motor)
static const unsigned int ULTRASONIC_SENSOR_2_TRIGGER_PIN = 11;
static const unsigned int ULTRASONIC_SENSOR_2_ECHO_PIN = 12;
static const unsigned int SERVO_MOTOR_2_PIN = A1;

// Ultrasonic sensor 3 (not connected to servo motor).
// This ultrasonic sensor is used to detect the door.
static const unsigned int DOOR_ULTRASONIC_SENSOR_TRIGGER_PIN = 9;
static const unsigned int DOOR_ULTRASONIC_SENSOR_ECHO_PIN = 10;

// Other pins
static const unsigned int PIEZO_BUZZER_PIN = A3;
static const unsigned int DC_MOTOR_TOGGLE_SWITCH_PIN = 7;
static const unsigned int FALL_DETECTOR_INTERRUPT_PIN = 2;

// Constants
static const MeasurementRange ACCELEROMETER_MEASUREMENT_RANGE = EIGHT_G;
static const unsigned int THRESHOLD_DISTANCE_IN_CM_TO_CONSIDER_DOOR_OPEN = 2;

// Fall detector parameters

// Radar scanner parameters
static const unsigned int MINIMUM_NUMBER_OF_BLOCKED_SEGMENTS =
    0.6 * (RADAR_SCANNER_END_ANGLE - RADAR_SCANNER_START_ANGLE);
static const unsigned int MAXIMUM_NUMBER_OF_BREAKS = 5;
static const unsigned int MAXIMUM_NUMBER_OF_BLOCKED_SEGMENTS_FOR_EMPTY_ROOM = 5;

// Accelerometer parameters
static const unsigned int
    MINIMUM_ACCELERATION_DIFFERENCE_FOR_FORCE_SPIKE_IN_GS = 1;
static const unsigned int RECENCY_OF_ACCELEROMETER_DATA_IN_MS = 10000;

// Timing related parameters
static const unsigned long
    MINIMUM_TIME_TO_BE_CONSIDERED_A_FALL_WITHOUT_FORCE_SPIKE_IN_MS =
        60ul * 1000ul;
static const unsigned long
    MINIMUM_TIME_TO_BE_CONSIDERED_A_FALL_WITH_FORCE_SPIKE_IN_MS =
        30ul * 1000ul;

// The enum for the mode of the Arduino
enum ArduinoMode {
  OFF,
  ON,
  ALARM,
};

// The mode of the Arduino
static ArduinoMode ARDUINO_MODE = OFF;

// The variable to store whether the
// fall detector is running
static bool FALL_DETECTOR_RUNNING = false;

// Create the DC motor driver
static DcMotorDriver DC_MOTOR_DRIVER(DcMotorDriverParameters{
    .dc_motor_driver_pin_a1 = DC_MOTOR_DRIVER_PIN_A1,
    .dc_motor_driver_pin_a2 = DC_MOTOR_DRIVER_PIN_A2,
    .dc_motor_pin_a = DC_MOTOR_PIN_A,
    .dc_motor_pin_b = DC_MOTOR_PIN_B,
    .eeprom_address = 0,
    .minimum_position = -20,
    .maximum_position = 0,
    .allowable_error_in_position = 5,
    .initial_speed = 75,
});

// Create the first ultrasonic sensor
static UltrasonicSensor ULTRASONIC_SENSOR_1(ULTRASONIC_SENSOR_1_TRIGGER_PIN,
                                            ULTRASONIC_SENSOR_1_ECHO_PIN);

// Create the second ultrasonic sensor
static UltrasonicSensor ULTRASONIC_SENSOR_2(ULTRASONIC_SENSOR_2_TRIGGER_PIN,
                                            ULTRASONIC_SENSOR_2_ECHO_PIN);

// Create the third ultrasonic sensor for the door sensor
static UltrasonicSensor
    DOOR_ULTRASONIC_SENSOR(DOOR_ULTRASONIC_SENSOR_TRIGGER_PIN,
                           DOOR_ULTRASONIC_SENSOR_ECHO_PIN);

// Create the accelerometer
static Accelerometer ACCELEROMETER(ACCELEROMETER_MEASUREMENT_RANGE);

// Create the servo motors
static Servo SERVO_MOTOR_1;
static Servo SERVO_MOTOR_2;

// The variables for the sweeping of the servo motor
static unsigned int CURRENT_ANGLE = 0;
static int CHANGE_IN_SWEEP_ANGLE = 1;
static unsigned long PREVIOUS_SWEEP_TIME = 0;

// Create the array of radar scanners
static RadarScanner RADAR_SCANNERS[FALL_DETECTOR_NUMBER_OF_RADAR_SCANNERS] = {
    RadarScanner(RadarScannerParameters{
        .ultrasonic_sensor = ULTRASONIC_SENSOR_1,
    }),
    RadarScanner(RadarScannerParameters{
        .ultrasonic_sensor = ULTRASONIC_SENSOR_2,
    }),
};

// Create the fall detector
static FallDetector FALL_DETECTOR(FallDetectorParameters{
    .accelerometer = ACCELEROMETER,
    .radar_scanners = RADAR_SCANNERS,
    .interrupt_pin = FALL_DETECTOR_INTERRUPT_PIN,
    .minimum_number_of_blocked_segments = MINIMUM_NUMBER_OF_BLOCKED_SEGMENTS,
    .maximum_number_of_breaks = MAXIMUM_NUMBER_OF_BREAKS,
    .maximum_number_of_blocked_segments_for_empty_room =
        MAXIMUM_NUMBER_OF_BLOCKED_SEGMENTS_FOR_EMPTY_ROOM,
    .minimum_acceleration_difference_for_force_spike_in_gs =
        MINIMUM_ACCELERATION_DIFFERENCE_FOR_FORCE_SPIKE_IN_GS,
    .recency_of_accelerometer_data_in_ms = RECENCY_OF_ACCELEROMETER_DATA_IN_MS,
    .minimum_time_to_be_considered_a_fall_without_force_spike_in_ms =
        MINIMUM_TIME_TO_BE_CONSIDERED_A_FALL_WITHOUT_FORCE_SPIKE_IN_MS,
    .minimum_time_to_be_considered_a_fall_with_force_spike_in_ms =
        MINIMUM_TIME_TO_BE_CONSIDERED_A_FALL_WITH_FORCE_SPIKE_IN_MS,
});

// Create the piezo buzzer
static PiezoBuzzer PIEZO_BUZZER(PIEZO_BUZZER_PIN);

// The interrupt handler for the fall detector
void fall_detector_interrupt_handler() {

  // Disable interrupts
  noInterrupts();

  // Set the mode to alarm
  ARDUINO_MODE = ALARM;

  // Set the interrupt pin back to low
  digitalWrite(FALL_DETECTOR_INTERRUPT_PIN, LOW);

  // Enable interrupts
  interrupts();
}

// The interrupt handler for the DC motor driver
void dc_motor_driver_interrupt_handler() {

  // Disable interrupts
  noInterrupts();

  // Call the function to handle the DC motor driver interrupt
  DC_MOTOR_DRIVER.interrupt_handler();

  // Enable interrupts
  interrupts();
}

// The setup function to setup the Arduino
void setup() {

  // Initialise the serial connection
  Serial.begin(9600);

  // Initialise the servo motors
  SERVO_MOTOR_1.attach(SERVO_MOTOR_1_PIN);
  SERVO_MOTOR_2.attach(SERVO_MOTOR_2_PIN);

  // Write the start of the angle range
  SERVO_MOTOR_1.write(RADAR_SCANNER_START_ANGLE);
  SERVO_MOTOR_2.write(RADAR_SCANNER_START_ANGLE);

  // Print that the servo motors have been initialised
  Serial.println(F("Servo motors initialised"));

  // Initialise the fall detector
  FALL_DETECTOR.initialise();

  // Print that the fall detector has been initialised
  Serial.println(F("Fall detector initialised"));

  // Attach the interrupt handler for the fall detector
  attachInterrupt(digitalPinToInterrupt(FALL_DETECTOR_INTERRUPT_PIN),
                  fall_detector_interrupt_handler, RISING);

  // Attach the interrupt handler for the DC motor driver
  attachInterrupt(digitalPinToInterrupt(DC_MOTOR_DRIVER.get_interrupt_pin()),
                  dc_motor_driver_interrupt_handler, RISING);

  // Reset the position of the DC motor driver
  DC_MOTOR_DRIVER.reset_position();

  // Print that the interrupts have been attached
  Serial.println(F("Interrupts attached"));

  // Print that the Arduino is initialised
  Serial.println(F("Arduino initialised"));
}

// The function to handle the alarm mode
// of the Arduino
void handle_alarm_mode() {

  // Sound the piezo buzzer
  PIEZO_BUZZER.sound_buzzer_at_frequency(3);
}

// The function to get whether the door is open
bool door_is_open() {

  // Get the distance from the ultrasonic sensor for the door
  float door_distance = DOOR_ULTRASONIC_SENSOR.get_distance_in_cm();

  // Return if the distance is more than the threshold
  // for the door being open
  return door_distance > THRESHOLD_DISTANCE_IN_CM_TO_CONSIDER_DOOR_OPEN;
}

// The function to sweep the servo motors
bool sweep(bool save_to_initial_distance_array) {

  // Initialise whether a full sweep has been completed
  bool full_sweep_completed = false;

  // If the time since the previous sweep is less than the delay
  // in ms, exit the function and return the full sweep completed
  // variable
  if (millis() - PREVIOUS_SWEEP_TIME < RADAR_SCANNER_SERVO_MOTOR_DELAY_IN_MS) {
    return full_sweep_completed;
  }

  // Constrain the current angle to between the start angle
  // and the end angle.
  //
  // We technically shouldn't need to do this, since the angle
  // can't go past the start and end angle, but this is just
  // in case.
  unsigned int current_angle = constrain(
      CURRENT_ANGLE, RADAR_SCANNER_START_ANGLE, RADAR_SCANNER_END_ANGLE);

  // Get the change in sweep angle
  int change_in_sweep_angle = CHANGE_IN_SWEEP_ANGLE;

  // If the current angle is the same as the start angle
  if (current_angle == RADAR_SCANNER_START_ANGLE) {

    // Set the change in sweep angle to 1
    change_in_sweep_angle = 1;

    // Set the full sweep completed variable to true
    full_sweep_completed = true;
  }

  // Otherwise, if the current angle is the same as the end angle
  else if (current_angle == RADAR_SCANNER_END_ANGLE) {

    // Set the change in sweep angle to -1
    change_in_sweep_angle = -1;

    // Set the full sweep completed variable to true
    full_sweep_completed = true;
  }

  // We need to save the distance for the current angle first,
  // as the motor has moved to the current angle.
  //
  // But once you change the angle, the motor is no longer
  // in the position for the new angle to get the new
  // distance, since you need to wait for the motor
  // to move to the new angle.
  //
  // Hence we get the distance for the current angle
  // before changing the angle as we know that the
  // servo motor is definitely in the position
  // for the current angle.
  //
  // So we save the distance for the current angle.
  FALL_DETECTOR.run(current_angle, save_to_initial_distance_array,
                    full_sweep_completed);

  // Change the current angle by the change in sweep angle
  current_angle = current_angle + change_in_sweep_angle;

  // Move the servo motors to the new current angle
  SERVO_MOTOR_1.write(current_angle);
  SERVO_MOTOR_2.write(current_angle);

  // Set the current angle and the change in sweep angle
  CURRENT_ANGLE = current_angle;
  CHANGE_IN_SWEEP_ANGLE = change_in_sweep_angle;

  // Set the previous sweep time to the current time
  PREVIOUS_SWEEP_TIME = millis();

  // Return the full sweep completed variable
  return full_sweep_completed;
}

// The function to save the initial distances
void save_initial_distances() {

  // While the angle is not at the end angle
  while (CURRENT_ANGLE != RADAR_SCANNER_END_ANGLE) {

    // Sweep the servo motors
    sweep(true);
  }
}

// The function to sweep the servo motors without arguments
bool sweep() { return sweep(false); }

// The main loop function of the Arduino
void loop() {

  // Get whether the door is open
  bool door_open = true;

  // Get the current Arduino mode
  ArduinoMode current_arduino_mode = ARDUINO_MODE;

  // If the current Arduino mode is alarm,
  // call the function to handle
  // the alarm mode and exit the function
  if (current_arduino_mode == ALARM) {
    return handle_alarm_mode();
  }

  // Stop the piezo buzzer
  PIEZO_BUZZER.stop_buzzer();

  // If the door is open,
  // and the fall detector is not running,
  // and the current Arduino mode is off
  if (door_open && !FALL_DETECTOR_RUNNING && current_arduino_mode == OFF) {

    // Save the initial distances
    save_initial_distances();

    // Print that the distances have been initialised
    Serial.println(F("Distances initialised"));

    // Set the Arduino mode to on
    ARDUINO_MODE = ON;
  }

  // If the door is closed,
  // and the fall detector is not running,
  // and the current Arduino mode is on
  if (!door_open && !FALL_DETECTOR_RUNNING && current_arduino_mode == ON) {

    // Set the Arduino mode to off
    ARDUINO_MODE = OFF;
  }

  // If the Arduino mode is off, exit the function
  if (ARDUINO_MODE == OFF) {
    return;
  }

  // Otherwise, sweep the servo motors
  sweep();

  // Get the state of the DC motor toggle switch
  unsigned int dc_motor_toggle_switch_state =
      digitalRead(DC_MOTOR_TOGGLE_SWITCH_PIN);

  // If the toggle switch is set to high
  if (dc_motor_toggle_switch_state == HIGH) {

    // Move the DC motor to the maximum position
    DC_MOTOR_DRIVER.move_to_maximum_position();
  }

  // Otherwise, if the toggle switch is set to low
  else {

    // Move the DC motor to the minimum position
    DC_MOTOR_DRIVER.move_to_minimum_position();
  }

  // Run the DC motor driver
  // DC_MOTOR_DRIVER.run();
}
