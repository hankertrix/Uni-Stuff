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

    // If the gear cannot be switched,
    // exit the function
    if (!can_switch_gear(NEUTRAL)) return;

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

// The function to handle the forward gear position
void handle_forward_gear() {

    // If the gear cannot be switched,
    // then exit the function
    if (!can_switch_gear(FORWARD)) return;

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

    // Map the potentiometer value to the range 0 - 230
    // as 90% of 255 is 230
    int motor_speed = map(potentiometer_value, 0, 1023, 0, 230);

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

// The function to handle the reverse gear position
void handle_reverse_gear() {

    // If the gear cannot be switched,
    // then exit the function
    if (!can_switch_gear(REVERSE)) return;

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

    // Map the potentiometer value to the range 0 - 153
    // as 60% of 255 is 153
    int motor_speed = map(potentiometer_value, 0, 1023, 0, 153);

    // Move the DC motor by the given speed,
    // but in the negative direction
    move_dc_motor(-motor_speed);

    // Calculate the distance of the object from the car
    float distance_of_object_from_car = calculate_distance_of_object_from_car();

    // If the distance of the object from the car is more than 50 cm
    if (distance_of_object_from_car > 50.0) {

        // Sound the buzzer at a frequency of 1 Hz
        sound_buzzer_at_frequency(1);

        // Exit the function
        return;
    }

    // Otherwise, if the distance of the object from the car is more than 20 cm
    if (distance_of_object_from_car > 20.0) {

        // Sound the buzzer at a frequency of 2 Hz
        sound_buzzer_at_frequency(2);

        // Exit the function
        return;
    }

    // Otherwise, the object is within 20 cm of the car
    // so sound the buzzer at a frequency of 5 Hz
    sound_buzzer_at_frequency(5);
}

// The main loop function
void loop() {

    // If the toggle switch is set to LOW
    if (digitalRead(TOGGLE_SWITCH_PIN) == LOW) {

        // Print empty lines to the LCD screen
        print_to_lcd(String(""), String(""));

        // Deactivate the parking brake
        digitalWrite(SOLENOID_PIN, LOW);

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
