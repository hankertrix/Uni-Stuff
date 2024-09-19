/*
 * Write a program to perform the following tasks which involves the
 * ADXL345 accelerometer
 * - If accelerometer is horizontal (tilt <= +- 10 degrees),
 *   set the on-board LED to blink
 *   * Display "0 degree" on Serial Monitor
 * - If abs(tilt) > 10 degrees, turn off the LED
 *   * Display the tilt angle (to the nearest 0.5 degree) on Serial Monitor,
 *     e.g. "15.0 degrees" or "-73.5 degrees"
*/

// Assuming circuit 3A is used for SPI
// and circuit 3B is used for I2C,
// and both circuits have an LED connected
// to pin 3.

// Include the SPI and I2C libraries
#include <SPI.h>
#include <Wire.h>

// Define the pins
#define SLAVE_SELECT_PIN 10
#define LED_PIN 3

// Initialise the SPI settings
// The SPI clock rate is 2MHz,
// as determined by the data sheet
// of the accelerometer.
const SPISettings SPI_SETTINGS(2000000, MSBFIRST, SPI_MODE3);

// The enum for the measurement range.
// G stands for the acceleration due to gravity.
enum MeasurementRange {
    TWO_G,
    FOUR_G,
    EIGHT_G,
    SIXTEEN_G
};

// The enum for the communication protocol to use
enum CommunicationProtocol {
    SPI_PROTOCOL,
    I2C_PROTOCOL
};

// Initialise the measurement range to use
const MeasurementRange MEASUREMENT_RANGE = EIGHT_G;

// Initialise the communication protocol to use
const CommunicationProtocol COMMUNICATION_PROTOCOL = SPI_PROTOCOL;

// Initialise the accelerometer address
const uint8_t ACCELEROMETER_ADDRESS = 0x1D;

// Initialise the least significant bit of x
const uint8_t LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS = 0x32;

// Initialise the interval between each blink of the LED
// in milliseconds
const int LED_BLINK_INTERVAL_IN_MS = 200;

// Initialise the variable to store the last time
// the LED was blinked
static unsigned long last_led_blink_time = 0;

// Initialise the variable to store the on-board LED state
static int led_state = LOW;

// The function to write data using the I2C protocol to the accelerometer
void i2c_write_data(uint8_t register_address, uint8_t data_in_binary) {

    // Begin the I2C transmission
    Wire.beginTransmission(ACCELEROMETER_ADDRESS);

    // Write to the register address
    Wire.write(register_address);

    // Write the data in binary to the register
    Wire.write(data_in_binary);

    // End the I2C transmission
    Wire.endTransmission();
}

// The function to write data using the SPI protocol to the accelerometer
void spi_write_data(uint8_t register_address, uint8_t data_in_binary) {

    // Set the slave select pin to low to enable SPI
    digitalWrite(SLAVE_SELECT_PIN, LOW);

    // Write the register address
    SPI.transfer(register_address);

    // Write the data in binary to the register
    SPI.transfer(data_in_binary);

    // Set the slave select pin to high to disable SPI
    digitalWrite(SLAVE_SELECT_PIN, HIGH);
}

// The function to get the measurement range setting.
// This is from page 17 of the data sheet, at the bottom,
// at table 18, under register 0x31.
uint8_t get_measurement_range_setting(MeasurementRange measurement_range) {
    switch (measurement_range) {
        case TWO_G:
            return 0b00000000;
        case FOUR_G:
            return 0b00000001;
        case EIGHT_G:
            return 0b00000010;
        case SIXTEEN_G:
            return 0b00000011;
        default:
            return 0;
    }
}

// The setup function to setup the Arduino
void setup() {

    // Start the serial connection
    Serial.begin(9600);

    // Set the LED pin to be an output
    pinMode(LED_PIN, OUTPUT);

    // If the communication protocol is I2C
    if (COMMUNICATION_PROTOCOL == I2C_PROTOCOL) {

        // Initialise the I2C communication
        Wire.begin();

        // Begin the transmission to the accelerometer
        Wire.beginTransmission(ACCELEROMETER_ADDRESS);

        // Start the measurement.
        // The POWER_CTL register is 0x2D,
        // and the measure bit is D3.
        i2c_write_data(0x2D, 0b00001000);

        // Change the measurement range to set one
        i2c_write_data(0x31, get_measurement_range_setting(MEASUREMENT_RANGE));

        // Exit the function
        return;
    }

    // Otherwise, the communication protocol is SPI,
    // so set the slave select pin to output
    pinMode(SLAVE_SELECT_PIN, OUTPUT);

    // Set the slave select pin to high to disable SPI
    digitalWrite(SLAVE_SELECT_PIN, HIGH);

    // Start SPI
    SPI.begin();

    // Set the SPI settings
    SPI.beginTransaction(SPI_SETTINGS);

    // Start the measurement.
    // The POWER_CTL register is 0x2D,
    // and the measure bit is D3.
    spi_write_data(0x2D, 0b00001000);

    // Change the measurement range to set one
    spi_write_data(0x31, get_measurement_range_setting(MEASUREMENT_RANGE));
}

// The function to get the scale factor.
// This is from page 3 of the data sheet, under scale factor.
// The scale factor is listed in milli-Gs, so the values
// in the data sheet are divided by 1000 to make it G.
float get_scale_factor(MeasurementRange measurement_range) {
    switch (measurement_range) {
        case TWO_G:
            return 0.0039;
        case FOUR_G:
            return 0.0078;
        case EIGHT_G:
            return 0.0156;
        case SIXTEEN_G:
            return 0.0312;
        default:
            return 0.0;
    }
}

// The function to get the tilt angle
float get_tilt_angle_in_degrees(
    float x_acceleration,
    float y_acceleration,
    float z_acceleration
) {

    // Get the dot product of the acceleration data
    // with the unit vector of the z axis,
    // which is the normal to the x-y plane.
    //
    // The unit vector of the z axis is (0, 0, 1),
    // so the dot product is essentially just
    // the z acceleration.
    float dot_product = z_acceleration;

    // Get the magnitude of the acceleration data
    float magnitude_of_acceleration = sqrt(
        x_acceleration * x_acceleration
        + y_acceleration * y_acceleration
        + z_acceleration * z_acceleration
    );

    // Get the cosine of the tilt angle,
    // which is the angle between the acceleration vector
    // and the unit vector of the z axis.
    //
    // This is done by dividing the dot product
    // by the magnitude of the acceleration data
    // multiplied by the magnitude of the
    // unit vector of the z axis, which is 1,
    // so the denominator is just the magnitude of the
    // acceleration data.
    float cosine_of_tilt_angle =
        dot_product / magnitude_of_acceleration;

    // Get the tilt angle in radians
    // and the unit vector of the z axis in radians
    float tilt_angle_in_radians =
        acos(cosine_of_tilt_angle);

    // Convert the tilt angle into degrees
    float tilt_angle_in_degrees =
        tilt_angle_in_radians * 180 / PI;

    // Return the tilt angle in degrees
    return tilt_angle_in_degrees;
}

// Function to blink the on-board LED
void blink_led() {

    // Get the current time
    unsigned long current_time = millis();

    // If the current time minus the last time the LED was blinked
    // is less than the interval between each blink of the LED,
    // exit the function
    if (current_time - last_led_blink_time < LED_BLINK_INTERVAL_IN_MS) {
        return;
    }

    // If the LED is set to LOW, then set the LED to HIGH
    if (led_state == LOW) led_state = HIGH;

    // Otherwise, set the LED state to LOW
    else led_state = LOW;

    // Write the LED state to the on-board LED
    digitalWrite(LED_PIN, led_state);

    // Set the last LED blink time to the current number of milliseconds
    last_led_blink_time = millis();
}

// The main loop function to get the data from the accelerometer
void loop() {

    // Initialise the variables to store
    // the acceleration data for the x, y, and z axis
    int x, y, z;

    // Get the scale factor
    float scale_factor = get_scale_factor(MEASUREMENT_RANGE);

    // If the communication protocol is I2C
    if (COMMUNICATION_PROTOCOL == I2C_PROTOCOL) {

        // Begin the transmission to the accelerometer
        Wire.beginTransmission(ACCELEROMETER_ADDRESS);

        // Send the address of the least significant bit of x.
        // The address is auto-increased after each read.
        Wire.write(LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS);

        // End the transmission to the accelerometer,
        // but keep the connection open,
        // which is the false argument passed to endTransmission
        Wire.endTransmission(false);

        // Request 6 bits of data from the accelerometer,
        // and stop the message after the transmission,
        // which is the true argument passed to endTransmission
        Wire.requestFrom(ACCELEROMETER_ADDRESS, uint8_t(6), uint8_t(true));

        // Read the data from the accelerometer.
        //
        // The least significant bit of x is read first,
        // so the second read is for the most significant bit,
        // which will need to be bitwise shifted
        // left by 8 bits to make the second bit the most
        // significant bit of the 16-bit integer.
        //
        // The bitwise OR operation just combines the two
        // bytes together to make a single 16-bit integer.
        x = Wire.read() | Wire.read() << 8;
        y = Wire.read() | Wire.read() << 8;
        z = Wire.read() | Wire.read() << 8;
    }

    // Otherwise, the communication protocol is SPI
    else {

        // Enable SPI
        digitalWrite(SLAVE_SELECT_PIN, LOW);

        // Set the first two bits for the SPI transfer.
        // The first bit is set to 1 to read data.
        // The second bit is set to 1 to allow
        // multiple bytes to be read.
        uint8_t transfer_settings = 0b11;

        // Write the transfer settings with the
        // address of the least significant bit of x
        // to the accelerometer.
        //
        // The transfer settings are the two
        // most significant bits of the transferred byte (8 bits),
        // so they need to be bitwise shifted left by 6 bits.
        //
        // The bitwise OR operation just combines the two bits
        // together to make a single byte.
        SPI.transfer(
            transfer_settings << 6 | LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS
        );

        // Read the data from the accelerometer.
        // Transferring 0 is the dummy value to read data using SPI.
        //
        // The least significant bit of x is read first,
        // so the second read is for the most significant bit,
        // which will need to be bitwise shifted
        // left by 8 bits to make the second bit the most
        // significant bit of the 16-bit integer.
        //
        // The bitwise OR operation just combines the two
        // bytes together to make a single 16-bit integer.
        x = SPI.transfer(0) | SPI.transfer(0) << 8;
        y = SPI.transfer(0) | SPI.transfer(0) << 8;
        z = SPI.transfer(0) | SPI.transfer(0) << 8;

        // Disable SPI
        digitalWrite(SLAVE_SELECT_PIN, HIGH);
    }

    // Get the acceleration data for the x, y, and z axis
    float x_acceleration = x * scale_factor;
    float y_acceleration = y * scale_factor;
    float z_acceleration = z * scale_factor;

    // Get the tilt angle in degrees
    float tilt_angle_in_degrees = get_tilt_angle_in_degrees(
        x_acceleration, y_acceleration, z_acceleration
    );

    // If the tilt angle is less than 10 degrees
    if (tilt_angle_in_degrees <= 10) {

        // Blink the on-board LED
        blink_led();

        // Print "0 degrees"
        Serial.println("0 degrees");

        // Exit the function
        return;
    }

    // Round the tilt angle to the nearest 0.5 degree
    // by multiplying the angle by 2, rounding the result,
    // and then dividing the result by 2
    float tilt_angle_in_degrees_rounded =
        float(round(tilt_angle_in_degrees * 2)) / 2;

    // Turn off the LED
    digitalWrite(LED_PIN, LOW);

    // Print rounded tilt angle
    Serial.print(tilt_angle_in_degrees_rounded);
    Serial.println(" degrees");
}
