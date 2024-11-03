// The library for controlling the piezo buzzer

#include "PiezoBuzzer.h"

// The constructor for the piezo buzzer class
PiezoBuzzer::PiezoBuzzer(unsigned int buzzer_pin) : _buzzer_pin(buzzer_pin) {

  // Set the pin as output
  pinMode(this->_buzzer_pin, OUTPUT);
}

// Function to play a tone at a given frequency.
//
// This function is non-blocking, so it needs
// to be called in a loop every time the
// buzzer needs to be played.
void PiezoBuzzer::sound_buzzer_at_frequency(unsigned int frequency_in_hz) {


  // Get the current time in milliseconds
  unsigned long current_time_in_ms = millis();

  // Get the total duration of the tone in milliseconds
  unsigned int total_duration_in_ms = 1000.0 / float(frequency_in_hz);

  // If the current time minus the last time the tone was played
  // is less than the total duration of the tone,
  // exit the function
  if (current_time_in_ms - this->_last_tone_time <
      (unsigned long)total_duration_in_ms) {
    return;
  }

  // Otherwise, the tone duration in milliseconds
  float tone_duration_in_ms =
      PIEZO_BUZZER_TONE_DURATION_MULTIPLIER * total_duration_in_ms;

  // Play the tone
  tone(this->_buzzer_pin, PIEZO_BUZZER_TONE, tone_duration_in_ms);

  // Set the last time the tone was played
  this->_last_tone_time = millis();
}

// Function to play a tone continuously
void PiezoBuzzer::sound_buzzer_continuously() {

  // Just play the tone continuously
  tone(this->_buzzer_pin, PIEZO_BUZZER_TONE);
}

// Function to stop the buzzer
void PiezoBuzzer::stop_buzzer() {

  // Stop the tone
  noTone(this->_buzzer_pin);
}
