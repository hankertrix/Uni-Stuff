# Author: Lee Yong Tsui
# Program to convert 12 hour clock to 24 hour clock

# The Program
# A time in the 12-hour format is written in the form “hour:minute am/pm”, where hour and minute are both two digit integers and am/pm is one of am or pm. A time in the 24-hour format is written simply in the form hour:minute. The numbers for the hour and the minute are always written using two digits. When a number is less than 10, then the leading digit is written with a 0. Hence 7 would be written as 07. One digit numbers are taken as an error.

# Write a program to read in a time in the 12 hour format and print it out in the 24 hour format. Your program should continue until the user gives an invalid input. Here is a set of sample dialogues of the program (user inputs are underlined):

# Enter time in 12-hour format: 07:02 pm
# The time in 24-hour format is 19:02.

# Enter time in 12-hour format: 12:45 am
# The time in 24-hour format is 00:45.

# Enter time in 12-hour format: 02:27 am
# The time in 24-hour format is 02:27.

# Enter time in 12-hour format: 7:02 am
# Invalid input. Program exiting!

# Enter time in 12-hour format: 10:95 am
# Invalid input. Program exiting!

# Enter time in 12-hour format: 1005 am
# Invalid input. Program exiting!

# Enter time in 12-hour format: 12:45
# Invalid input. Program exiting!

# Capital letters for am/pm are acceptable.

while True:
   time12 = input("Enter the time in the 12 hour format: ")

   # set the valid flag
   valid = True

   # process the input
   if time12[0:2].isdigit(): # get the hour
      hour = time12[0:2]
      if int(hour) < 0 or int(hour) > 12 or time12[2] != ":":
         valid = False
      else:
         if time12[3:5].isdigit():  # get the minutes
            minute = time12[3:5]
            if 0 <= int(minute) < 60:
               if time12[5:] == " am":   # get am or pm
                  am = True
               elif time12[5:] == " pm":
                  am = False
               else:
                  valid = False
            else:
               valid = False
         else:
            valid = False
   else:
      valid = False

   if valid:  # input is good, now produce output
      print("In the 24 hour format: ", end = "")
      if am:
         if int(hour) == 12:
            print("00" + ":" + minute)
         else:
            if int(hour) < 10:
               print(hour + ":" + minute)
            else:
               print(hour + ":" + minute)
      else:
         if int(hour) == 12:
            print(str(int(hour)) + ":" + minute)
         else:
            print(str(12+int(hour)) + ":" + minute)
   else:
      print("Invalid input. Program exiting.")
      break
