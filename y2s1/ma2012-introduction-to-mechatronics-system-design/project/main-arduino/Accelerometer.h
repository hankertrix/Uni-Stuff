/* The accelerometer library to easily access the accelerometer data.
 *
 * Look at the Accelerometer.cpp file for implementation and documentation
 */

#ifndef ACCELEROMETER_H
#define ACCELEROMETER_H

#include "Arduino.h"
#include "SPI.h"
#include "Wire.h"

// Define the constants
static const uint8_t ACCELEROMETER_ADDRESS = 0x1D;
static const uint8_t LEAST_SIGNIFICANT_BIT_OF_X_ADDRESS = 0x32;
static const uint8_t POWER_CTL_REGISTER = 0x2D;
static const uint8_t MEASUREMENT_RANGE_REGISTER = 0x31;
static const uint8_t SET_MEASURE_BIT = 0b00001000;
static const unsigned int ACCELEROMETER_DATA_ARRAY_SIZE = 15;

// The communication protocol for the accelerometer
enum CommunicationProtocol {
  SPI_PROTOCOL,
  I2C_PROTOCOL,
};

// The measurement range of the accelerometer.
// This is in terms of G's, which is 9.81ms^-2
enum MeasurementRange {
  TWO_G,
  FOUR_G,
  EIGHT_G,
  SIXTEEN_G,
};

// The accelerometer class
class Accelerometer {

private:
  //

  // Saved parameters
  const MeasurementRange _measurement_range;

  // The least significant bit of the
  // data from the accelerometer
  const unsigned int _least_significant_bit_of_x_address;

  // Variables for the SPI protocol
  const unsigned int _slave_select_pin;

  // Variables for the I2C protocol
  const uint8_t _accelerometer_address;

  // Generated variables from given parameters
  const CommunicationProtocol _communication_protocol;
  const SPISettings _spi_settings;

  // State variables
  float _acceleration_data[ACCELEROMETER_DATA_ARRAY_SIZE];
  unsigned long _measurement_times[ACCELEROMETER_DATA_ARRAY_SIZE];

  // Functions
  uint8_t _get_measurement_range_setting(MeasurementRange measurement_range);
  void _spi_write_data(uint8_t register_address, uint8_t data_in_binary);
  void _i2c_write_data(uint8_t register_address, uint8_t data_in_binary);
  void _write_data(unsigned int register_address, unsigned int data_in_binary);
  void _initialise_data_arrays();
  void _spi_read_x_y_z_raw_acceleration_data(int &x, int &y, int &z);
  void _i2c_read_x_y_z_raw_acceleration_data(int &x, int &y, int &z);
  void _read_x_y_z_raw_acceleration_data(int &x, int &y, int &z);
  float _get_scale_factor(MeasurementRange measurement_range);
  void _store_acceleration_data(float acceleration_magnitude,
                                unsigned long time_in_milliseconds);

public:
  //

  // Constructor for the SPI protocol
  Accelerometer(MeasurementRange measurement_range,
                unsigned int slave_select_pin);

  // Constructor for the I2C protocol
  Accelerometer(MeasurementRange measurement_range);

  // Methods
  void initialise();
  unsigned int get_data_array_size();
  float get_acceleration_magnitude();
  void measure_and_store_data();
  void get_accelerometer_data(
      float acceleration_data[ACCELEROMETER_DATA_ARRAY_SIZE],
      unsigned long measurement_times[ACCELEROMETER_DATA_ARRAY_SIZE]);
};

#endif
