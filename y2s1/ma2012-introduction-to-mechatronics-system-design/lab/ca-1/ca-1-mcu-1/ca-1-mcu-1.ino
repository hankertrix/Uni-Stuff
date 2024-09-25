// • The operations of the electric car are as follow:
//     ◦ The electric car is turned ON when toggle switch (TS)
//       is switched to HIGH.
//         ▪ Check the status of the gear shift stick
//             • If it is at Neutral, the LCD displays “Welcome” at Line 0
//               for the first 5s and then displays “Neutral”.
//               Nothing is displayed at Line 1.
//             • If it is NOT at Neutral, sounds the piezo buzzer once,
//               the LCD displays “Check Gear” at Line 0
//               and “Position” at Line 1.
//               All operations are suspended until the gear shift
//               returns to Neutral.
//         ▪ When TS is switched to LOW,
//           the LCD is OFF, and all operations will be halted.
//     ◦ The Slotted Opto Switch (SO) and
//       the Limit Switch (LS) are used to track the gear stick positions:
//         ▪ Neutral: SO is blocked.
//         ▪ Forward: SO is unblocked and LS is depressed.
//         ▪ Reverse: SO is unblocked and LS is opened.
//     ◦ In the Neutral mode:
//         ▪ The LCD displays “Neutral” at Line 0 and nothing at Line 1.
//         ▪ The foot pedal (Potentiometer POT) has no control of the DC motor.
//         ▪ The parking brake (Solenoid) is engaged (activated)
//           when the gear is shifted into the Neutral mode.
//         ▪ The parking brake is released (deactivated)
//           when the gear is shifted out of the Neutral mode.
//     ◦ In the Forward driving mode:
//         ▪ The POT controls the speed of the car.
//           Turning the POT controls the rotation speed of the DC Motor.
//           When POT = 0 – 5.0V, the DC Motor runs at 0 – 90% duty cycle
//           correspondingly in CCW direction (looking into the motor shaft).
//           Note: Always turn the POT to 0V before switching gear.
//         ▪ The LCD displays “Drive” at Line 0 and nothing at Line 1.
//     ◦ In the Reverse driving mode:
//         ▪ The POT controls the speed of the car at a lower speed
//           with 0 – 5.0V correspond to 0 – 60% duty cycle of the
//           DC Motor in CW direction.
//         ▪ The LCD displays “Reverse” at Line 0 and nothing at Line 1.
//         ▪ The piezo buzzer
//             • Beeps at 1 Hz when the Ultrasound Sensor (US)
//               senses no obstacle within 50 cm from the rear of the car
//             • Beeps at 2 Hz when US senses an obstacle within
//               50cm from the rear of the car.
//             • Beeps continuously when US senses an obstacle within
//               20 cm from the rear of the car.

// Assuming the circuit is connected as given in Figure 1

// The code below is for MCU 1

// The toggle switch is active low,
// the opto switch is also active low,
// but the limit switch is active high.

// Include the libraries
#include <SoftwareSerial.h>
#include <Wire.h>

// Define the pin numbers
#define TOGGLE_SWITCH_PIN 13
#define LIMIT_SWITCH_PIN 3
#define OPTO_SWITCH_PIN 4
#define ULTRASONIC_SENSOR_ECHO_PIN 7
#define ULTRASONIC_SENSOR_TRIGGER_PIN 6
#define SOLENOID_PIN 10
#define PIEZO_BUZZER_PIN 12
#define DC_MOTOR_A1_PIN 5
#define DC_MOTOR_A2_PIN 11
#define POTENTIOMETER_PIN A0
#define TX_PIN 8
#define RX_PIN 9

// Define the constants

// The beep tone, which is an E5
const int BEEP_TONE = 659;

// The tone duration for the piezo buzzer
const int TONE_DURATION = 500;

// The duration to display the welcome message for
// in milliseconds
const int WELCOME_MESSAGE_DURATION_IN_MS = 5000;

// The threshold value for the potentiometer
const int POTENTIOMETER_THRESHOLD_VALUE = 20;

// The line separator to print to the LCD screen
const char* LINE_SEPARATOR = "|";

// The enum for the gear position
enum GearPosition {
    NEUTRAL,
    FORWARD,
    REVERSE,
    NO_GEAR
};

// The enum for the DC motor direction
enum DcMotorDirection {
    CLOCKWISE,
    COUNTER_CLOCKWISE
};

// The enum for the measurement range.
// G stands for the acceleration due to gravity.
enum MeasurementRange {
    TWO_G,
    FOUR_G,
    EIGHT_G,
    SIXTEEN_G
};

// Initialise the measurement range to use
const MeasurementRange MEASUREMENT_RANGE = EIGHT_G;

// Initialise the accelerometer address
const uint8_t ACCELEROMETER_ADDRESS = 0x1D;

// Initialise the least significant bit of x
const uint8_t LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS = 0x32;

// The serial connection between the Arduinos
static SoftwareSerial ARDUINO_SERIAL(RX_PIN, TX_PIN);

// Initialise the gear position
GearPosition gear_position = NO_GEAR;

// Initialise the last message printed to the LCD
String last_printed_message = String("");

// Initialise the time when the welcome message
// was displayed in milliseconds
unsigned long welcome_message_displayed_time_in_ms = 0;

// Initialise the variable to store if the
// DC motor is on its first step
bool dc_motor_is_on_its_first_step = true;

// Initialise the variable to store whether the buzzer has beeped
bool buzzer_has_beeped = false;

// Initialise the time of the previous beep
unsigned long previous_beep_time_in_ms = 0;

// Initialise the duration of each beep
float beep_duration_in_ms = 100.0;

// Initialise the delay between each beep
float beep_delay_in_ms = 100.0;

// The function to write data using the I2C protocol to the accelerometer
void i2c_write_data(uint8_t register_address, uint8_t data_in_binary) {

    // Begin the I2C transmission
    Wire.beginTransmission(ACCELEROMETER_ADDRESS);

    // Write to the register address
    Wire.write(register_address);

    // Write the data in binary to the register
    Wire.write(data_in_binary);

    // End the I2C transmission
    Wire.endTransmission();
}

// The setup function to setup the Arduino
void setup() {

    // Set up the input pins
    pinMode(TOGGLE_SWITCH_PIN, INPUT);
    pinMode(LIMIT_SWITCH_PIN, INPUT);
    pinMode(OPTO_SWITCH_PIN, INPUT);
    pinMode(ULTRASONIC_SENSOR_ECHO_PIN, INPUT);
    pinMode(POTENTIOMETER_PIN, INPUT);
    pinMode(RX_PIN, INPUT);

    // Set up the output pins
    pinMode(ULTRASONIC_SENSOR_TRIGGER_PIN, OUTPUT);
    pinMode(SOLENOID_PIN, OUTPUT);
    pinMode(PIEZO_BUZZER_PIN, OUTPUT);
    pinMode(DC_MOTOR_A1_PIN, OUTPUT);
    pinMode(DC_MOTOR_A2_PIN, OUTPUT);
    pinMode(TX_PIN, OUTPUT);

    // Set up the serial connection
    Serial.begin(9600);

    // Set up the serial connection between the Arduinos
    ARDUINO_SERIAL.begin(9600);

    // Print that the Arduino is ready
    Serial.println("Arduino initialised!");

    // Initialise the I2C communication
    Wire.begin();

    // Start the measurement.
    // The POWER_CTL register is 0x2D,
    // and the measure bit is D3.
    i2c_write_data(0x2D, 0b00001000);

    // Change the measurement range to set one
    i2c_write_data(0x31, get_measurement_range_setting(MEASUREMENT_RANGE));
}

// Function to print to the LCD screen
void print_to_lcd(String line_1, String line_2) {

    // Create the string to send to the other Arduino to print
    String message = line_1 + String(LINE_SEPARATOR) + line_2;

    // If the message has already been printed,
    // then exit the function
    if (message == last_printed_message) return;

    // Otherwise, send the string to the other Arduino
    ARDUINO_SERIAL.println(message);

    // Save the current message as the last printed message
    last_printed_message = message;
}

// Function to sound the piezo buzzer once
void sound_piezo_buzzer_once() {

    // Play the note for the tone duration
    tone(PIEZO_BUZZER_PIN, BEEP_TONE, TONE_DURATION);

    // Wait for the tone duration
    delay(TONE_DURATION);

    // Stop the note from playing
    noTone(PIEZO_BUZZER_PIN);
}

// The function to check if the car can switch gear
bool can_switch_gear(GearPosition target_gear_position) {

    // If the current gear position is no gear,
    // then return true
    if (gear_position == NO_GEAR) return true;

    // If the current gear position is the
    // same as the target gear position, then return true
    if (gear_position == target_gear_position) return true;

    // Otherwise, the target gear position
    // is different from the current gear position,
    // so read the potentiometer value
    int potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // If the potentiometer value is less than the threshold value,
    // then return true.
    // Checking for less than a threshold value is to deal with noise
    // and fluctuations in the return voltage
    if (potentiometer_value < POTENTIOMETER_THRESHOLD_VALUE) return true;

    // Otherwise, return false
    return false;
}

// The function to handle the neutral gear position
void handle_neutral_gear() {

    // Stop the buzzer
    noTone(PIEZO_BUZZER_PIN);

    // If the gear cannot be switched,
    // exit the function
    if (!can_switch_gear(NEUTRAL)) {

        // Call the function to handle
        // the current gear position
        handle_gear_position(gear_position);

        // Exit the function
        return;
    };

    // Set the gear position to neutral
    gear_position = NEUTRAL;

    // Engage the parking brake,
    // which means to set the
    // solenoid pin to HIGH
    digitalWrite(SOLENOID_PIN, HIGH);

    // Get the current time in milliseconds
    unsigned long current_time_in_ms = millis();

    // If the time when the welcome message
    // is displayed is more than the time
    // it should be displayed for
    if (
            current_time_in_ms - welcome_message_displayed_time_in_ms
            > WELCOME_MESSAGE_DURATION_IN_MS
       ) {

        // Print "Neutral" to the LCD
        print_to_lcd(String("Neutral"), String(""));
    }

    // Otherwise, don't print anything to the LCD
}

// The function to start the car
void start_car() {

    // If the slotted opto switch is not blocked,
    // which means it is LOW
    if (digitalRead(OPTO_SWITCH_PIN) == LOW) {

        // If the buzzer has not been beeped
        if (!buzzer_has_beeped) {

            // Sound the piezo buzzer once
            sound_piezo_buzzer_once();

            // Set that the buzzer has been beeped
            buzzer_has_beeped = true;
        }

        // Print "Check Gear" and "Position"
        // to the LCD screen
        print_to_lcd(String("Check Gear"), String("Position"));

        // Exit the function
        return;
    }

    // Otherwise, the slotted opto switch
    // is blocked, which means the car is
    // in neutral gear,
    // so print "Welcome" to the LCD
    print_to_lcd(String("Welcome"), String(""));

    // Set the time when the welcome message
    // was displayed in milliseconds
    welcome_message_displayed_time_in_ms = millis();

    // Set the gear position to neutral
    gear_position = NEUTRAL;

    // Call the function to handle the neutral gear position
    handle_neutral_gear();
}

// The function to move the DC motor.
// The speed is an integer between -255 and 255.
void move_dc_motor(int speed) {

    // Get the absolute value of the speed
    int abs_speed = abs(speed);

    // If the absolute value of the speed
    // is less than the potentiometer threshold value.
    // This check for less than the threshold value is to deal with noise
    // and fluctuations in the potentiometer voltage
    if (abs_speed < 10) {

        // Set both of DC motor pins to LOW
        digitalWrite(DC_MOTOR_A1_PIN, LOW);
        digitalWrite(DC_MOTOR_A2_PIN, LOW);

        // Set the the DC motor is on its first step
        dc_motor_is_on_its_first_step = true;

        // Exit the function
        return;
    }

    // Otherwise, initialise the sign to counter clockwise,
    // as counter clockwise is the positive direction
    DcMotorDirection direction = COUNTER_CLOCKWISE;

    // If the speed given is negative,
    // then set the direction to clockwise
    if (speed < 0) direction = CLOCKWISE;

    // If the absolute value of the speed
    // is less than 60
    if (abs_speed < 60) {

        // Set the absolute value of the speed
        // to 60 so that the DC motor can
        // actually rotate
        abs_speed = 60;
    }

    // If the DC motor is on its first step
    if (dc_motor_is_on_its_first_step) {

        // Set the absolute value of the speed
        // to 200 to overcome the resistive forces
        abs_speed = 200;

        // Set that the DC motor is not on its first step
        dc_motor_is_on_its_first_step = false;
    }

    // If the direction is counter clockwise
    if (direction == COUNTER_CLOCKWISE) {

        // Write the speed to the motor driver A2 pin
        analogWrite(DC_MOTOR_A2_PIN, abs_speed);

        // Set the DC motor driver pin A1 to LOW
        digitalWrite(DC_MOTOR_A1_PIN, LOW);

        // Exit the function
        return;
    }

    // Otherwise, the direction is clockwise,
    // so write the speed to the motor driver A1 pin
    analogWrite(DC_MOTOR_A1_PIN, abs_speed);

    // Set the DC motor driver pin A2 to LOW
    digitalWrite(DC_MOTOR_A2_PIN, LOW);
}

// The function to get the measurement range setting.
// This is from page 17 of the data sheet, at the bottom,
// at table 18, under register 0x31.
uint8_t get_measurement_range_setting(MeasurementRange measurement_range) {
    switch (measurement_range) {
        case TWO_G:
            return 0b00000000;
        case FOUR_G:
            return 0b00000001;
        case EIGHT_G:
            return 0b00000010;
        case SIXTEEN_G:
            return 0b00000011;
        default:
            return 0;
    }
}

// The function to get the scale factor.
// This is from page 3 of the data sheet, under scale factor.
// The scale factor is listed in milli-Gs, so the values
// in the data sheet are divided by 1000 to make it G.
float get_scale_factor(MeasurementRange measurement_range) {
    switch (measurement_range) {
        case TWO_G:
            return 0.0039;
        case FOUR_G:
            return 0.0078;
        case EIGHT_G:
            return 0.0156;
        case SIXTEEN_G:
            return 0.0312;
        default:
            return 0.0;
    }
}

// The function to get the tilt angle
float get_tilt_angle_in_degrees(
    float x_acceleration,
    float y_acceleration,
    float z_acceleration
) {

    // Get the dot product of the acceleration data
    // with the unit vector of the z axis,
    // which is the normal to the x-y plane.
    //
    // The unit vector of the z axis is (0, 0, 1),
    // so the dot product is essentially just
    // the z acceleration.
    float dot_product = z_acceleration;

    // Get the magnitude of the acceleration data
    float magnitude_of_acceleration = sqrt(
        x_acceleration * x_acceleration
        + y_acceleration * y_acceleration
        + z_acceleration * z_acceleration
    );

    // Get the cosine of the tilt angle,
    // which is the angle between the acceleration vector
    // and the unit vector of the z axis.
    //
    // This is done by dividing the dot product
    // by the magnitude of the acceleration data
    // multiplied by the magnitude of the
    // unit vector of the z axis, which is 1,
    // so the denominator is just the magnitude of the
    // acceleration data.
    float cosine_of_tilt_angle =
        dot_product / magnitude_of_acceleration;

    // Get the tilt angle in radians
    // and the unit vector of the z axis in radians
    float tilt_angle_in_radians =
        acos(cosine_of_tilt_angle);

    // Convert the tilt angle into degrees
    float tilt_angle_in_degrees =
        tilt_angle_in_radians * 180 / PI;

    // Return the tilt angle in degrees
    return tilt_angle_in_degrees;
}

// Function to get the tilt angle from the accelerometer
float get_tilt_angle_from_accelerometer() {

    // Begin the transmission to the accelerometer
    Wire.beginTransmission(ACCELEROMETER_ADDRESS);

    // Send the address of the least significant bit of x.
    // The address is auto-increased after each read.
    Wire.write(LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS);

    // End the transmission to the accelerometer,
    // but keep the connection open,
    // which is the false argument passed to endTransmission
    Wire.endTransmission(false);

    // Request 6 bits of data from the accelerometer,
    // and stop the message after the transmission,
    // which is the true argument passed to endTransmission
    Wire.requestFrom(ACCELEROMETER_ADDRESS, uint8_t(6), uint8_t(true));

    // Read the data from the accelerometer.
    //
    // The least significant bit of x is read first,
    // so the second read is for the most significant bit,
    // which will need to be bitwise shifted
    // left by 8 bits to make the second bit the most
    // significant bit of the 16-bit integer.
    //
    // The bitwise OR operation just combines the two
    // bytes together to make a single 16-bit integer.
    int x = Wire.read() | Wire.read() << 8;
    int y = Wire.read() | Wire.read() << 8;
    int z = Wire.read() | Wire.read() << 8;

    // Get the scale factor
    float scale_factor = get_scale_factor(MEASUREMENT_RANGE);

    // Get the acceleration data for the x, y, and z axis
    float x_acceleration = x * scale_factor;
    float y_acceleration = y * scale_factor;
    float z_acceleration = z * scale_factor;

    // Get the tilt angle in degrees
    float tilt_angle_in_degrees = get_tilt_angle_in_degrees(
        x_acceleration, y_acceleration, z_acceleration
    );

    // If the x value is negative
    if (x < 0) {

        // Multiply the tilt angle by -1
        tilt_angle_in_degrees *= -1;
    }

    // Return the tilt angle in degrees
    return tilt_angle_in_degrees;
}

// The function to handle the forward gear position
void handle_forward_gear() {

    // Stop the buzzer
    noTone(PIEZO_BUZZER_PIN);

    // If the gear cannot be switched,
    // then exit the function
    if (!can_switch_gear(FORWARD)) {

        // Call the function to handle
        // the current gear position
        handle_gear_position(gear_position);

        // Exit the function
        return;
    }

    // Set the gear position to forward
    gear_position = FORWARD;

    // Disengage the parking brake,
    // which means to set the
    // solenoid pin to LOW
    digitalWrite(SOLENOID_PIN, LOW);

    // Print "Drive" to the LCD screen
    print_to_lcd(String("Drive"), String(""));

    // Read the potentiometer value
    int potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // Get the tilt angle from the accelerometer
    float tilt_angle_from_accelerometer = get_tilt_angle_from_accelerometer();

    // Initialise the start of the speed range
    int speed_range_start = 0;

    // Initialise the end of the speed range
    // 230 is 90% of 255
    int speed_range_end = 230;

    // If the tilt angle is more than 15 degrees
    if (tilt_angle_from_accelerometer > 15.0) {

        // Set the end of the speed range to 115
        speed_range_end = 115;
    }

    // Map the potentiometer value to the range 0 - 230
    // as 90% of 255 is 230
    int motor_speed = map(
        potentiometer_value, 0, 1023, speed_range_start, speed_range_end
    );

    // Move the DC motor by the given speed
    move_dc_motor(motor_speed);
}

// Function to calculate the distance of an object from the car
float calculate_distance_of_object_from_car() {

    // Reset the state of the ultrasonic sensor
    // trigger pin by setting it to LOW
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, LOW);

    // Delay for 2 microseconds for the sensor to respond
    delayMicroseconds(2);

    // Set the trigger pin to HIGH
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, HIGH);

    // Delay for 10 microseconds
    // so that the ultrasonic sensor
    // will send out an ultrasonic burst
    delayMicroseconds(10);

    // Set the trigger pin to LOW to reset its state
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, LOW);

    // Read the echo pin for the time taken in microseconds
    // for the ultrasonic burst to return
    int time_taken_in_us = pulseIn(ULTRASONIC_SENSOR_ECHO_PIN, HIGH);

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

// Function to sound the buzzer at a frequency in Hz
void sound_buzzer_at_frequency(int frequency_in_hz) {

    // Get the current time in milliseconds
    unsigned long current_time_in_ms = millis();

    // Get the total duration of the tone in milliseconds
    float total_beep_duration_in_ms = 1000.0 / float(frequency_in_hz);

    // Get the beep duration in milliseconds
    beep_duration_in_ms = 0.7 * total_beep_duration_in_ms;

    // Otherwise, if the time since the previous beep is
    // less than the total beep duration
    if (
            current_time_in_ms - previous_beep_time_in_ms
            < (unsigned long) total_beep_duration_in_ms
       ) {

        // Exit the function
        return;
    }

    // Otherwise, that means the time since
    // the previous beep is more than
    // the beep delay plus the tone duration
    // so play the tone
    tone(PIEZO_BUZZER_PIN, BEEP_TONE, beep_duration_in_ms);

    // Set the time of the previous beep
    // to the current time
    previous_beep_time_in_ms = millis();
}

// Function to sound the buzzer continuously
void sound_buzzer_continuously() {

    // Play the note
    tone(PIEZO_BUZZER_PIN, BEEP_TONE);
}

// The function to handle the reverse gear position
void handle_reverse_gear() {

    // If the gear cannot be switched
    if (!can_switch_gear(REVERSE)) {

        // Call the function to handle
        // the current gear position
        handle_gear_position(gear_position);

        // Exit the function
        return;
    }

    // Set the gear position to reverse
    gear_position = REVERSE;

    // Disengage the parking brake,
    // which means to set the
    // solenoid pin to LOW
    digitalWrite(SOLENOID_PIN, LOW);

    // Print "Reverse" to the LCD screen
    print_to_lcd(String("Reverse"), String(""));

    // Read the potentiometer value
    int potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // Get the tilt angle from the accelerometer
    float tilt_angle_from_accelerometer = get_tilt_angle_from_accelerometer();

    // Initialise the start of the speed range
    int speed_range_start = 0;

    // Initialise the end of the speed range
    // 153 is 60% of 255
    int speed_range_end = 153;

    // If the tilt angle is less than -15 degrees
    if (tilt_angle_from_accelerometer < -15.0) {

        // Set the end of the speed range to 0
        // to stop moving
        speed_range_end = 0;
    }

    // Map the potentiometer value to the range 0 to
    // the end of the speed range
    int motor_speed = map(
        potentiometer_value, 0, 1023, speed_range_start, speed_range_end
    );

    // Move the DC motor by the given speed,
    // but in the negative direction
    move_dc_motor(-motor_speed);

    // Calculate the distance of the object from the car
    float distance_of_object_from_car = calculate_distance_of_object_from_car();

    // If the distance of the object from the car is more than 50 cm
    if (distance_of_object_from_car > 50.0) {

        // Stop the buzzer
        noTone(PIEZO_BUZZER_PIN);

        // Sound the buzzer at a frequency of 1 Hz
        sound_buzzer_at_frequency(1);

        // Exit the function
        return;
    }

    // Otherwise, if the distance of the object from the car is more than 20 cm
    if (distance_of_object_from_car > 20.0) {

        // Stop the buzzer
        noTone(PIEZO_BUZZER_PIN);

        // Sound the buzzer at a frequency of 2 Hz
        sound_buzzer_at_frequency(2);

        // Exit the function
        return;
    }

    // Otherwise, the object is within 20 cm of the car
    // so sound the buzzer continuously
    sound_buzzer_continuously();
}

// The function to call the right function
// to handle the gear position
void handle_gear_position(GearPosition gear_position) {

    // Call the function to handle the gear position
    switch (gear_position) {
        case NEUTRAL:
            return handle_neutral_gear();
        case FORWARD:
            return handle_forward_gear();
        case REVERSE:
            return handle_reverse_gear();
        default:
            return;
    }
}

// The main loop function
void loop() {

    // If the toggle switch is set to LOW
    if (digitalRead(TOGGLE_SWITCH_PIN) == LOW) {

        // Print empty lines to the LCD screen
        print_to_lcd(String(""), String(""));

        // Deactivate the parking brake
        digitalWrite(SOLENOID_PIN, LOW);

        // Deactivate the motor
        move_dc_motor(0);

        // Stop the buzzer
        noTone(PIEZO_BUZZER_PIN);

        // Set the gear position to no gear
        gear_position = NO_GEAR;

        // Set that the buzzer has not been beeped
        buzzer_has_beeped = false;

        // Exit the function
        return;
    }

    // Otherwise, the toggle switch is set to HIGH,
    // so if the gear position is no gear,
    // which means the car was just turned on
    if (gear_position == NO_GEAR) {

        // Start the car
        start_car();

        // Exit the function
        return;
    }

    // Otherwise, if the slotted opto switch is blocked,
    // which means it is HIGH
    if (digitalRead(OPTO_SWITCH_PIN) == HIGH) {

        // Call the function to handle the neutral gear position
        handle_neutral_gear();

        // Exit the function
        return;
    }

    // Otherwise, the slotted opto switch is not blocked,
    // which means it is HIGH, so if the limit switch is
    // depressed, which means it is set to HIGH
    if (digitalRead(LIMIT_SWITCH_PIN) == HIGH) {

        // Call the function to handle the forward gear position
        handle_forward_gear();

        // Exit the function
        return;
    }

    // Otherwise, if the limit switch is not depressed,
    // which means it is set to LOW
    if (digitalRead(LIMIT_SWITCH_PIN) == LOW) {

        // Call the function to handle the reverse gear position
        handle_reverse_gear();

        // Exit the function
        return;
    }
}
