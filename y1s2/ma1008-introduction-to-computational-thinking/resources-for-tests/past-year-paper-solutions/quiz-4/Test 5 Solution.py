# The file numbers.txt contains several lines of numbers separated by commas,
# some are integers and some are floating point numbers, and some are not
# numbers due to input errors.
#     (i) Write a function that takes a string of characters and return one of
#         three values: integer, float or error.
#         (You can choose how to represent these values yourself.)
#
#     (ii) Write a program that reads in the file and uses this function to
#          determine the number of integers, floating point numbers and
#          errors in the file.
#
# Here is a possible set of outputs:
#     Number of integers: 21
#     Number of floats: 15
#     Number of errors: 4
# (The figures above are fictitious.) Output your results to a file.
# You can choose the name of the file.


# Program to read numbers from a file and count number of ints and floats
# also need to count non-numbers.
# The algorithm relies on converting individual strings to numbers and check
# for failure. Convert to int first, if success, then it is an int. Else
# try float, if success, then it is a float. Else it must be error.
# Algorithm:
# Open the file
# Read the file line by line
# Split the line into strings based on " "
# For each component string
#    Convert it to integer
#    If successful, increase integer count by 1
#    Else convert it to float
#       If successful, increase float count by 1
#       Else increase error count by 1
#
# Print the results

def checkType(num):  # function to check if int, float or error
   try: # Check for float using exception handler
      x = float(num)

      try:  # At this point, float OK, but could it be an int?
          x = int(num)
          return "i"  # yes, it's an int
      except ValueError:  # no, not an int, so must be float
          return "f"

   except ValueError:  # not a float, so must be error
       return "e"  
    

while True:  # open the file
    filename = input("Enter input filename: ")
    try:
       infile = open(filename, "r")
       break
    except FileNotFoundError:
       print("File not found. Try again.")

while True:  # open the file
    filename = input("Enter output filename: ")
    try:
       outfile = open(filename, "w")
       break
    except OSError:
       print("File not found. Try again.")

fCount = 0  # initialise the counts
iCount = 0
eCount = 0

for L in infile:
    numList = L.split(",")  # get number list from the line
    for num in numList:
       try:
          value = int(num)
          iCount += 1  # success converting to int, increase integer count
       except ValueError:  # integer failed
          try:
             value = float(num) # try float
             fCount += 1  # success converting to float, increase float count
          except ValueError:
             eCount += 1  # not a float, must be error, increase error count

print("Number of floating point numbers:", fCount, file=outfile)
print("Number of integer numbers:", iCount, file=outfile)
print("Number of errors:", eCount, file=outfile)

infile.close()
outfile.close()
