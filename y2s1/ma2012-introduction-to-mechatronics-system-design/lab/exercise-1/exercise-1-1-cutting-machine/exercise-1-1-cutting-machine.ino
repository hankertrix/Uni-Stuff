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

// Initialise the delay between each beep
#define BEEP_DELAY_IN_MILLISECONDS 100

// Initialise the variables needed
bool alarm_on = false;
unsigned int alarm_counter = 0;
unsigned long alarm_previous_time = 0;

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

// Function to start sounding the piezo buzzer
void start_alarm() {

    // Set the alarm on to true
    alarm_on = true;

    // Set the alarm counter to 0
    alarm_counter = 0;

    // Set the previous alarm time to 0
    alarm_previous_time = 0;
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

            // Call the function to start
            // sounding the piezo buzzer
            start_alarm();

            // Exit the function
            return;
        }

        // Otherwise, the safety door is closed,
        // which means the limit switch is set to high,
        // so actuate the solenoid
        digitalWrite(SOLENOID_PIN, HIGH);

        // Wait for 2 microseconds
        // for the solenoid to respond
        delayMicroseconds(2);

        // Deactivate the solenoid
        digitalWrite(SOLENOID_PIN, LOW);
    }
}

// The function to sound the piezo buzzer.
// This function must be called every loop,
// preferably in the main loop function.
void sound_alarm_if_necessary() {

    // If the alarm isn't on, exit the function
    if (!alarm_on) return;

    // If the alarm counter is past 3
    if (alarm_counter > 3) {

        // Turn off the alarm
        alarm_on = false;

        // Reset the alarm counter
        alarm_counter = 0;

        // Exit the function
        return;
    }

    // If the current time minus the previous alarm time
    // is less than the beep delay, exit the function
    if (millis() - alarm_previous_time < BEEP_DELAY_IN_MILLISECONDS) return;

    // Otherwise, play the alarm note for 500 milliseconds
    tone(PIEZO_BUZZER_PIN, ALARM_TONE, 500);

    // Stop the note from playing
    noTone(PIEZO_BUZZER_PIN);

    // Set the previous alarm time to the current time
    alarm_previous_time = millis();

    // Increment the alarm counter
    alarm_counter++;
}

// The main loop function
void loop() {

    // Call the function to sound the alarm if necessary
    sound_alarm_if_necessary();

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
