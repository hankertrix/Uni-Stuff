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
// with the buzzer connected to pin 12

// Define the pin numbers
#define SLOTTED_OPTO_SWITCH_PIN 5
#define ULTRASONIC_SENSOR_ECHO_PIN 8
#define ULTRASONIC_SENSOR_TRIGGER_PIN 9
#define ANALOG_DISTANCE_SENSOR_PIN A5
#define PIEZO_BUZZER_PIN 12

// The frequency of the tone to play,
// which is an E5
#define BEEP_TONE 659

// The boolean to determine whether to use the analog distance sensor
#define USE_ANALOG_DISTANCE_SENSOR false

// Initialise the voltage resolution
const float VOLTAGE_RESOLUTION = (5 - 0) / (pow(2, 10) - 1);

// The setup function to set up the program
void setup() {

    // Set the pin modes of all the input pins
    pinMode(ULTRASONIC_SENSOR_ECHO_PIN, INPUT);
    pinMode(ANALOG_DISTANCE_SENSOR_PIN, INPUT);
    pinMode(SLOTTED_OPTO_SWITCH_PIN, INPUT);

    // Set the pin mode of all the output pins
    pinMode(ULTRASONIC_SENSOR_TRIGGER_PIN, OUTPUT);
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

        // Get the analog value from the analog distance sensor
        int analog_value = analogRead(ANALOG_DISTANCE_SENSOR_PIN);

        // Convert the analog value into a voltage value
        float voltage_value = analog_value * VOLTAGE_RESOLUTION;

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

    // Calculate the distance from the time taken
    // using the speed of sound in air, which is 343 m/s
    // or 34300 cm/s.
    // The speed of sound of 34300 cm/s needs to be divided
    // by 1,000,000 to convert it to cm/us or cm per microsecond,
    // which is 0.0343 cm/us.
    // The distance needs to be divided by 2 because
    // the time taken is the time for the sound wave to travel
    // to the object and back to the sensor.
    float distance_in_cm = time_taken_in_microseconds * 0.0343 / 2;

    // Return the distance in cm from the ultrasonic sensor
    return distance_in_cm;
}

// Function to sound the buzzer at a specified frequency in Hz
void sound_buzzer(int frequency_in_hz) {

    // Stop the buzzer
    noTone(PIEZO_BUZZER_PIN);

    // Get the total duration of the tone in milliseconds
    float total_duration_in_milliseconds = 1000.0 / frequency_in_hz;

    // Get the delay between each beep in milliseconds
    float delay_in_milliseconds = 0.30 * total_duration_in_milliseconds;

    // Get the duration of the beep in milliseconds
    float beep_duration_in_milliseconds = 0.70 * total_duration_in_milliseconds;

    // Iterate over the frequency in Hz
    for (int i = 0; i < frequency_in_hz; ++i) {

        // Sound the buzzer for the duration of the beep
        tone(PIEZO_BUZZER_PIN, BEEP_TONE, beep_duration_in_milliseconds);

        // Wait for the duration of the beep
        delay(beep_duration_in_milliseconds);

        // Stop the note from playing
        noTone(PIEZO_BUZZER_PIN);

        // Wait for the delay between each beep
        delay(delay_in_milliseconds);
    }
}

// Function to sound the buzzer continuously
void sound_buzzer_continuously() {

    // Sound the buzzer continuously
    tone(PIEZO_BUZZER_PIN, BEEP_TONE);
}

// The main loop function
void loop() {

    // If the slotted opto switch is not blocked,
    // which means the slotted opto switch is set to low,
    // exit the function
    if (digitalRead(SLOTTED_OPTO_SWITCH_PIN) == LOW) {
        return;
    }

    // Otherwise, the slotted opto switch is blocked,
    // which means the slotted opto switch is set to low,
    // so calculate the distance in cm
    float distance_in_cm = get_distance_in_cm(USE_ANALOG_DISTANCE_SENSOR);

    // If the distance is more than 40 cm,
    // sound the buzzer at 1 Hz
    if (distance_in_cm > 40) {
        sound_buzzer(1);
    }

    // If the distance is between 20 cm and 40 cm,
    // sound the buzzer at 2 Hz
    else if (distance_in_cm > 20 && distance_in_cm <= 40) {
        sound_buzzer(2);
    }

    // Otherwise, sound the buzzer continuously
    else {
        sound_buzzer_continuously();
    }
}
