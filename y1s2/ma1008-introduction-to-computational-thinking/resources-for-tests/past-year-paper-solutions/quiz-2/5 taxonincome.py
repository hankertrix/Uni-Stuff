# Income with tax and CPF

# The Program
# A restaurant has a number of employees who are on hourly pay. The normal pay is $15 an hour for up to 160 hours a month. Any hours beyond that are over time, paid at 1.5 times the normal rate.

# Employee incomes are subject to contributions to the Central Provident Fund (CPF). Employees contribute to their CPF from their income at 16% of the income, and the employer separately contributes 12%. The CPF contribution is exempted from tax.

# The personal income tax is 0% for the first $1,000, then increased to 10% for the next $2,000, and then 15% for amounts beyond $3,000.

# Write a program that reads in the number of employees and the total hours worked by each in a month.

# The program should also print
# i. The gross income each employee receives for the month (income before tax and CPF contributions).
# ii. The CPF amount each employee receives (from both the employee and employer contributions), the tax each employee pays and the actual take home income (which is the income after tax and CPF deductions).
# iii. The total employment cost to the employer (which includes the salary amounts of all the employees and the employer’s contribution to their CPF).

# Here is an example of a possible dialogue (underlined text is user input):

# Enter the number of employees: 2

# Employee 1
#    Enter hours worked in the month: 220
#    Gross income = $3750.00
#    CPF contributions received = $1050.00
#    Tax = $222.50
#    Take home income = $2927.50

# Employee 2
#    Enter hours worked in the month: 135
#    Gross income = $2025.00
#    CPF contributions received = $567.00
#    Tax = $70.10
#    Take home income = $1630.90

# Total employment cost to employer: $6468.00

# This example dialogue shows only two employees. Your program should cater to any number of employees, possibly hundreds.

n = int(input("Enter the number of employees: "))

TotbossCPF = 0
TotbossSalary = 0
for i in range(n):
   print("\nEmployee", i+1)
   hours = float(input("   Enter hours worked in the month: "))

   pay_rate = 15
   if hours <= 160:
      income = hours*pay_rate
   else:
      income = (160 + (hours-160)*1.5)*pay_rate

   employeeCPF = income*0.16  # employee CPF contribution
   bossCPF = income*0.12    # employer CPF contribution
   TotbossCPF += bossCPF    # cumulative employer CPF contribution
   TotbossSalary += income  # and salary cost

   taxable_income = (income - employeeCPF)

   if taxable_income < 1000:
      tax = 0
   elif taxable_income <= 3000:
      tax = (taxable_income-1000)*0.1
   else:
      tax = 200 + (taxable_income-3000)*0.15

   print(f"\n   Gross income = {income:.2f}")
   print(f"   CPF contributions received = {employeeCPF+bossCPF:.2f}")
   print(f"   Tax = {tax:.2f}")
   print(f"   Take home income = {income - employeeCPF - tax:.2f}")

print(f"\nTotal employment cost to employer: {TotbossCPF+TotbossSalary:.2f}")


