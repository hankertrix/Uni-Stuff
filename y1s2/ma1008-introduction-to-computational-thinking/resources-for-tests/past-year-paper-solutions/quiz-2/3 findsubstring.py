# Author: Lee Yong Tsui
# Program to find index of substring within a given string

# (i) Without using any string methods such as index(), find() and count(), write a program that finds the index of a substring in a string. This index is the index of the first occurrence of the substring in the given string. Remember the index of a string starts from 0. Both the input string and the substring can be of any length but must be greater than 0. If the substring does not exist in the string, then the program should return -1.

# Here are two example dialogues (underlined text is user input).

# Enter a string: Today is Wednesday
# Enter a substring: day
# The index is 2.

# Enter a string: Today is Wednesday
# Enter a substring: days
# The index is -1.

# The above earns you a maximum of 70%.

# (ii) For the other 30%, add this capability in your program: A substring may occur in a string multiple times. Your program asks the user for which occurrence, and delivers the index of that occurrence. Here are three example dialogues:

# Enter a string: Today is Wednesday
# Enter a substring: day
# Enter the occurrence: 1
# The index is 2.

# Enter a string: Today is Wednesday
# Enter a substring: day
# Enter the occurrence: 2
# The index is 15.

# Enter a string: Today is Wednesday
# Enter a substring: day
# Enter the occurrence: 3
# The index is -1.

# Note: Part (ii) contains Part (i). Therefore, if you are submitting Part (ii), you need not submit Part (i). You only need to submit one program.

# Repeat: you may not use any string method that Python provides, such as index(), find(), count() and so forth.

string = input("Enter a string: ")
sub = input("Enter a sub-string: ")
n_oc = int(input("Enter occurrence: "))

oc = 0
for i in range(len(string)):
       if i+len(sub) > len(string):  # sub run beyond end of string
           index = -1
           break                     # means no match
       j = 0
       for c in sub:    # check sub against string from i char by char
           if c != string[i+j]:
               break    # no match, get out of sub loop
           j += 1
       else:   # match to end of sub, hence sub string found
           index = i   # update index and occurrence
           oc += 1
       if oc == n_oc:  # check the right occurrence has been reached
           break       # get out if so
       else:
           index = -1

print("The index is", index)
