// This is the code for MCU 2 for CA1.
//
// This MCU doesn't do anything other
// than receiving the data from MCU 1
// and printing it out to the LCD.

// Assuming the circuit is connected as
// shown in Figure 2

// Include the libraries
#include <LiquidCrystal.h>
#include <SoftwareSerial.h>

// Define the pins
#define LCD_REGISTER_SELECT_PIN 6
#define LCD_ENABLE_PIN 7
#define LCD_DATA_PIN_4 5
#define LCD_DATA_PIN_5 4
#define LCD_DATA_PIN_6 3
#define LCD_DATA_PIN_7 2
#define RX_PIN 8
#define TX_PIN 9

// The character buffer object
struct CharacterBuffer {
    String buffer;
    bool is_complete;
};

// Define the constants

// The line separator when printing to the LCD screen.
// This character is used to separate between the
// first line of the LCD and the second line of the
// LCD, so it should be the same on both MCU 1 and MCU 2
const char* LINE_SEPARATOR = "|";

// The LCD width
const unsigned int LCD_WIDTH = 16;

// Initialise the LCD object
static LiquidCrystal LCD(
    LCD_REGISTER_SELECT_PIN,
    LCD_ENABLE_PIN,
    LCD_DATA_PIN_4,
    LCD_DATA_PIN_5,
    LCD_DATA_PIN_6,
    LCD_DATA_PIN_7
);

// Initialise the character buffer to store the string
static CharacterBuffer CHARACTER_BUFFER = {
    .buffer = String(""),
    .is_complete = false,
};

// Initialise the serial connection between the Arduinos
SoftwareSerial ARDUINO_SERIAL(RX_PIN, TX_PIN);

// The setup function to setup the Arduino
void setup() {

    // Set up the input pins
    pinMode(RX_PIN, INPUT);

    // Set up the output pins
    pinMode(TX_PIN, OUTPUT);

    // Initialise the serial connection
    Serial.begin(9600);

    // Initialise the serial connection between the Arduinos
    ARDUINO_SERIAL.begin(9600);

    // Set up the LCD's number of columns and rows
    LCD.begin(LCD_WIDTH, 2);

    // Set the cursor to the first line
    LCD.setCursor(0, 0);

    // Print the welcome message to the LCD
    LCD.print(" Arduino Ready! ");
}

// Pad the string with spaces at the front of the string
String pad_string_left(String string, unsigned int number_of_spaces) {

    // Iterate over the number of spaces needed
    for (unsigned int i = 0; i < number_of_spaces; ++i) {

        // Add a space to the string at the front
        string = " " + string;
    }

    // Return the padded string
    return string;
}

// Pad the string with spaces at the back of the string
String pad_string_right(String string, unsigned int number_of_spaces) {

    // Iterate over the number of spaces needed
    for (unsigned int i = 0; i < number_of_spaces; ++i) {

        // Add a space to the string at the back
        string += " ";
    }

    // Return the padded string
    return string;
}

// The function to centre a string
String centre_string(String string, unsigned int target_width) {

    // Get the length of the string
    unsigned int string_length = string.length();

    // Get the number of spaces between the width and the string
    int number_of_spaces = target_width - string_length;

    // Get the number of spaces to pad on the left
    int number_of_spaces_to_pad_on_left = number_of_spaces / 2;

    // Initialise the number of spaces to pad on the right
    int number_of_spaces_to_pad_on_right = number_of_spaces_to_pad_on_left;

    // If the number of spaces is not even
    if (number_of_spaces % 2 != 0) {

        // Increment the number of spaces to pad on the right by 1
        number_of_spaces_to_pad_on_right += 1;
    }

    // Pad the string on the left
    string = pad_string_left(string, number_of_spaces_to_pad_on_left);

    // Pad the string on the right
    string = pad_string_right(string, number_of_spaces_to_pad_on_right);

    // Return the centred string
    return string;
}

// The function to print a string to the LCD screen
void print_to_lcd(String buffer, const char* line_separator) {

    // Get the length of the buffer
    unsigned int buffer_length = buffer.length();

    // Create a character array to store the buffer
    char buffer_array[buffer_length + 1];

    // Copy the buffer to the character array
    buffer.toCharArray(buffer_array, buffer_length + 1);

    // Initialise the array to store the tokens
    String token_array[2] = {String(""), String("")};

    // Initialise the index of the token array to 0
    int token_array_index = 0;

    // Split the character array at the line separator
    char *token = strtok(buffer_array, line_separator);

    // While the token is not NULL
    while (token != NULL) {

        // Add the token to the token array
        token_array[token_array_index] = token;

        // Increment the index of the token array
        token_array_index++;

        // If the index of the token array is 2 or more,
        // break out of the loop
        if (token_array_index >= 2) break;

        // Get the next token
        token = strtok(NULL, line_separator);
    }

    // Pull out the first two tokens of the token array
    String first_token = token_array[0];
    String second_token = token_array[1];

    // Centre both tokens
    String centred_first_token = centre_string(first_token, LCD_WIDTH);
    String centred_second_token = centre_string(second_token, LCD_WIDTH);

    // Set the cursor to the first line
    LCD.setCursor(0, 0);

    // Print the first token to the LCD
    LCD.print(centred_first_token);

    // Set the cursor to the second line
    LCD.setCursor(0, 1);

    // Print the second token to the LCD
    LCD.print(centred_second_token);
}

// The main loop function
void loop() {

    // If there is data available to read
    if (ARDUINO_SERIAL.available() > 0) {

        // Get the character read from the serial connection
        char character = ARDUINO_SERIAL.read();

        // Add the character to the buffer
        CHARACTER_BUFFER.buffer += String(character);

        // If the character is the new line character
        // then set the buffer as completed
        if (character == '\n') {
            CHARACTER_BUFFER.is_complete = true;
        }
    }

    // If the buffer is complete
    if (CHARACTER_BUFFER.is_complete) {

        // Trim the buffer
        CHARACTER_BUFFER.buffer.trim();

        // Print the buffer to the LCD screen
        print_to_lcd(CHARACTER_BUFFER.buffer, LINE_SEPARATOR);

        // Clear the buffer
        CHARACTER_BUFFER.buffer = String("");

        // Set the buffer as not complete
        CHARACTER_BUFFER.is_complete = false;
    }
}
