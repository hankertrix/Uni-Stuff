// The library for controlling the piezo buzzer

#ifndef PIEZO_BUZZER_H
#define PIEZO_BUZZER_H

#include "Arduino.h"

// The frequency of the tone to play for the piezo buzzer.
// It is an E5.
static const unsigned int PIEZO_BUZZER_TONE = 659;

// The duration multiplier for the tone to play for the piezo buzzer
static const float PIEZO_BUZZER_TONE_DURATION_MULTIPLIER = 0.7;

class PiezoBuzzer {

private:
  //

  // Stored parameters
  unsigned int _buzzer_pin;

  // State variables
  unsigned long _last_tone_time;

public:
  //

  // Constructor
  PiezoBuzzer(unsigned int buzzer_pin);

  // Functions
  void sound_buzzer_at_frequency(unsigned int frequency_in_hz);
  void sound_buzzer_continuously();
  void stop_buzzer();
};

#endif
