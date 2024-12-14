/*
Exercise 1-3: Light Dimmer
Write a program to perform the following tasks:
    # Use the potentiometer as a rotary light dimmer switch
        - Continuous Mode
            * Light up an array of 3 LEDs with brightness level corresponds
              to the output voltage of the potentiometer,
              i.e. 0V = OFF; 2.5V = 50% brightness & 5V = Max brightness
        - Discrete Mode
            * Divide the output voltage of the potentiometer into
              4 discrete levels
              + Level 1: V_out < 1.25 V -> Turn off all LEDs
              + Level 2: 1.25 V ≤ V_out < 2.5 V -> Turn on 1 LED
              + Level 3: 2.5 V ≤ V_out < 3.75 V -> Turn on 2 LEDs
              + Level 4: V_out ≥ 3.75 V -> Turn on 3 LEDs
*/

// Assuming that circuit 1B is used
// and the LEDs are connected to pins 3, 10, and 11
// and wired normally to the Arduino,
// not reversed wired.

// Define the pins
#define LED_PIN_1 3
#define LED_PIN_2 10
#define LED_PIN_3 11
#define POTENTIOMETER_PIN A0

// The mode enum
enum Mode {
    CONTINUOUS,
    DISCRETE,
};

// The voltage level enum
enum VoltageLevel {
    ONE,
    TWO,
    THREE,
    FOUR,
};

// Initialise the voltage resolution
const float VOLTAGE_RESOLUTION = (5 - 0) / (pow(2, 10) - 1);

// Initialise the mode
const enum Mode MODE = DISCRETE;

// The function to set up the Arduino
void setup() {

    // Declare the potentiometer pin as an input
    pinMode(POTENTIOMETER_PIN, INPUT);

    // Declare all the LED pins as outputs
    pinMode(LED_PIN_1, OUTPUT);
    pinMode(LED_PIN_2, OUTPUT);
    pinMode(LED_PIN_3, OUTPUT);

    // Initialise serial connection
    Serial.begin(9600);

    // Print that the Arduino is ready
    Serial.println("Arduino initialised.");
}

// The function to get the voltage level from the potentiometer value
enum VoltageLevel get_voltage_level(float potentiometer_value) {

    // Multiply the potentiometer value by the voltage resolution
    float potentiometer_voltage = potentiometer_value * VOLTAGE_RESOLUTION;

    // If the potentiometer voltage is less than 1.25 V
    if (potentiometer_voltage < 1.25) {
        return ONE;
    }

    // Otherwise, if the potentiometer voltage is between 1.25 V and 2.5 V
    else if (1.25 <= potentiometer_voltage && potentiometer_voltage < 2.5) {
        return TWO;
    }

    // Otherwise, if the potentiometer voltage is between 2.5 V and 3.75 V
    else if (2.5 <= potentiometer_voltage && potentiometer_voltage < 3.75) {
        return THREE;
    }

    // Otherwise, if the potentiometer voltage is greater than
    // or equal to 3.75 V
    else {
        return FOUR;
    }
}

// The main loop function
void loop() {

    // Read the potentiometer value
    float potentiometer_value = analogRead(POTENTIOMETER_PIN);

    // If the mode is continuous
    if (MODE == CONTINUOUS) {

        // Map the potentiometer value to the LED brightness
        int led_brightness = map(potentiometer_value, 0, 1023, 0, 255);

        // Set the LED brightness on the LED pins
        analogWrite(LED_PIN_1, led_brightness);
        analogWrite(LED_PIN_2, led_brightness);
        analogWrite(LED_PIN_3, led_brightness);

        // Exit the function
        return;
    }

    // Otherwise, if the mode is discrete.
    // Get the voltage level.
    enum VoltageLevel voltage_level = get_voltage_level(potentiometer_value);

    // Switch on the voltage level
    switch (voltage_level) {

        // Turn off all the LEDs at voltage level 1
        // and by default
        default:
        case ONE:
            digitalWrite(LED_PIN_1, LOW);
            digitalWrite(LED_PIN_2, LOW);
            digitalWrite(LED_PIN_3, LOW);
            break;

            // Turn on the first LED at voltage level 2
        case TWO:
            digitalWrite(LED_PIN_1, HIGH);
            digitalWrite(LED_PIN_2, LOW);
            digitalWrite(LED_PIN_3, LOW);
            break;

            // Turn on the first 2 LEDs at voltage level 3
        case THREE:
            digitalWrite(LED_PIN_1, HIGH);
            digitalWrite(LED_PIN_2, HIGH);
            digitalWrite(LED_PIN_3, LOW);
            break;

            // Turn on all the LEDs at voltage level 4
        case FOUR:
            digitalWrite(LED_PIN_1, HIGH);
            digitalWrite(LED_PIN_2, HIGH);
            digitalWrite(LED_PIN_3, HIGH);
            break;
    }
}
