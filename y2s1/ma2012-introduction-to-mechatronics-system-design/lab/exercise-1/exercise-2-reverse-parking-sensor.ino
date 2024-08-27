/*
Exercise 1-2: Reverse Parking Sensor
Write a program to perform the following tasks:
   1. Use the Ultrasonic sensor to sense the distance, D of
      a car's rear bumper from an obstacle
      - The sensor is turned on when the Slotted Opto Switch is blocked.
      - Once the sensor is turned on,
        * Sound the buzzer
          + At 1 Hz if D > 40 cm
          + At 2 Hz if 20 cm < D ≤ 40 cm
          + Continuously if D ≤ 20 cm
   2. Repeat Part 1 with the Analog Distance Sensor
*/

// Assuming circuit 1B is used
// with the buzzer connected to pin 10

// Define the pin numbers
#define SLOTTED_OPTO_SWITCH_PIN 5
#define ULTRASONIC_SENSOR_ECHO_PIN 8
#define ULTRASONIC_SENSOR_TRIGGER_PIN 9
#define ANALOG_DISTANCE_SENSOR_PIN A5
#define PIEZO_BUZZER_PIN 10

// The frequency of the tone to play,
// which is an E5
#define BEEP_TONE 659

// The boolean to determine whether to use the analog distance sensor
#define USE_ANALOG_DISTANCE_SENSOR false

// Initialise the variables needed
bool buzzer_on = false;
float beep_duration_in_milliseconds = 0;
float beep_delay_in_milliseconds = 0;
int beep_frequency_in_hz = 0;
unsigned int beep_counter = 0;
unsigned long previous_beep_time = 0;

// The setup function to set up the program
void setup() {

    // Set the pin modes of all the input pins
    pinMode(ULTRASONIC_SENSOR_ECHO_PIN, INPUT);
    pinMode(ANALOG_DISTANCE_SENSOR_PIN, INPUT);

    // Set the pin mode of all the output pins
    pinMode(SLOTTED_OPTO_SWITCH_PIN, OUTPUT);
    pinMode(PIEZO_BUZZER_PIN, OUTPUT);

    // Initialise the serial connection
    Serial.begin(9600);

    // Print that the Arduino is ready
    Serial.println("Arduino initialised.");
}

// Function to get the distance in cm from the sensor
float get_distance_in_cm(bool use_analog_distance_sensor) {

    // If the analog distance sensor is used
    if (use_analog_distance_sensor) {

        // Get the voltage value from the analog distance sensor
        int voltage_value = analogRead(ANALOG_DISTANCE_SENSOR_PIN);

        // Assume that the distance is more than 10 cm
        // and use the regression equation to calculate the distance
        // from the voltage value, which is
        // 28.987390360228x^(-1.1544716085358)
        float distance_in_cm =
            28.987390360288 * pow(voltage_value, -1.1544716085358);

        // Return the distance in cm from the analog distance sensor
        return distance_in_cm;
    }

    // Otherwise, use the ultrasonic sensor.
    // Reset the state of the trigger pin.
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, LOW);

    // Delay for 2 microseconds for the sensor to respond
    delayMicroseconds(2);

    // Set the trigger pin to high
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, HIGH);

    // Delay for 10 microseconds
    // so that the ultrasonic sensor will send
    // out an ultrasonic burst
    delayMicroseconds(10);

    // Set the trigger pin to low to reset it's state
    digitalWrite(ULTRASONIC_SENSOR_TRIGGER_PIN, LOW);

    // Read the echo pin for the time taken for the ultrasonic
    // burst to return
    int time_taken_in_microseconds = pulseIn(ULTRASONIC_SENSOR_ECHO_PIN, HIGH);

    // Convert the time taken into seconds
    float time_taken_in_seconds = float(time_taken_in_microseconds) / 1000000;

    // Calculate the distance from the time taken
    // using the speed of sound in air, which is 343 m/s
    // or 34300 cm/s.
    // The distance needs to be divided by 2 because
    // the time taken is the time for the sound wave to travel
    // to the object and back to the sensor.
    float distance_in_cm = time_taken_in_seconds * 343 * 1000 / 2;

    // Return the distance in cm from the ultrasonic sensor
    return distance_in_cm;
}

// Function to start sounding the buzzer at a specified frequency in Hz
void start_sounding_buzzer(int frequency_in_hz) {

    // Turn on the buzzer
    buzzer_on = true;

    // Set the beep frequency in Hz
    beep_frequency_in_hz = frequency_in_hz;

    // Set the beep count to 0
    beep_counter = 0;

    // Set the previous beep time to 0
    previous_beep_time = 0;

    // Get the total duration of the tone in milliseconds
    float total_duration_in_milliseconds = 1000.0 / frequency_in_hz;

    // Set the delay between each beep in milliseconds
    beep_delay_in_milliseconds = 0.30 * total_duration_in_milliseconds;

    // Set the duration of the beep in milliseconds
    beep_duration_in_milliseconds = 0.70 * total_duration_in_milliseconds;
}

// Function to sound the buzzer if necessary.
// This function should be called every loop,
// preferably in the main loop function.
void sound_buzzer_if_necessary() {

    // If the buzzer isn't on, exit the function
    if (!buzzer_on) return;

    // If the beep count is past the beep frequency in Hz
    if (beep_counter > beep_frequency_in_hz) {

        // Turn off the buzzer
        buzzer_on = false;

        // Reset the beep counter
        beep_counter = 0;

        // Exit the function
        return;
    };

    // If the current time minus the previous beep time
    // is less than the beep delay, exit the function
    if (millis() - previous_beep_time < beep_delay_in_milliseconds) return;

    // Otherwise, play the beep for the beep duration
    tone(PIEZO_BUZZER_PIN, BEEP_TONE, beep_duration_in_milliseconds);

    // Stop the note from playing
    noTone(PIEZO_BUZZER_PIN);

    // Set the previous beep time to the current time
    previous_beep_time = millis();

    // Increment the beep counter
    beep_counter++;
}

// The main loop function
void loop() {

    // Call the function to sound the buzzer if necessary
    sound_buzzer_if_necessary();

    // If the slotted opto switch is not blocked,
    // which means the slotted opto switch is set to low,
    // exit the function
    if (digitalRead(SLOTTED_OPTO_SWITCH_PIN) == LOW) return;

    // Otherwise, the slotted opto switch is blocked,
    // which means the slotted opto switch is set to low,
    // so calculate the distance in cm
    float distance_in_cm = get_distance_in_cm(USE_ANALOG_DISTANCE_SENSOR);

    // If the distance is more than 40 cm,
    // sound the buzzer at 1 Hz
    if (distance_in_cm > 40) {
        start_sounding_buzzer(1);
    }

    // If the distance is between 20 cm and 40 cm,
    // sound the buzzer at 2 Hz
    else if (distance_in_cm > 20 && distance_in_cm <= 40) {
        start_sounding_buzzer(2);
    }

    // Otherwise, sound the buzzer continuously
    else {
        start_sounding_buzzer(20);
    }
}
