# The file letter.txt contains a letter from a mother to her son.
# Write a program to read the letter and count the words of different lengths,
# and produce a tabulated output of the following format:
#
# Word length     Word count
#     ...            ...
#      6              12
#      5               9
#      4              18
#     ...             ...
# (The figures above are fictitious.)
# The word length should not include punctuation.
# Output your results to a file. You can choose the name of the file.
# Your program should include a function that takes a string which contains a
# word and checks if it contains any punctuation and returns the word correct
# length. You may provide more functions as you see fit.


# Program to read a passage in file and count words of different lengths.
# Punctuations are not included.
# Algorithm:
#    Use a dictionary to store counts of words of different lengths with the
#    word length as the key and the count as the value
#    Open input file and read it line by line
#    For each line, split it into words which are separated by " "
#       For each word
#          Count the characters without the punctuation at the end if exist
#          Add each count appropriately to the dictionary
#
#    Print the results to output file

def wordLength(word):  # function to count word length without punctuation 
    if (word[-1] in ".,;!?:\n"):  # check if last character a punctuation
        return len(word)-1
    return len(word)

while True:
    filename = input("Enter input filename: ")
    try:
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
       
lengths = {}  # a dictionary to store the counts of the different lengths
maxLength = 0

for L in infile:   # for each line in the input file
    wordList = L.split()  # get word list in line by splitting L at " "
    for word in wordList:
        length = wordLength(word)
        if length > maxLength:# remember the maximum length
            maxLength = length
        if length in lengths:  # add 1 to a particular length in the dictionary
            lengths[length] += 1
        else:
            lengths[length] = 1

print("Word Length      Word Count", file=outfile)
print("===========      ==========", file=outfile)
for i in range(1, maxLength+1):
    if (i in lengths):
       print("     {:2d}             {:3d}".format(i, lengths[i]), file=outfile)

infile.close()
outfile.close()
