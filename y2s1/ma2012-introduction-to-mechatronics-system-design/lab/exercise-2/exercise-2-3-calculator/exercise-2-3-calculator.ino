/*
 * Write a program to perform the following tasks:
 * - Pressing 2 consecutive keys of "F" turns the keypad into a calculator:
 *   * "A" is + (add), "B" is - (subtract), "C" is * (multiply),
 *     "D" is / (divide), "E" is = (equals)
 *   * The calculator should perform 3-digit (0-999) integer arithmetic,
 *     i.e. no decimal digits, e.g. 1.5 -> 1.0
 *   * The LCD should display digits and/or symbols consistent with a normal
 *     calculator. You may apply appropriate assumptions.
 * - Pressing keystrokes of "F" + "E" turns off the calculator function
 *   and return to displaying entered keys.
 */

// Assuming circuit 2B is used.

// Include the libraries
#include <LiquidCrystal.h>

// Define the pins
#define DATA_AVAILABLE_PIN A5
#define KEYPAD_OUTPUT_A 10
#define KEYPAD_OUTPUT_B 11
#define KEYPAD_OUTPUT_C 12
#define KEYPAD_OUTPUT_D 13
#define LCD_REGISTER_SELECT_PIN 6
#define LCD_ENABLE_PIN 7
#define LCD_DATA_PIN_4 5
#define LCD_DATA_PIN_5 4
#define LCD_DATA_PIN_6 3
#define LCD_DATA_PIN_7 2

// The buffer size of the keypad input
#define KEYPAD_BUFFER_SIZE 16

// Declare the keypad layout
const char KEYPAD_LAYOUT[] = {
    '1', '2', '3', 'F',
    '4', '5', '6', 'E',
    '7', '8', '9', 'D',
    'A', '0', 'B', 'C',
};

// The type definition for a mathematical operator function
typedef int (*math_operator)(int, int);

// The enum to represent the mode of the Arduino
enum Mode {
    DISPLAY_MODE,
    CALCULATOR_MODE,
};

// The struct to store the keypad input
struct KeypadInputBuffer {

    // The buffer to store the keypad input
    // The + 1 is to make room for the null terminator
    char buffer[KEYPAD_BUFFER_SIZE + 1];

    // The boolean to indicate whether the buffer is complete
    bool is_complete;

    // The boolean to indicate whether the buffer is cleared
    bool is_cleared;

    // The boolean to indicate whether the calculator result has been printed
    bool has_printed_result;
};

// The buffer to store the keypad input
static KeypadInputBuffer KEYPAD_INPUT_BUFFER = {
    .buffer = {'\0'},
    .is_complete = false,
    .is_cleared = false,
    .has_printed_result = false,
};

// The mode of the Arduino
static Mode ARDUINO_MODE = DISPLAY_MODE;

// The LCD object
static LiquidCrystal LCD(
    LCD_REGISTER_SELECT_PIN,
    LCD_ENABLE_PIN,
    LCD_DATA_PIN_4,
    LCD_DATA_PIN_5,
    LCD_DATA_PIN_6,
    LCD_DATA_PIN_7
);

// The class for an integer stack
class IntegerStack {

    // Private variables
    private:
        int stack_array[KEYPAD_BUFFER_SIZE + 1];
        int top_ptr;

    // Public functions
    public:

        // The function to initialise the stack
        void initialise() {

            // Set the pointer to the top of the stack
            // to -1 to indicate that the stack is empty
            top_ptr = -1;
        }

        // The function to check if the stack is empty
        // by returning if the pointer to the top of the
        // stack is -1
        bool is_empty() {
            return top_ptr == -1;
        }

        // The function to check if the stack is full
        bool is_full() {
            return top_ptr == sizeof(stack_array);
        }

        // The function to get the size of the stack,
        // which is the number of elements in the stack,
        // which is just the pointer to the top of the stack
        // plus 1
        size_t get_size() {
            return top_ptr + 1;
        }

        // The function to push an integer onto the stack.
        // This function returns true if item was pushed
        // to the stack successfully and false otherwise.
        bool push(int value) {

            // If the stack is full, return false
            if (is_full()) return false;

            // Otherwise, increment the top pointer
            top_ptr++;

            // Push the value onto the stack
            stack_array[top_ptr] = value;

            // Return true
            return true;
        }

        // The function to pop an integer from the stack.
        // This function returns the minimum value of the integer type
        // if the stack is empty.
        int pop() {

            // If the stack is empty,
            // return the minimum value of the integer type
            if (is_empty()) return INT16_MIN;

            // Otherwise, get the item at the top of the stack
            int item = stack_array[top_ptr];

            // Decrement the top pointer
            top_ptr--;

            // Return the item
            return item;
        }

        // The function to peek at the top item on the stack.
        // This function return the minimum value of the integer type
        // if the stack is empty.
        int peek() {

            // If the stack is empty,
            // return the minimum value of the integer type
            if (is_empty()) return INT16_MIN;

            // Otherwise, return the item at the top of the stack
            return stack_array[top_ptr];
        }

        // The function to get an item at a given index on the stack.
        // This function returns the minimum value of the integer type
        // if the index is out of bounds.
        int get(int index) {

            // If the index is more than the pointer to the top
            // of the stack, return the minimum value of the integer type
            if (index > top_ptr) return INT16_MIN;

            // If the index is negative,
            // return the minimum value of the integer type
            if (index < 0) return INT16_MIN;

            // Otherwise, return the item at the given index
            return stack_array[index];
        }
};

// The class for a character stack
class CharacterStack {

    // Private variables
    private:
        char stack_array[KEYPAD_BUFFER_SIZE + 1];
        int top_ptr;

    // Public functions
    public:

        // The function to initialise the stack
        void initialise() {

            // Set the pointer to the top of the stack
            // to -1 to indicate that the stack is empty
            top_ptr = -1;
        }

        // The function to check if the stack is empty
        // by returning if the pointer to the top of the
        // stack is -1
        bool is_empty() {
            return top_ptr == -1;
        }

        // The function to check if the stack is full
        bool is_full() {
            return top_ptr == sizeof(stack_array);
        }

        // The function to get the size of the stack,
        // which is the number of elements in the stack,
        // which is just the pointer to the top of the stack
        // plus 1
        size_t get_size() {
            return top_ptr + 1;
        }

        // The function to push an integer onto the stack.
        // This function returns true if item was pushed
        // to the stack successfully and false otherwise.
        char push(char value) {

            // If the stack is full, return false
            if (is_full()) return false;

            // Otherwise, increment the top pointer
            top_ptr++;

            // Push the value onto the stack
            stack_array[top_ptr] = value;

            // Return true
            return true;
        }

        // The function to pop an integer from the stack.
        // This function returns a null byte if the stack is empty.
        char pop() {

            // If the stack is empty, return a null byte
            if (is_empty()) return '\0';

            // Otherwise, get the item at the top of the stack
            int item = stack_array[top_ptr];

            // Decrement the top pointer
            top_ptr--;

            // Return the item
            return item;
        }

        // The function to peek at the top item on the stack.
        // This function returns null if the stack is empty.
        char peek() {

            // If the stack is empty, return a null byte
            if (is_empty()) return '\0';

            // Otherwise, return the item at the top of the stack
            return stack_array[top_ptr];
        }

        // The function to get an item at a given index on the stack.
        // This function returns null if the index is out of bounds.
        char get(int index) {

            // If the index is more than the pointer to the top
            // of the stack, return a null byte
            if (index > top_ptr) return '\0';

            // If the index is negative, return a null byte
            if (index < 0) return '\0';

            // Otherwise, return the item at the given index
            return stack_array[index];
        }
};

// The class for a string stack
class StringStack {

    // Private variables
    private:
        String stack_array[KEYPAD_BUFFER_SIZE + 1];
        int top_ptr;

    // Public functions
    public:

        // The function to initialise the stack
        void initialise() {

            // Set the pointer to the top of the stack
            // to -1 to indicate that the stack is empty
            top_ptr = -1;
        }

        // The function to check if the stack is empty
        // by returning if the pointer to the top of the
        // stack is -1
        bool is_empty() {
            return top_ptr == -1;
        }

        // The function to check if the stack is full
        bool is_full() {
            return top_ptr == sizeof(stack_array);
        }

        // The function to get the size of the stack,
        // which is the number of elements in the stack,
        // which is just the pointer to the top of the stack
        // plus 1
        size_t get_size() {
            return top_ptr + 1;
        }

        // The function to push an integer onto the stack.
        // This function returns true if item was pushed
        // to the stack successfully and false otherwise.
        bool push(String value) {

            // If the stack is full, return false
            if (is_full()) return false;

            // Otherwise, increment the top pointer
            top_ptr++;

            // Push the value onto the stack
            stack_array[top_ptr] = value;

            // Return true
            return true;
        }

        // The function to pop an integer from the stack.
        // This function returns null if the stack is empty.
        String pop() {

            // If the stack is empty, return an empty string
            if (is_empty()) return String("");

            // Otherwise, get the item at the top of the stack
            String item = stack_array[top_ptr];

            // Decrement the top pointer
            top_ptr--;

            // Return the item
            return item;
        }

        // The function to peek at the top item on the stack.
        // This function returns null if the stack is empty.
        String peek() {

            // If the stack is empty, return an empty string
            if (is_empty()) return String("");

            // Otherwise, return the item at the top of the stack
            return stack_array[top_ptr];
        }

        // The function to get an item at a given index on the stack.
        // This function returns null if the index is out of bounds.
        String get(int index) {

            // If the index is more than the pointer to the top
            // of the stack, return an empty string
            if (index > top_ptr) return String("");

            // If the index is negative, return an empty string
            if (index < 0) return String("");

            // Otherwise, return the item at the given index
            return stack_array[index];
        }
};

// Function to convert a string containing just one character
// to a single character
char convert_string_to_char(char* string) {

    // Get the length of the string
    size_t length = strlen(string);

    // If the length is not 1,
    // then return a null byte
    if (length != 1) {
        return '\0';
    }

    // Otherwise, return the character
    return string[0];
}

// The function to clear a string buffer
void clear_string_buffer(char* buffer, size_t buffer_size) {

    // Set the buffer to all spaces
    memset(buffer, ' ', buffer_size);

    // Set the last character to the null terminator
    buffer[buffer_size - 1] = '\0';
}

// The function to clear the keypad input buffer
void clear_keypad_input_buffer() {

    // Clear the buffer
    clear_string_buffer(
        KEYPAD_INPUT_BUFFER.buffer,
        sizeof(KEYPAD_INPUT_BUFFER.buffer)
    );

    // Set the buffer as cleared
    KEYPAD_INPUT_BUFFER.is_cleared = true;
}

// The function to push a character to a string buffer.
// This function modifies the buffer in place.
void push_char_to_buffer(char character, char* buffer, size_t buffer_size) {

    // Iterate over the buffer
    for (int i = 0; i < (int) buffer_size - 2; ++i) {

        // Set the next character to the current character
        buffer[i] = buffer[i + 1];
    }

    // Set the second last character to the new character
    buffer[buffer_size - 2] = character;

    // Set the last character to the null terminator
    buffer[buffer_size - 1] = '\0';
}

// The function to receive the keypad input
void receive_keypad_input() {

    // Read the values of all the keypad encoder output pins
    int keypad_output_a = digitalRead(KEYPAD_OUTPUT_A);
    int keypad_output_b = digitalRead(KEYPAD_OUTPUT_B);
    int keypad_output_c = digitalRead(KEYPAD_OUTPUT_C);
    int keypad_output_d = digitalRead(KEYPAD_OUTPUT_D);

    // Combine the outputs together to create a single value
    int keypad_output = keypad_output_a + keypad_output_b * 2 +
                        keypad_output_c * 4 + keypad_output_d * 8;

    // Get the key that was pressed
    char pressed_key = KEYPAD_LAYOUT[keypad_output];

    // Get the size of the buffer
    size_t buffer_size = sizeof(KEYPAD_INPUT_BUFFER.buffer);

    // Get the previous character of the buffer
    char previous_char = KEYPAD_INPUT_BUFFER.buffer[buffer_size - 2];

    // If the current mode is display mode
    if (ARDUINO_MODE == DISPLAY_MODE) {

        // If previous character is "F" and the pressed key is "F"
        // which means the calculator is to be turned on
        if (previous_char == 'F' && pressed_key == 'F') {

            // Set the mode to calculator mode
            ARDUINO_MODE = CALCULATOR_MODE;

            // Clear the keypad input buffer
            clear_keypad_input_buffer();

            // Set the buffer as incomplete
            KEYPAD_INPUT_BUFFER.is_complete = false;

            // Set that the result has been printed to false
            KEYPAD_INPUT_BUFFER.has_printed_result = false;

            // Exit the function
            return;
        }

        // Otherwise, if the buffer is cleared,
        // set it to not cleared
        if (KEYPAD_INPUT_BUFFER.is_cleared) {
            KEYPAD_INPUT_BUFFER.is_cleared = false;
        }

        // Push the pressed key to the buffer
        push_char_to_buffer(
            pressed_key,
            KEYPAD_INPUT_BUFFER.buffer,
            buffer_size
        );

        // Set the buffer as complete
        KEYPAD_INPUT_BUFFER.is_complete = true;

        // Exit the function
        return;
    }

    // Otherwise, if the current mode is calculator mode,
    // so check if the previous character is "F"
    // and the pressed key is "E",
    // which means the calculator is to be turned off
    if (previous_char == 'F' && pressed_key == 'E') {

        // Set the mode to display mode
        ARDUINO_MODE = DISPLAY_MODE;

        // Clear the keypad input buffer
        clear_keypad_input_buffer();

        // Set the buffer as complete
        KEYPAD_INPUT_BUFFER.is_complete = true;

        // Set that the result has been printed to false
        KEYPAD_INPUT_BUFFER.has_printed_result = false;

        // Exit the function
        return;
    }

    // Otherwise, if the pressed key is an "E",
    // which means the equal sign has been pressed in calculator mode
    if (pressed_key == 'E') {

        // Set the buffer as complete
        KEYPAD_INPUT_BUFFER.is_complete = true;

        // Exit the function
        return;
    }

    // Otherwise, if the buffer is cleared,
    // set it to not cleared
    if (KEYPAD_INPUT_BUFFER.is_cleared) {
        KEYPAD_INPUT_BUFFER.is_cleared = false;
    }

    // Push the pressed key to the buffer
    push_char_to_buffer(
        pressed_key,
        KEYPAD_INPUT_BUFFER.buffer,
        buffer_size
    );
}

// The add function
int add(int a, int b) {
    return a + b;
}

// The subtract function
int subtract(int a, int b) {
    return a - b;
}

// The multiply function
int multiply(int a, int b) {
    return a * b;
}

// The divide function
int divide(int a, int b) {

    // If the divisor is zero, return zero
    if (b == 0) {
        return 0;
    }

    // Otherwise, return the result
    return a / b;
}

// The function to match the character to the mathematical operators
math_operator match_character_to_operator(char character) {
    switch (character) {
        case 'A':
            return &add;
        case 'B':
            return &subtract;
        case 'C':
            return &multiply;
        case 'D':
            return &divide;
        default:
            return NULL;
    }
}

// The function to match the key to the mathematical symbols
char match_character_to_math_symbol(char character) {
    switch (character) {
        case 'A':
            return '+';
        case 'B':
            return '-';
        case 'C':
            return '*';
        case 'D':
            return '/';
        default:
            return character;
    }
}

// The function to get the operator precedence.
int get_operator_precedence(char character) {
    switch (character) {
        case 'A':
            return 1;
        case 'B':
            return 1;
        case 'C':
            return 2;
        case 'D':
            return 2;
        default:
            return 0;
    }
}

// The function to print an empty line using the LCD
void lcd_print_empty_line() {

    // Initialise an empty line
    char empty_line[KEYPAD_BUFFER_SIZE + 1];

    // Clear the empty line
    clear_string_buffer(empty_line, KEYPAD_BUFFER_SIZE + 1);

    // Print the empty line using the LCD
    LCD.print(empty_line);
}

// The function to print in calculator mode using the LCD
void lcd_print_in_calculator_mode(char* buffer, size_t buffer_length) {

    // Initialise a character array
    // with the same size as the buffer
    char string_to_print[buffer_length + 1];

    // Iterate over the buffer
    for (int i = 0; i < (int) buffer_length; ++i) {

        // Get the current character
        char current_char = buffer[i];

        // If the character is "F" or "E"
        if (strchr("FE", current_char) != NULL) {

            // Add a space to the string to print
            string_to_print[i] = ' ';

            // Continue the loop
            continue;
        }

        // Convert the current character to a mathematical symbol
        char math_symbol = match_character_to_math_symbol(current_char);

        // Add the mathematical symbol to the string to print
        string_to_print[i] = math_symbol;
    }

    // Set the last character to the null terminator
    string_to_print[buffer_length] = '\0';

    // Set the cursor to be on the first column and the first row
    LCD.setCursor(0, 0);

    // Print the string
    LCD.print(string_to_print);
}

// The function to parse an infix expression to
// a reverse polish notation expression (RPN)
String parse_infix_expression_to_reverse_polish_notation(char* string) {

    // Get the length of the string
    int length = strlen(string);

    // Create a character stack to store the operators
    CharacterStack operator_stack;

    // Initialise the operator stack
    operator_stack.initialise();

    // Create the output stack to store the output
    StringStack output_stack;

    // Initialise the output stack
    output_stack.initialise();

    // Initialise the number character array to store the number
    char number_char_array[length + 1];

    // Clear the number character array to initialise it
    clear_string_buffer(number_char_array, length + 1);

    // Initialise the index of the number string
    int number_char_array_index = 0;

    // Iterate over the string
    for (int i = 0; i < length; ++i) {

        // Get the current character
        char current_char = string[i];

        // If the current character is "E", "F", or a space, continue the loop
        if (strchr("EF ", current_char) != NULL) continue;

        // Otherwise, if the character is not a mathematical operator
        if (strchr("ABCD", current_char) == NULL) {

            // Add the current character to the number string
            number_char_array[number_char_array_index] = current_char;

            // Increment the index of the number string
            number_char_array_index++;

            // Continue the loop
            continue;
        }

        // Otherwise, the current character is a mathematical operator

        // Convert the number character array to a string
        String number_string = String(number_char_array);

        // Trim the number string
        number_string.trim();

        // Initialise the variable to
        // store if the number string is empty
        bool number_string_is_empty = true;

        // If the number string is not empty
        if (number_string.length() != 0) {

            // Push the number string onto the output stack
            output_stack.push(number_string);

            // Set the number string is empty flag to false
            number_string_is_empty = false;
        }

        // Clear the number string
        clear_string_buffer(number_char_array, length + 1);

        // Reset the number index to 0
        number_char_array_index = 0;

        // Get the operator at the top of the operator stack
        char peeked_operator = operator_stack.peek();

        // If the number string is empty,
        // which means there are two operators back to back
        if (number_string_is_empty) {

            // Get the symbol of the current mathematical operator
            char current_char_symbol = match_character_to_math_symbol(
                current_char
            );

            // Get the symbol of the peeked operator
            char peeked_operator_symbol = match_character_to_math_symbol(
                peeked_operator
            );

            // If the current operator is a multiply (*) or divide (/)
            if (current_char_symbol == '*' || current_char_symbol == '/') {

                // Skip the current mathematical operator
                // and continue the loop.
                //
                // This is invalid syntax, as
                // multiplication and division are not unary operators,
                // but we'll just ignore it instead of telling
                // the user there is a syntax error.
                continue;
            }

            // If the current operator and
            // the peeked operator are both pluses (+)
            if (current_char_symbol == '+' && peeked_operator_symbol == '+') {

                // Skip the current mathematical operator
                // and continue the loop
                continue;
            }

            // If the current operator is a plus (+)
            // and the peeked operator is a minus (-)
            if (current_char_symbol == '+' && peeked_operator_symbol == '-') {

                // Skip the current mathematical operator
                // and continue the loop
                continue;
            }

            // If the current operator is a minus (-)
            // and the peeked operator is a plus (+)
            if (current_char_symbol == '-' && peeked_operator_symbol == '+') {

                // Pop the top operator off the operator stack,
                // which is the peaked operator, a plus (+)
                operator_stack.pop();

                // Push the current operator to the operator stack,
                // which is a minus (-)
                operator_stack.push(current_char);

                // Continue the loop
                continue;
            }

            // If the current operator
            // and the peeked operator are both minuses (-)
            if (current_char_symbol == '-' && peeked_operator_symbol == '-') {

                // Pop the top operator off the operator stack
                // which is the peaked operator, a minus (-)
                operator_stack.pop();

                // Push a character 'A' to the operator stack
                // for plus (+)
                operator_stack.push('A');

                // Continue the loop
                continue;
            }
        }

        // Get the operator precedence of the current character
        int current_char_operator_precedence = get_operator_precedence(
            current_char
        );

        // Get the operator precedence of the peeked operator
        int peeked_operator_operator_precedence = get_operator_precedence(
            peeked_operator
        );

        // While the operator stack is not empty,
        // and the operator precedence of the
        // current operator is less than or equal
        // to the operator precedence of the operator
        // on the operator stack
        while (
            !operator_stack.is_empty() &&
            current_char_operator_precedence <=
            peeked_operator_operator_precedence
        ) {

            // Pop the operator onto the output stack
            char popped_operator = operator_stack.pop();

            // Push the popped operator to the output stack
            output_stack.push(String(popped_operator));
        }

        // Push the current operator to the operator stack
        operator_stack.push(current_char);
    }

    // If the number string index is not 0,
    // which means there is still another number,
    // push the number string to the output stack
    if (number_char_array_index != 0) {

        // Convert the number character array to a string
        String number_string = String(number_char_array);

        // Trim the number string
        number_string.trim();

        // Push the number string onto the output stack
        output_stack.push(number_string);
    }

    // While there are still operators in the operator stack,
    // push the operators to the output stack
    while (!operator_stack.is_empty()) {

        // Get the popped operator
        char popped_operator = operator_stack.pop();

        // Push the popped operator to the output stack
        output_stack.push(String(popped_operator));
    }

    // Initialise the output string
    String output_string = String("");

    // Get the size of the output stack
    int output_stack_size = output_stack.get_size();

    // Iterate over the output stack
    for (int i = 0; i < output_stack_size; ++i) {

        // Get the element at the index
        String element = output_stack.get(i);

        // Add a space to the output string
        output_string += " ";

        // Append the element to the output string
        output_string += element;
    }

    // Return the output string
    return output_string;
}

// The function to evaluate a reverse polish notation expression
int evaluate_reverse_polish_notation_expression(String expression) {

    // Get the length of the string
    size_t length = expression.length();

    // Create an integer stack to store the numbers
    IntegerStack number_stack;

    // Initialise the number stack
    number_stack.initialise();

    // Initialise the character array of the expression
    char expression_char_array[length + 1];

    // Copy the contents of the string to the character array
    expression.toCharArray(expression_char_array, length + 1);

    // Split the string at the spaces
    char* token = strtok(expression_char_array, " ");

    // While the token is not NULL
    while (token != NULL) {

        // If the token isn't a mathematical operator
        if (strchr("ABCDEF", token[0]) == NULL) {

            // Convert the token to an integer
            int integer = strtol(token, NULL, 10);

            // Push the integer to the number stack
            number_stack.push(integer);

            // Get the next token
            token = strtok(NULL, " ");

            // Continue the loop
            continue;
        }

        // Otherwise, the token is an operator,
        // so try to convert the token into a character
        char character = convert_string_to_char(token);

        // If the character is the null byte
        if (character == '\0') {

            // Get the next token
            token = strtok(NULL, " ");

            // Continue the loop
            continue;
        }

        // Otherwise, the get the mathematical operator
        // from the character
        math_operator math_op = match_character_to_operator(character);

        // If the math operator is NULL
        if (math_op == NULL) {

            // Get the next token
            token = strtok(NULL, " ");

            // Continue the loop
            continue;
        }

        // Otherwise, the mathematical operator exists

        // Pop the first two numbers off the number stack
        int first_number = number_stack.pop();
        int second_number = number_stack.pop();

        // Get the result of the mathematical operation
        int result = math_op(second_number, first_number);

        // Push the result to the number stack
        number_stack.push(result);

        // Get the next token
        token = strtok(NULL, " ");
    }

    // Get the size of the number stack
    size_t number_stack_size = number_stack.get_size();

    // If the number stack size is not 1,
    // return the minimum value of the integer type as there is a syntax error
    if (number_stack_size != 1) return INT16_MIN;

    // Get the result by popping off the number stack
    int result = number_stack.pop();

    // Return the result
    return result;
}

// The function to handle the keypad input
void handle_keypad_input() {

    // Get the length of the keypad input buffer
    size_t buffer_length = strlen(KEYPAD_INPUT_BUFFER.buffer);

    // If the mode is display mode
    if (ARDUINO_MODE == DISPLAY_MODE) {

        // Set the cursor to be on the first column
        // and the first row.
        LCD.setCursor(0, 0);

        // Print "  Display Mode  "
        LCD.print("  Display Mode  ");

        // Set to the first column and the second row
        LCD.setCursor(0, 1);

        // Print the keypad input buffer
        LCD.print(KEYPAD_INPUT_BUFFER.buffer);

        // Exit the function
        return;
    }

    // Otherwise, the Arduino is in calculator mode
    // so check if the buffer is cleared
    if (KEYPAD_INPUT_BUFFER.is_cleared) {

        // If the result has been printed, exit the function
        if (KEYPAD_INPUT_BUFFER.has_printed_result) {

            // Set the result printed flag to false
            KEYPAD_INPUT_BUFFER.has_printed_result = false;

            // Set the cursor to be on the first column and the first row
            LCD.setCursor(0, 0);

            // Print an empty line
            lcd_print_empty_line();

            // Set the cursor to be on the first column and the second row
            LCD.setCursor(0, 1);

            // Print an empty line
            lcd_print_empty_line();

            // Exit the function
            return;
        }

        // Otherwise, set the cursor to be on the
        // first column and the first row.
        LCD.setCursor(0, 0);

        // Print "   Calc. Mode   "
        LCD.print("   Calc. Mode   ");

        // Set the cursor to be on the first column and the second row
        LCD.setCursor(0, 1);

        // Print an empty line
        lcd_print_empty_line();

        // Exit the function
        return;
    }

    // Otherwise, the keypad input buffer is not cleared,
    // so print the string in the keypad input buffer
    lcd_print_in_calculator_mode(KEYPAD_INPUT_BUFFER.buffer, buffer_length);

    // Set the cursor to be on the first column and the second row
    LCD.setCursor(0, 1);

    // Print an empty line
    lcd_print_empty_line();

    // If the buffer is not complete, exit the function
    if (!KEYPAD_INPUT_BUFFER.is_complete) return;

    // Parse the keypad input buffer
    String reverse_polish_notation_result =
        parse_infix_expression_to_reverse_polish_notation(
            KEYPAD_INPUT_BUFFER.buffer
        );

    // Evaluate the reverse polish notation expression
    // and get the result
    int result = evaluate_reverse_polish_notation_expression(
        reverse_polish_notation_result
    );

    // If the result is not the minimum value of the integer type
    if (result != INT16_MIN) {

        // Initialise the string to store the result
        char result_string[buffer_length + 1];

        // Get the length of the result string
        // and convert the result to a string
        size_t result_string_length = sprintf(result_string, "%d", result);

        // Get the starting column to print the result string
        int starting_column = 16 - result_string_length;

        // Set the cursor to be on the column of the starting position
        // and on the second row.
        // The rows and columns are numbered from 0, so the second row is 1
        LCD.setCursor(starting_column, 1);

        // Print the result string
        LCD.print(result_string);
    }

    // Otherwise, the result is NULL
    else {

        // Set the cursor to be on the first column and the second row
        LCD.setCursor(0, 1);

        // Print that there is a syntax error
        LCD.print("  Syntax error  ");
    }

    // Clear the keypad input buffer
    clear_keypad_input_buffer();

    // Set the buffer to incomplete
    KEYPAD_INPUT_BUFFER.is_complete = false;

    // Set the result printed flag to true
    KEYPAD_INPUT_BUFFER.has_printed_result = true;
}

// The setup function to setup the Arduino
void setup() {

    // Set the input pins
    pinMode(DATA_AVAILABLE_PIN, INPUT);
    pinMode(KEYPAD_OUTPUT_A, INPUT);
    pinMode(KEYPAD_OUTPUT_B, INPUT);
    pinMode(KEYPAD_OUTPUT_C, INPUT);
    pinMode(KEYPAD_OUTPUT_D, INPUT);

    // Initialise the serial connection
    Serial.begin(9600);

    // Clear the keypad input buffer
    clear_string_buffer(
        KEYPAD_INPUT_BUFFER.buffer,
        sizeof KEYPAD_INPUT_BUFFER.buffer
    );

    // Set up the LCD's number of columns and rows
    LCD.begin(16, 2);

    // Set the cursor to the first row and first column
    LCD.setCursor(0, 0);

    // Print the welcome message
    LCD.print(" Arduino ready! ");
}

// The loop function to run the program
void loop() {

    // Delay for some time so that the keypad doesn't register
    // a heck ton of key presses
    delay(200);

    // If there is no data available, exit the function
    if (digitalRead(DATA_AVAILABLE_PIN) == LOW) return;

    // Otherwise, call the function to receive the keypad input
    receive_keypad_input();

    // Call the function to handle the keypad input
    handle_keypad_input();
}
