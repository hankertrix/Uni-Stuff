/*
 * Write a program to perform the following tasks:
 * - MCU1:
 *   * Connect a potentiometer to one of the unused Analog Input pin
 *   * Use Serial communication protocol to transmit voltage output of the
 *     potentiometer to MCU2
 * - MCU2:
 *   * Use a voltage divider circuit to input 2.5V into one of the unused
 *     Analog Input pin
 *   * If the voltage value received from MCU1 is 2.5V  0.1, set the on-
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
// that isn't connected to circuit 2B, i.e. MCU1.

// Include the libraries
#include <SoftwareSerial.h>

// Define the pins
#define POTENTIOMETER_PIN A0
#define TX_PIN 8
#define RX_PIN 9

// Define the voltage resolution
#define VOLTAGE_RESOLUTION (5 - 0) / (pow(2, 10) - 1)

// Initialise the character buffer to store the incoming bytes
static String character_buffer = "";

// Initialise the software serial object for
// communication between this Arduino (MCU1) and MCU2.
static SoftwareSerial arduino_serial(RX_PIN, TX_PIN);

// The setup function to setup the Arduino
void setup() {

    // Set up the input pins
    pinMode(POTENTIOMETER_PIN, INPUT);
    pinMode(RX_PIN, INPUT);

    // Set up the output pins
    pinMode(TX_PIN, OUTPUT);

    // Initialise the serial connections
    Serial.begin(9600);
    arduino_serial.begin(9600);
}

// The main loop function
void loop() {

    // Read the value from the potentiometer
    int potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // Convert the potentiometer value to a voltage
    float voltage = potentiometer_value * VOLTAGE_RESOLUTION;

    // Write the voltage to the serial connection
    arduino_serial.println(voltage);

    // If the serial port has data available
    while (arduino_serial.available()) {

        // Read the character
        char character = arduino_serial.read();

        // If the character is valid,
        // push the character to the buffer
        if (character > 0) {
            character_buffer += character;
        }
    }

    // Get the length of the character buffer
    int length = character_buffer.length();

    // Get the last character in the buffer
    char last_character = character_buffer.charAt(length - 1);

    // If the last character is not a new line character,
    // exit the function
    if (last_character != '\n') return;

    // Otherwise, print the buffer
    Serial.print(character_buffer);

    // Clear the buffer
    character_buffer = "";
}
