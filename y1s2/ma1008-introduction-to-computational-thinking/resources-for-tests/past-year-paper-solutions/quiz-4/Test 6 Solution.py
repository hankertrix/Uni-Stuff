# The file ExchangeRate.txt contains the exchange rate of different currencies
# against one Singapore dollar. Each line in the file contains three items:
#     Short currency name (three letters),
#     exchange rate,
#     full currency name,
#     separated by commas.
#
# The exchange rate is a floating point number and the other two are strings.
# Hence the line
#     ARP, 67.9, Argentine Peso
# states that one Singapore dollar is 67.9 Argentine Pesos.
#
# 1. Write a function called currencyRate that takes a line from the file as an
#    input parameter and returns the three fields in the line as a list with
#    three items [string, float, string].
#
# 2. Write another function called exchangeAmount which takes the
#    following three parameters:
#     - amount: the amount to be converted
#     - currency: the currency to convert to or from
#     - mode: a value indicating converting to or from the above currency,
#             and defaulted to "to". It returns the amount in the other
#             currency. You are free to choose how mode is represented.
#
# 3. Write a program that asks for:
#     (1) the currency concerned using the three-letter short currency name,
#     (2) the amount to be converted and
#     (3) whether to or from that currency.
#    It then prints the result using the full name of the currency.
#    You need to use the two functions above.
#
# Here are four example dialogues (underlined texts are user inputs):
#
#     Currency: USD
#     Amount: 20
#     To or from USD (T/F)? F
#     20 US Dollars = 26.95 Singapore Dollars
#
#     Currency: USD
#     Amount: 20
#     To or from USD (T/F)? T
#     20 Singapore Dollars = 14.84 US Dollars
#
#     Currency: PHP
#     Amount: 100
#     To or from PHP (T/F)? F
#     100 Philippines Pesos = 2.77 Singapore Dollars
#
#     Currency: USC
#     USC is an unknown currency


# Author: Lee Yong Tsui
# MA1008 CA4 Week 11
# A program to read in lines of exchange rates against 1 Singapore dollar
# Then read in an amount and return the amount in Singapore dollar or
# the line's currency, depending on whether it is to or from Singapore dollar

def currencyRate(L):
   # L is a line read in from the data file, with 3 items separated by ", "
   # return the currency code, exchange rate and full currency name

   items = L.strip("\n").split(", ") # split L into the 3 items, get rid of "\n" at the end
   return items[0], float(items[1]), items[2]

def allCurrencies():   # store all currencies and the rates in a list
   curList = []
   for L in inFile:
      curList.append(currencyRate(L))

   return curList

def exchangeAmount(amount, currency, mode, curList):

   for i in range(len(curList)):
      if curList[i][0] == currency:
         rate = curList[i][1]
            
         if mode == "T":  # from S$ to line currency
            xAmount = amount/rate
         else:
            xAmount = amount*rate
         return True, xAmount, curList[i][2]
      
   # no currency found
   return False, 0.0, ""  # False means wrong currency code


inFile = open("exchangerate.txt", "r")

curList = allCurrencies()

currency = input("Enter currency code for exchange: ")
amount = float(input("Ener the amount to be exchanged: "))
TF = input("To or from Singapore dollar? (T/F): ")

valid, xAmount, currencyName = exchangeAmount(amount, currency, TF, curList)
if valid:
   if TF == "T":
      print(f"{amount} {currencyName} = {xAmount:.2f} Singapore dollars.")
   else:
      print(f"{amount:.2f} Singapore dollars = {xAmount:.2f} {currencyName}.")
else:
   print(currency, "is not a valid currency code.")
      

         
