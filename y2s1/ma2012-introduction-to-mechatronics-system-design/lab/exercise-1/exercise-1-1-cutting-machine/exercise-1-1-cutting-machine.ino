/*
Exercise 1-1: Cutting Machine
Write a program to perform the following tasks:
   - The toggle switch is the ON/OFF master switch of a cutting
     machine.
        * When the master switch is ON/OFF, on-board LED (Pin 13) is ON/OFF
        * Nothing will happen if the master switch is OFF
   - The limit switch is a safety door sensor
        * Depressed = door closed; Opened = door opened
   - When the safety door is closed and the push button is depressed
     once, the cutter (Solenoid) will go through 10 cycles of actuation
     and de-actuation.
   - If the safety door is opened when the cutter is in action, the piezo
     buzzer will sound off thrice and the cutter is de-actuated
     immediately.
*/


// Assuming circuit 1A is used

// Set the pins for the switches and buttons
#define PUSH_BUTTON_PIN 2
#define TOGGLE_SWITCH_PIN 3
#define LIMIT_SWITCH_PIN 4
#define PIEZO_BUZZER_PIN 8
#define SOLENOID_PIN 10
#define LED_PIN 13

// The frequency of the tone to play,
// which is an E5
#define ALARM_TONE 659

// The duration of the note to play
#define ALARM_DURATION 500

// The setup function to set up all the pins
void setup() {

    // Set the pin mode for all the switches to input mode
    pinMode(PUSH_BUTTON_PIN, INPUT);
    pinMode(TOGGLE_SWITCH_PIN, INPUT);
    pinMode(LIMIT_SWITCH_PIN, INPUT);

    // Set the pin mode for all the components to output mode
    pinMode(PIEZO_BUZZER_PIN, OUTPUT);
    pinMode(SOLENOID_PIN, OUTPUT);
    pinMode(LED_PIN, OUTPUT);

    // Initialise serial connection
    Serial.begin(9600);

    // Print that the Arduino is ready
    Serial.println("Arduino initialised.");
}

// Function to sound the piezo buzzer 3 times
void alarm() {

    // Iterate 3 times
    for (int i = 0; i < 3; ++i) {

        // Play the note for the alarm duration
        tone(PIEZO_BUZZER_PIN, ALARM_TONE, ALARM_DURATION);

        // Wait for the alarm duration
        delay(ALARM_DURATION);

        // Stop the note from playing
        noTone(PIEZO_BUZZER_PIN);

        // Wait for 200 milliseconds
        delay(200);
    }
}

// The function to cut the material using the solenoid
void cut() {

    // Iterate 10 times
    for (int i = 0; i < 10; ++i) {

        // If the safety door is open,
        // which means the limit switch is open,
        // or set to low
        if (digitalRead(LIMIT_SWITCH_PIN) == LOW) {

            // Deactivate the solenoid
            digitalWrite(SOLENOID_PIN, LOW);

            // Call the function to sound the piezo buzzer
            alarm();

            // Exit the function
            return;
        }

        // Otherwise, the safety door is closed,
        // which means the limit switch is set to high,
        // so actuate the solenoid
        digitalWrite(SOLENOID_PIN, HIGH);

        // Wait for 100 milliseconds for the solenoid to actuate
        delay(100);

        // Deactivate the solenoid
        digitalWrite(SOLENOID_PIN, LOW);

        // Wait for 100 milliseconds for the solenoid to de-actuate
        delay(100);
    }
}

// The main loop function
void loop() {

    // When the toggle switch is set to low, which is off
    if (digitalRead(TOGGLE_SWITCH_PIN) == LOW) {

        // Turn off the LED and exit the function
        return digitalWrite(LED_PIN, LOW);
    }

    // Otherwise the toggle switch is set to high, which is on
    // so turn on the LED
    digitalWrite(LED_PIN, HIGH);

    // If the limit switch is set to high,
    // which means the limit switch is depressed
    // and the safety door is closed
    if (digitalRead(LIMIT_SWITCH_PIN) == HIGH) {

        // If the push button is set to low,
        // which means it is depressed once
        if (digitalRead(PUSH_BUTTON_PIN) == LOW) {

            // Call the function to cut the material
            cut();
        }
    }
}
