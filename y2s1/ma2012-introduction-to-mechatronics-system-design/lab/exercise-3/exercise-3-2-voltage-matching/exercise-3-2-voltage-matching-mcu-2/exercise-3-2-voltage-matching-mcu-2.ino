/*
 * Write a program to perform the following tasks:
 * - MCU1:
 *   * Connect a potentiometer to one of the unused Analog Input pin
 *   * Use Serial communication protocol to transmit voltage output of the
 *     potentiometer to MCU2
 * - MCU2:
 *   * Use a voltage divider circuit to input 2.5V into one of the unused
 *     Analog Input pin
 *   * If the voltage value received from MCU1 is 2.5V +- 0.1, set the on-
 *     board LED to blink
 *   * Use Serial communication protocol to transmit 5 characters to MCU1:
 *     "B", "I", "N", "G", "O"
 * - MCU1:
 *   * Use Serial monitor to display the word "BINGO"
*/

// The Arduino connected to circuit 2B is MCU2 in the exercise.
// Assuming that circuit 2B is used, the Arduino
// connected to circuit 2B is MCU2 in this exercise.
// The potential divider circuit output connected to
// analog input pin A0 on the Arduino in circuit 2B.
// The potentiometer is connected to analog input pin A0
// on the other Arduino that isn't in circuit 2B,
// which is MCU1.
// The two Arduinos are connected together with
// pin 8 to pin 8 and pin 9 to pin 9.

// The following code is for the main Arduino
// that is connected to circuit 2B, i.e. MCU2.

// Include the libraries
#include <SoftwareSerial.h>

// Define the pins
#define POTENTIAL_DIVIDER_OUTPUT_PIN A0
#define TX_PIN 9
#define RX_PIN 8
#define LED_PIN 13

// Define the voltage resolution
#define VOLTAGE_RESOLUTION (5 - 0) / (pow(2, 10) - 1)

// Initialise the duration between blinks in milliseconds
const int blink_duration_ms = 200;

// Initialise the previous blink time in milliseconds
static unsigned long previous_blink_time = 0;

// Initialise the LED state
static int led_state = HIGH;

// Initialise the character buffer to store the incoming bytes
static String character_buffer = "";

// Initialise the software serial object for
// communication between this Arduino (MCU2) and MCU1
static SoftwareSerial arduino_serial(RX_PIN, TX_PIN);

// The setup function to setup the Arduino
void setup() {

    // Set up the input pins
    pinMode(POTENTIAL_DIVIDER_OUTPUT_PIN, INPUT);
    pinMode(RX_PIN, INPUT);

    // Set up the output pins
    pinMode(LED_PIN, OUTPUT);
    pinMode(TX_PIN, OUTPUT);

    // Initialise the serial connections
    Serial.begin(9600);
    arduino_serial.begin(9600);
}

// The function to blink the on-board LED
void blink_led() {

    // Get the current time
    unsigned long current_time = millis();

    // If the current number of milliseconds minus
    // the previous blink time is less than
    // the duration between blinks, exit the function
    if (current_time - previous_blink_time < blink_duration_ms) {
        return;
    }

    // Otherwise, blink the on-board LED

    // If the LED state is HIGH, set the LED state to LOW
    if (led_state == HIGH) led_state = LOW;

    // Otherwise, set the LED state to HIGH
    else led_state = HIGH;

    // Write the LED state to the on-board LED
    digitalWrite(LED_PIN, led_state);

    // Set the previous blink time to the current number of milliseconds
    previous_blink_time = millis();
}

// The main loop function
void loop() {

    // Read the value from the potential divider
    int potential_divider_value = analogRead(POTENTIAL_DIVIDER_OUTPUT_PIN);

    // Convert the potential divider value to a voltage
    float potential_divider_voltage =
        potential_divider_value * VOLTAGE_RESOLUTION;

    // While the Arduino serial has data available
    while (arduino_serial.available()) {

        // Read the character
        char character = arduino_serial.read();

        // If the character is valid,
        // push the character to the character buffer
        if (character > 0) {
            character_buffer += character;
        }
    }

    // Get the length of the character buffer
    int length = character_buffer.length();

    // Get the last character in the character buffer
    char last_character = character_buffer.charAt(length - 1);

    // If the last character is not a new line character,
    // exit the function
    if (last_character != '\n') return;

    // Initialise the string to store the buffer
    char voltage_string[length + 1];

    // Copy the character buffer to the voltage string
    character_buffer.toCharArray(voltage_string, length + 1);

    // Otherwise, convert the character buffer to a float
    float given_voltage = atof(voltage_string);

    // Clear the character buffer
    character_buffer = "";

    // If the voltage value is the potential divider voltage +- 0.1V
    if (
        given_voltage >= potential_divider_voltage - 0.1 &&
        given_voltage <= potential_divider_voltage + 0.1
    ) {

        // Blink the on-board LED
        blink_led();

        // Send the word BINGO to the other Arduino
        arduino_serial.write("BINGO\n");
    }
}
