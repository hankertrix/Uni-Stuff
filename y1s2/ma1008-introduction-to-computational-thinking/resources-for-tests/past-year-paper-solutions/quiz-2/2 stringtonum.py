
# Friday program, convert a numeric string to the actual numerical value
# without using int() or float()

# The Program
# Write a program that reads in a number as a string, and then without using the int( ) or float( ) functions, convert the string into its actual numerical value, and print the result of the number + 10. You may assume that there ae no leading spaces in the input string. Below are some example dialogues (underlined text is user input):

# Enter a number: 99
# 99 + 10 = 109

# Enter a number: 42.8
# 42.8 + 10 = 52.8

# Enter a number: -0.36
# -0.36 + 10 = 9.67

# Enter a number: -1.2.3
# -1.2.3 is not a valid number

# Enter a number: 123abc
# 123abc is not a valid number


# Note:

# 1. In effect, you are to implement what is done inside int( ) and float( ). You need to use the ord( ) function to get the numerical value of a digit character.

# 2. You get 70% for solving the problem for positive integers only. You get another 20% for making it work for positive floats as well. The remaining 10% for dealing with negative numbers. All in one program, of course.

# 3. Do not be concerned if your output varies slightly from the actual input value. For example, if your output is supposed to be 23.4567 and it prints 23.45669999999997, this is acceptable as it is not your fault. It is due to the inaccuracy in floating point number computation. Do not attempt to format the output to a specific number of digits, as you must allow the user to input a string of any length. (This formatting can be done, but it will take time that you can ill afford.)

# 4. Repeat: do not use the float() or int() functions.

numstring = input("Enter a number (with or without decimal place): ")
whole_value = 0      # value of whole number part
dec_value = 0        # value of part after decimal point
pos = 0              # position after decimal place
before_point = True   # indicate before decimal point
valid = True

# deal with the sign first
if numstring[0] == "-":
   sign = -1
   posstring = numstring[1:]  # remove the sign
else:
   posstring = numstring
   sign = 1

for c in posstring:   # decode a positive numstring
    if c in "0123456789":   # c is a digit
        if before_point:   # before decimal point, it's whole number
           whole_value = whole_value*10 + ord(c) - ord("0")
        else:
           pos = pos + 1 # postion after decimal point
           dec_value = dec_value + (ord(c) - ord("0"))*(0.1**pos)
    elif c == ".":
        if before_point:
            before_point = False  # register decimal point has appeared
        else:   # this else clause registers invalid if "." appears again
            valid = False
            break
    else:
        valid = False  # any other character is invalid
        break

if valid:
    print(numstring, "+ 10 is", sign*(whole_value + dec_value) + 10)
else:
    print(numstring, "is not a valid number")
