# A data file maths.txt contains a number of lines of text which are
# arithmetic expressions of the format
#
#     a <op> b
#
# Where a and b are numerical values and <op> is one of the five
# arithmetic operators +, -, *, / and %.
#
# There is always at least one space before and after the operator.
# Write a program that opens the file, reads in each line, evaluates and
# prints the result of the expression. Your program should include at least
# one function that takes the three components of an expression as arguments
# and returns the value of the expression.
#
# For example, for the first two lines of maths.txt, your program could
# print these results:
#     7.2 + 52 = 59.2
#     -84.3 * 2 = -168.6
#
# You may create your own data files to test your program with different
# arithmetic expressions. Handle any potential errors gracefully.


# CA4 Program on reading a file with arithmetic expressions
# Program to read arithmetic expressions from a file, evaluate them and print
# the results
# Algorithm:
#
#    Open input file and read it line by line
#    For each line, split it into three components separated by " "
#       num1 = float(component 1)
#       op = component 2 as a string
#       num2 = float(component 2)
#       Evaluate and return (num1 op num2)
#
#       Print the results to output file

def evaluate(num1, op, num2):
    # function to evaluate the expression given in 3 parts: num1, op, num2
    # with proper error handling if any of the inputs are wrong
    error = False
    try: 
       num1 = float(num1)

       if (op not in "+-*/%"):
          error = True

       num2 = float(num2)
        
    except ValueError:   # trap error in coverting input string to number
       error = True

    if not error:
        if op == "+":
           value = num1 + num2
        elif op == "-":
           value = num1 - num2
        elif op == "*":
           value = num1 * num2
        elif op == "/":
           value = num1 / num2
        else: # op == "%"
           value = num1 % num2
    else:
        value = -99999  #an unlikely value required  for the return statement

    return value, error

# main program 
while True:
   try:
       filename = input("Enter filename: ")
       infile = open(filename, "r")
       break
   except FileNotFoundError:
       print("File not found. Try again.")

while True:
    filename = input("Enter output filename: ")
    try:
       outfile = open(filename, "w")
       break
    except OSError:
       print("File not found. Try again.")
       
for L in infile:  # read each line from the input file
    items = L.split()   # split input line into the three items

    value, error = evaluate(items[0], items[1], items[2]) # evaluate the expression
    if not error:
       print(L.strip("\n"), "=", value, file = outfile)
    else:
       print(L.strip("\n"), "is not a valid arithmetic expression.", file=outfile)

infile.close()
outfile.close()
