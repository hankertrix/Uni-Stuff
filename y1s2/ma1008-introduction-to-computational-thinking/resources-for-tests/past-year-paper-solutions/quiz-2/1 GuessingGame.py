# A number guessing game.
# Author: Lee Yong Tsui, March 2023

# The Program
# You are to program a number guessing game. Here are the actions the program needs to take:
# 1. First generate a random number between 0 to 100.
# 2. Obtain a guess from the user.
# 3. Tell the user if the guess is too high, too low, or is correct.
# 4. Depending on step 3, the program either returns to step 2 or exits the guessing due to (a) the guess is correct (b) five guesses have been made.
# 5. In the process, the program reminds the user of the number of guesses remaining, and also if the guess is going in the wrong direction.
# 6. Upon exit from guessing, the program offers the chance to return to Step 1 or exit the program.

# To generate a random number between 0 and 100, do the following:
#    import random
#    random_number = random.randint(0, 100)

# Below is a sample dialogue. Underlined text is user input.

# This is a number guessing game!
# Guess a number between 0–100 inclusive.
# Your guess: 50
# Too high!
# You have 4 tries remaining...

# Your guess: 20
# Too low!
# You have 3 tries remaining...

# Your guess: 75
# Too high!
# I have already told you 50 is too high!
# You have 2 tries remaining...

# Your guess: 12
# Too low!
# I have already told you 20 is too low!
# You have 1 try remaining...

# Your guess: 25
# Tough luck. You have had your 5 tries.
# The number is 32.

# [or Your guess: 32
# Correct. Well done. You got it in 5 tries!]

# Want to play again? Enter Y for yes, N for no: N
# Okay Bye.

import random

while True:  # loop for starting a new game
   print("\nThis is a number guessing game.")
   print("You have 5 tries to guess a number between 0 and 100.")

   number = random.randint(0, 100)  # the number to be guessed
   prev_high = 100   # variable to remember previous high
   prev_low = 0      # variable to remember previous low
   for tries in range(1, 6):
      guess = int(input(f"Enter your guess {tries}: "))
      if guess == number:
         print(f"Well done. You got it in {tries} tries.")
         break
      elif guess > number:
         print("Too high.")
         if guess > prev_high:
            print(f"I have told you {prev_high} is too high.")
         else:
            prev_high = guess
      else:  # guess < number
         print("Too low.")
         if guess < prev_low:
            print(f"I have told you {prev_low} is too low.")
         else:
            prev_low = guess

      if tries < 5:
         print(f"You have {5-tries} tries remaining ...")
      else:
         print("Tough luck. You have had your 5 tries.")
         print("The number is", number)

   # Done with a game, check if want another
   if input("\nWant another game? ").upper() != "Y":
      print("Bye ... ")

