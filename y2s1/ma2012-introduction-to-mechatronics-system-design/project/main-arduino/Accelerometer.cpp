/* The accelerometer library to easily access the accelerometer data.
 *
 * The accelerometer object takes a communication protocol
 * as the first argument. The communication protocol is
 * either I2C or SPI.
 *
 * Ideally, the accelerometer should be using the I2C protocol.
 */

#include "Accelerometer.h"

/* The constructor for the accelerometer
 * takes the accelerometer address,
 * the desired measurement range
 * of the accelerometer, the communication
 * protocol, the least significant bit of the
 * accelerometer address for the data,
 * and an optional slave select pin.
 */

// The function to write data using the SPI protocol
void Accelerometer::_spi_write_data(uint8_t register_address,
                                    uint8_t data_in_binary) {

  // Set the slave select pin to low to enable SPI
  digitalWrite(this->_slave_select_pin, LOW);

  // Write to the register address
  SPI.transfer(register_address);

  // Write to the data in binary to the register
  SPI.transfer(data_in_binary);

  // Set the slave select pin to high to disable SPI
  digitalWrite(this->_slave_select_pin, HIGH);
}

// The function to write data using the I2C protocol
void Accelerometer::_i2c_write_data(uint8_t register_address,
                                    uint8_t data_in_binary) {

  // Begin the I2C transmission
  Wire.beginTransmission(this->_accelerometer_address);

  // Write to the register address
  Wire.write(register_address);

  // Write to the data in binary to the register
  Wire.write(data_in_binary);

  // End the I2C transmission
  Wire.endTransmission();
}

// The generic write data function
void Accelerometer::_write_data(unsigned int register_address,
                                unsigned int data_in_binary) {

  // Match on the communication protocol
  switch (this->_communication_protocol) {

  case SPI_PROTOCOL:
    return this->_spi_write_data(register_address, data_in_binary);
  case I2C_PROTOCOL:
    return this->_i2c_write_data(register_address, data_in_binary);
  }
}

// The function to get the measurement range setting in binary
// to write to the accelerometer
uint8_t Accelerometer::_get_measurement_range_setting(
    MeasurementRange measurement_range) {
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

// Initialise the data in the arrays
void Accelerometer::_initialise_data_arrays() {

  // Iterate over the data arrays
  for (unsigned int i = 0; i < ACCELEROMETER_DATA_ARRAY_SIZE; ++i) {
    this->_acceleration_data[i] = 0.0;
    this->_measurement_times[i] = 0.0;
  }
}

/* The constructor for the SPI protocol.
 *
 * The constructor takes a measurement range,
 * the least significant bit of the accelerometer address,
 * the slave select pin, the SPI maximum clock speed in Hz,
 * the data order, and the SPI mode.
 */
Accelerometer::Accelerometer(MeasurementRange measurement_range,
                             unsigned int slave_select_pin)
    : _measurement_range(measurement_range),
      _least_significant_bit_of_x_address(LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS),
      _slave_select_pin(slave_select_pin), _accelerometer_address(0),
      _communication_protocol(SPI_PROTOCOL),
      _spi_settings(SPISettings(2000000, MSBFIRST, SPI_MODE3)) {

  // Initialise the data arrays
  this->_initialise_data_arrays();

  // Set the slave select pin to output
  pinMode(this->_slave_select_pin, OUTPUT);

  // Set the slave select pin to high to disable SPI
  pinMode(this->_slave_select_pin, HIGH);
}

/* The constructor for the I2C protocol.
 *
 * The constructor takes a measurement range,
 * the least significant bit of the accelerometer address,
 * and the accelerometer address.
 */
Accelerometer::Accelerometer(MeasurementRange measurement_range)
    : _measurement_range(measurement_range),
      _least_significant_bit_of_x_address(LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS),
      _slave_select_pin(0), _accelerometer_address(ACCELEROMETER_ADDRESS),
      _communication_protocol(I2C_PROTOCOL) {

  // Initialise the data arrays
  this->_initialise_data_arrays();
}

// The function to initialise the accelerometer.
// This function must be called before using the accelerometer.
void Accelerometer::initialise() {

  // Switch on the accelerometer communication protocol
  switch (this->_communication_protocol) {

  // SPI protocol
  case SPI_PROTOCOL:

    // Initialise the SPI communication
    SPI.begin();

    // Set the SPI settings
    SPI.beginTransaction(this->_spi_settings);

    // Break out of the switch statement
    break;

  // I2C protocol
  case I2C_PROTOCOL:

    // Initialise the I2C communication
    Wire.begin();

    // Begin I2C transmission to the accelerometer
    Wire.beginTransmission(this->_accelerometer_address);

    // Break out of the switch statement
    break;
  }

  // Start the measurement.
  // The POWER_CTL register is written to 0x2D
  // and the measure bit is D3.
  this->_write_data(POWER_CTL_REGISTER, SET_MEASURE_BIT);

  // Change the measurement range to the set one
  this->_write_data(
      MEASUREMENT_RANGE_REGISTER,
      this->_get_measurement_range_setting(this->_measurement_range));
}

// Function to get the size of the data array of the accelerometer
unsigned int Accelerometer::get_data_array_size() {
  return ACCELEROMETER_DATA_ARRAY_SIZE;
}

// Function to read the x, y, and z acceleration data
// using the SPI protocol
void Accelerometer::_spi_read_x_y_z_raw_acceleration_data(int &x, int &y,
                                                          int &z) {

  // Enable SPI
  pinMode(this->_slave_select_pin, LOW);

  // Set the first two bits for the SPI transfer.
  // The first bit is set to 1 to read data.
  // The second bit is set to 1 to allow
  // multiple bytes to be read.
  unsigned int transfer_settings = 0b11;

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
  SPI.transfer(transfer_settings << 6 | LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS);

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
  int x_acceleration = SPI.transfer(0) | SPI.transfer(0) << 8;
  int y_acceleration = SPI.transfer(0) | SPI.transfer(0) << 8;
  int z_acceleration = SPI.transfer(0) | SPI.transfer(0) << 8;

  // Disable SPI
  digitalWrite(this->_slave_select_pin, HIGH);

  // Save the acceleration data to the pointers given
  x = x_acceleration;
  y = y_acceleration;
  z = z_acceleration;
}

// Function to read the x, y, and z acceleration data
// using the I2C protocol
void Accelerometer::_i2c_read_x_y_z_raw_acceleration_data(int &x, int &y,
                                                          int &z) {

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
  int x_acceleration = Wire.read() | Wire.read() << 8;
  int y_acceleration = Wire.read() | Wire.read() << 8;
  int z_acceleration = Wire.read() | Wire.read() << 8;

  // Save the acceleration data to the pointers given
  x = x_acceleration;
  y = y_acceleration;
  z = z_acceleration;
}

// The generic function to read the x, y, and z acceleration data
void Accelerometer::_read_x_y_z_raw_acceleration_data(int &x, int &y, int &z) {
  switch (this->_communication_protocol) {

  case SPI_PROTOCOL:
    return this->_spi_read_x_y_z_raw_acceleration_data(x, y, z);
  case I2C_PROTOCOL:
    return this->_i2c_read_x_y_z_raw_acceleration_data(x, y, z);
  }
}

// Function to get the scale factor for the measurement range
float Accelerometer::_get_scale_factor(MeasurementRange measurement_range) {
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

// Function to store the acceleration data
void Accelerometer::_store_acceleration_data(
    float acceleration, unsigned long time_in_milliseconds) {

  // Iterate over the data arrays
  for (unsigned int i = 0; i < ACCELEROMETER_DATA_ARRAY_SIZE - 1; ++i) {

    // Set the data in the next item to the current item
    this->_acceleration_data[i + 1] = this->_acceleration_data[i];
    this->_measurement_times[i + 1] = this->_measurement_times[i];
  }

  // Set the acceleration data to the current acceleration
  this->_acceleration_data[0] = acceleration;

  // Set the measurement time to the current time
  this->_measurement_times[0] = time_in_milliseconds;
}

// Function to get the acceleration data
float Accelerometer::get_acceleration_magnitude() {

  // Create the pointers for the x, y and z components of the accelerometer data
  int x = 0, y = 0, z = 0;

  // Read the x, y, and z acceleration data
  this->_read_x_y_z_raw_acceleration_data(x, y, z);

  // Get the scale factor for the measurement range
  float scale_factor = this->_get_scale_factor(this->_measurement_range);

  // Get the actual acceleration
  float x_acceleration = x * scale_factor;
  float y_acceleration = y * scale_factor;
  float z_acceleration = z * scale_factor;

  // Get the magnitude of the acceleration
  float acceleration_magnitude =
      sqrt(x_acceleration * x_acceleration + y_acceleration * y_acceleration +
           z_acceleration * z_acceleration);

  // Return the magnitude of the acceleration
  return acceleration_magnitude;
}

// Function to measure the acceleration at the current time
// and store it
void Accelerometer::measure_and_store_data() {

  // Get the acceleration magnitude
  float acceleration_magnitude = this->get_acceleration_magnitude();

  // Store the acceleration magnitude
  this->_store_acceleration_data(acceleration_magnitude, millis());
}

// Function to get the accelerometer data
void Accelerometer::get_accelerometer_data(
    float acceleration_data[ACCELEROMETER_DATA_ARRAY_SIZE],
    unsigned long measurement_times[ACCELEROMETER_DATA_ARRAY_SIZE]) {

  // Iterate over the data arrays
  for (unsigned int i = 0; i < ACCELEROMETER_DATA_ARRAY_SIZE; ++i) {

    // Copy the acceleration data into the given array
    acceleration_data[i] = this->_acceleration_data[i];

    // Copy the measurement time into the given array
    measurement_times[i] = this->_measurement_times[i];
  }
}
