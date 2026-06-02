import math
import os.path
import random
import re

# The regex to check if a string is a number
is_number_regex = re.compile(r"^-?\d+(?:\.\d+)?$")

# The regex to match all the punctuation marks
punctuation_regex = re.compile(r"[.,?!;:'\"()\[\]{}-]")


def calculate_sphere_surface_area_and_volume() -> None:
    "Function to calculate the surface area and volume of a sphere."

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter the sphere radius: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Change the input into a floating point integer
    radius = float(user_input)

    # Calculate the sphere surface area
    surface_area = 4 * math.pi * radius ** 2

    # Calculate the sphere volume
    volume = (4 / 3) * math.pi * radius ** 3

    # Prints the surface area and volume
    print(f"Surface area of the sphere: {surface_area}")
    print(f"Volume of the sphere: {volume}")


def compute_simultaneous_eqn_solutions() -> None:
    """
    Function to calculate the solutions to a simultaneous equation of the form:
        a1x + b1y = c1
        a2x + b2y = c2
    """

    # The dictionary to store the data from the user
    coefficients: dict[str, float] = {}

    # Iterates over all the coefficients
    for term in ("a1", "b1", "c1", "a2", "b2", "c2"):

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(f"  {term}: ")

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Add the number to the dictionary
        coefficients[term] = float(user_input)

    # Gets all the variables from the dictionary
    a1 = coefficients["a1"]
    b1 = coefficients["b1"]
    c1 = coefficients["c1"]
    a2 = coefficients["a2"]
    b2 = coefficients["b2"]
    c2 = coefficients["c2"]

    # Calculate x and y
    x = (b2 * c1 - b1 * c2) / (a1 * b2 - a2 * b1)
    y = (a1 * c2 - a2 * c1) / (a1 * b2 - a2 * b1)

    # Print the solutions
    print(f"{x = }")
    print(f"{y = }")


def even_or_odd() -> None:
    "Function to print whether a given integer is even or odd."

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Enter an integer: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Prints whether the integer is even or odd
    print(
        f'''The integer {user_input} is {
            "even" if int(user_input) % 2 == 0 else "odd"
            }'''
    )


def calculate_bmi() -> None:
    "Function to calculate a person's BMI."

    # The dictionary containing the variable and the corresponding prompt
    prompt_dict = {
        "weight": "Please enter your weight in kg: ",
        "height": "Please enter your height in m: "
    }

    # The dictionary to store the user's input
    data_dict: dict[str, float] = {}

    # Iterates over the prompt dictionary
    for variable, prompt in prompt_dict.items():

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(prompt)

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Adds the user input to the data dictionary
        data_dict[variable] = float(user_input)

    # Gets the weight and the height
    weight = data_dict["weight"]
    height = data_dict["height"]

    # Calculate the person's BMI
    bmi = weight / (height ** 2)

    # Print the user's BMI
    print(f"Your BMI is {bmi}")


def calculate_marathon_time() -> None:
    "Function to calculate the time taken for a marathon."

    # Get the time for the first 12 km
    first_12_km_time_in_hr = 12 / 15

    # Get the time for the next 15 km
    next_15_km_time_in_hr = 15 / 10

    # Get the time for the following 10 km
    following_10_km_time_in_hr = 10 / 14

    # Get the time for the last stretch
    last_stretch_time_in_hr = (42.2 - 12 - 15 - 10) / 18

    # Get the total time
    total_time_in_hr = first_12_km_time_in_hr + next_15_km_time_in_hr \
        + following_10_km_time_in_hr + last_stretch_time_in_hr

    # Print the total time taken
    print(f"The runner took {total_time_in_hr}hrs.")


def read_and_print_input() -> None:
    """
    Function to read in a value and print it as an integer, float, and string.
    """

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter a number: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Print the result as the different data types
    print(f"The integer value is {int(user_input)}")
    print(f"The floating point value is {float(user_input)}")
    print(f"The string value is {str(user_input)}")


def evaluate_fourth_degree_polynomial() -> None:
    """
    Function to evaluate a fourth degree polynomial of the form:
    ax4 + bx3 + cx2 + dx + e
    """

    # The list of terms
    terms = ["x^4", "x^3", "x^2", "x", "constant"]

    # Initialise the dictionary to store the data
    data: dict[str, float] = {}

    # Iterate over the list of terms
    for term in terms:

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(
                f"Please enter the coefficient for the {term} term: "
            )

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Stores the user input in the data dictionary
        data[term] = float(user_input)

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter the value for x: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Stores the x value in the data dictionary
    data["x value"] = float(user_input)

    # Gets all the variables
    a = data["x^4"]
    b = data["x^3"]
    c = data["x^2"]
    d = data["x"]
    e = data["constant"]
    x = data["x value"]

    # Calculate the result
    result = a * (x ** 4) + b * (x ** 3) + c * (x ** 2) + d * x + e

    # Prints the result
    print(result)


def bet_against_a_dice() -> None:
    "Function to bet against a dice with an input"

    # Use the random library to generate a random number between 1 and 6
    random_number = random.randint(1, 6)

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Print to tell the user what this is about
        print("Please enter a number between 1 and 6 to bet against the dice")

        # Gets the input
        user_input = input("Your bet: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

        # Gets the given number
        given_number = float(user_input)

        # If the number isn't between 1 and 6 inclusive,
        # set the is number variable to false
        if given_number >= 1 or given_number <= 6:
            is_number = False

    # Get whether or not the given number is equal to the random number
    win = int(given_number) == random_number

    # Prints whether the user has won
    print(
        f"The dice value is {random_number}. You {'win' if win else 'lose'}."
    )


def print_readable_day_string() -> None:
    """
    Function to print a readable day string
    from a floating point number of days.
    """

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter the number of days as a decimal: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Gets the number of days from the user input
    number_of_days = float(user_input)

    # The list of functions to get the hours, minutes and seconds
    function_list = [
        lambda x: x * 24,
        lambda x: x * 60,
        lambda x: x * 60
    ]

    # The list to store the data
    data: list[float | int] = []

    # Initialise the temporary variable to store the number of days
    temp_number = number_of_days

    # Iterates over the function list
    for function in function_list:

        # Gets the integer from the floating point number
        int_number = int(temp_number)

        # Adds the integer number to the list
        data.append(int_number)

        # Subtract the integer from the floating point number
        # to get the decimal portion
        decimal_portion = temp_number - int_number

        # Use the function to get the next part of the
        # date using the decimal portion
        temp_number = function(decimal_portion)

    # Add the last number to the list
    data.append(temp_number)

    # Print the readable day string
    print(
        f"""{
            number_of_days
        } days = {
            data[0]
        } days {
            data[1]
        } hours {
            data[2]
        } mins and {
            data[3]
        } secs"""
    )


def calculate_triangle_angles() -> None:
    """
    Function to calculate the angles of a triangle,
    given the length of the 3 sides.
    """

    # The list of variables to store the length of
    # the 3 sides of the triangle
    variables = ["a", "b", "c"]

    # The data dictionary to store the user's input
    data: dict[str, float] = {}

    # Iterates over the variables
    for variable in variables:

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(
                f"""Please enter the length of the side {
                    variable
                } of the triangle: """
            )

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Adds the user's input to the data dictionary
        data[variable] = float(user_input)

    # Gets the variables from the data dictionary
    a = data["a"]
    b = data["b"]
    c = data["c"]

    # Calculate the angle of the sides
    angle_A = math.acos((b ** 2 + c ** 2 - a ** 2) / (2 * b * c))
    angle_B = math.acos((a ** 2 + c ** 2 - b ** 2) / (2 * a * c))
    angle_C = math.acos((a ** 2 + b ** 2 - c ** 2) / (2 * a * b))

    # Prints the angles
    print(f"Angle opposite side a in radians is: {angle_A}")
    print(f"Angle opposite side b in radians is: {angle_B}")
    print(f"Angle opposite side c in radians is: {angle_C}")


def print_bunch_of_variables() -> None:
    "Function to print a bunch of variables"

    # Initialise the variables
    a = 0.1
    b = a + a
    c = a + a + a

    # Prints the variables
    print(f"a is {a}")
    print(f"b is {b}")
    print(f"c is {c}")


def print_the_largest_of_3_numbers(a: float, b: float, c: float) -> None:
    "Function to print the largest of 3 numbers."

    # Creates a list from the 3 numbers
    numbers = [a, b, c]

    # Initialise the largest number to the first number
    largest_number = a

    # Iterates over the list of numbers,
    # skipping the first number
    for number in numbers[1:]:

        # Check if the current number is larger than the largest number
        if number > largest_number:

            # Set the largest number to the current number
            largest_number = number

    # Print the largest number
    print(f"The largest number is {largest_number}")


def qualifies_for_ntu(academic_score: int, aptitude_grade: str) -> bool:
    "Function to check if an applicant qualifies for NTU."

    # The variables to store whether an applicant qualifies for NTU
    is_qualified = academic_score >= 75 and aptitude_grade in ["A", "B", "C"] \
        or academic_score >= 60 and aptitude_grade == "A"

    # Returns the is_qualified variable
    return is_qualified


def print_pay_and_taxes() -> None:
    """
    Function that takes the number of hours worked in one month and then
    prints the gross pay, taxes and net pay.
    """

    # Initialise the basic pay rate
    BASIC_PAY_RATE = 10

    # Initialise the tax rate on the final remaining amount, which is 30%
    REMAINING_AMOUNT_TAX_RATE = 0.3

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input(
            "Please enter the number of hours worked in a month: "
        )

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Gets the number of hours worked in a month from the user input
    number_of_hours_worked = float(user_input)

    # Gets the gross pay
    gross_pay = BASIC_PAY_RATE * number_of_hours_worked

    # Checks if the number of hours is above 160
    # for overtime pay
    if number_of_hours_worked > 160:

        # Sets the gross pay to 1.5 times the current gross pay
        gross_pay = 1.5 * gross_pay

    # Initialise the tax
    tax: float = 0

    # The dictionary to store the tax rates
    tax_rates = {
        1000: 0.1,
        500: 0.2
    }

    # Initialise the remaining amount to the gross pay
    remaining_amount = gross_pay

    # Iterates over the tax rates
    for tax_amount, tax_rate in tax_rates.items():

        # Intialise the initial amount from the previous iteration of the loop
        initial_remaining_amount = remaining_amount

        # Subtract the tax amount from the remaining amount
        remaining_amount = remaining_amount - tax_amount

        # If the remaining amount is negative
        if remaining_amount < 0:

            # Add to the tax with the current tax rate
            # multiplied by the initial remaining amount
            tax += initial_remaining_amount * tax_rate

            # Break the loop
            break

        # Otherwise, add the tax multiplied by the tax amount
        tax += tax_amount * tax_rate

    # If there's any amount remaining
    if remaining_amount > 0:

        # Add the tax on that remaining amount
        tax += REMAINING_AMOUNT_TAX_RATE * remaining_amount

    # Prints the gross pay, taxes and net pay
    print(f"Gross pay: ${gross_pay}")
    print(f"Taxes: ${tax}")
    print(f"Net pay: ${gross_pay - tax}")


def get_numerical_range(a: float, b: float, c: float) -> None:
    "Function to get the numerical range of 3 given numbers"

    # Initialise the list of numbers
    number_list = [a, b, c]

    # Initialise the largest and smallest number to the first number
    largest_number = a
    smallest_number = a

    # Iterates over the list of numbers,
    # skipping the first number
    for number in number_list[1:]:

        # Check if the current number
        # is greater than the largest number
        if number > largest_number:

            # Set the largest number to the current number
            largest_number = number

        # Check if the current number is smaller than the smallest number
        if number < smallest_number:

            # Set the smallest number to the current number
            smallest_number = number

    # Print the numerical range
    # which is the largest number - smallest number
    print(f"Numerical range: {largest_number - smallest_number}")


def compare_birthdays() -> None:
    "Function to compare 2 birthdays and report who is older"

    # Initialise the dictionary to store the data
    data_dict: dict[str, list[float]] = {
        "first person": [],
        "second person": []
    }

    # Parts of the birthday
    birthday_parts = ["day", "month", "year"]

    # Iterates over the data dictionary
    for person, data_list in data_dict.items():

        # Tells the user to input the birthday for the person
        print(f"Enter the {person}'s birthday")

        # Iterates over the parts of the birthday
        for part in birthday_parts:

            # The variable representing whether the input is a number or not
            is_number = False

            # While the input isn't a number
            while not is_number:

                # Gets the input
                user_input = input(
                    f"Please enter the {part} of the birthday as an integer: "
                )

                # Set the is_number variable
                is_number = bool(is_number_regex.match(user_input))

            # Adds the user input, converted to a integer, to the data list
            data_list.append(int(user_input))

    # Gets the first birthday and reverse the list
    # so it's (year, month, day)
    first_birthday = data_dict["first person"][::-1]

    # Gets the second birthday and reverse the list
    # so it's (year, month, day)
    second_birthday = data_dict["second person"][::-1]

    # Check if the first birthday is equal to the second birthday
    if first_birthday == second_birthday:

        # Print that both people have the same birthday
        print("Both individuals have the same birthday.")

    # Otherwise, check if the first birthday is later than the second birthday
    elif first_birthday > second_birthday:

        # Print that the second person is older
        print("The second person is older.")

    # Otherwise, the first birthday is earlier than the second birthday
    else:

        # Print that the first person is older
        print("The first person is older.")


def print_is_leap_year() -> None:
    "Function to take a year and print if the year is a leap year"

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter a year: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Gets the year from the user's input
    year = float(user_input)

    # Set the variable is_leap_year.
    # The right hand side is the boolean expression.
    is_leap_year = year % 4 == 0 and not year % 100 == 0 or year % 400 == 0

    # If the year is a leap year
    if is_leap_year:

        # Print "Leap year"
        print("Leap year")

    # Otherwise
    else:

        # Print "Not leap year"
        print("Not leap year")


def print_day_from_integer_value() -> None:
    "Function to take an integer and print the integer as a day string"

    # The dictionary mapping the day integer to the string
    day_dict = {
        1: "Monday",
        2: "Tuesday",
        3: "Wednesday",
        4: "Thursday",
        5: "Friday",
        6: "Saturday",
        7: "Sunday"
    }

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input("Please enter an integer representing a day: ")

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Set the day to the user's input
    day = int(user_input)

    # Gets the day string from the dictionary
    day_string = day_dict.get(day)

    # If the day string is not None
    if day_string is not None:

        # Print the day string
        print(day_string)

    # Otherwise
    else:

        # Print "Illegal input"
        print("Illegal input")


def find_quadrant_of_coordinates() -> None:
    "Function to get the quadrant from an (x, y) coordinate"

    # The list to store the user's input for the x and y coordinates
    x_y_coordinates: list[float] = []

    # Iterates over the list of axes
    for axis in ["x", "y"]:

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(f"Please enter the {axis} coordinate: ")

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Add the user's input converted to a float to the list of coordinates
        x_y_coordinates.append(float(user_input))

    # Gets the x and y values
    x = x_y_coordinates[0]
    y = x_y_coordinates[1]

    # Check if the x and y values are in the first quadrant
    if x > 0 and y > 0:

        # Print that the coordinates are in the first quadrant
        print("The coordinates are in the first quadrant.")

    # Otherwise, check if the x and y values are in the second quadrant
    elif x < 0 and y > 0:

        # Print that the coordinates are in the second quadrant
        print("The coordinates are in the second quadrant.")

    # Otherwise, check if the x and y values are in the third quadrant
    elif x < 0 and y < 0:

        # Print that the coordinates are in the third quadrant
        print("The coordinates are in the third quadrant.")

    # Otherwise, check if the x and y values are in the fourth quadrant
    elif x > 0 and y < 0:

        # Print that the coordinates are in the fourth quadrant
        print("The coordinates are in the fourth quadrant.")

    # Otherwise, check if the x value is 0
    elif int(x) == 0:

        # Print that the coordinates are on the x-axis
        print("The coordinates are on the x-axis.")

    # Otherwise, check if the y value is 0
    elif int(y) == 0:

        # Print that the coordinates are on the x-axis
        print("The coordinates are on the y-axis.")


def print_numbers(join_string: str = " ") -> None:
    """
    Function to print the numbers 1 to 12 on one line
    and the numbers 13 to 24 on another line.
    """

    # Initialise the list to print the first line
    first_line = []

    # Initialise the list to print the second line
    second_line = []

    # Iterates over all the numbers
    for number in range(24 + 1):

        # If the number is less than or equal to 12
        if number <= 12:

            # Adds the number to the first line
            first_line.append(str(number))

        # Otherwise
        else:

            # Adds the number to the second line
            second_line.append(str(number))

    # Prints the first and second line with the numbers
    # joined by the joining string
    print(join_string.join(first_line))
    print(join_string.join(second_line))


def rewrite_for_loop_as_while_loop(X: int) -> None:
    """
    Function that iterates from 1 to the given X value
    and prints the numbers that X is divisible by.
    """

    # Initialise i to 0
    i = 0

    # Iterate over the numbers until X
    while i < X + 1:

        # Increment i by 1
        i += 1

        # If X is divisible by the current number
        if X % i == 0:

            # Prints the current number
            print(i)


def mathematical_sum_1(n: int) -> float:
    """
    Function to calculate the sum of the mathematical expression below:
    from i = 1 to n, sum (1/i + 1)
    """

    # Initialise the sum variable to 0
    sum: float = 0

    # Iterates from 1 to n
    for i in range(1, n + 1):

        # Adds 1/i + 1 to the sum
        sum += 1/i + 1

    # Return the sum
    return sum


def mathematical_sum_2(n: int) -> int:
    """
    Function to calculate the sum of the mathematical expression below:
    from i = 1 to n, sum (i + (from j = 0 to i, sum j))
    """

    # Initialise the sum variable to 0
    sum = 0

    # Iterates from 1 to n
    for i in range(1, n + 1):

        # Adds the current number to the sum
        sum += i

        # Iterates from 0 to the current number i
        for j in range(i + 1):

            # Add the current number j to the sum
            sum += j

    # Returns the sum
    return sum


def print_numbers_less_than_1000_divisible_by_29() -> None:
    """
    Function to print all the numbers less than 1000
    that are divisible by 29
    """

    # The list of strings to store the numbers to print
    str_list: list[str] = []

    # Iterates from 0 to 999
    for number in range(0, 1000):

        # Checks if the number is divisible by 29
        if number % 29 == 0:

            # Adds the number as a string to the string list
            str_list.append(str(number))

    # Print the list of numbers
    print("\n".join(str_list))


def calculate_eulers_number(number_of_decimal_places: int = 8) -> float:
    "Function to calculate euler's number to a given number of decimal places"

    # Initialise euler's number
    eulers_number: float = 0

    # Initialise the i variable
    i = 0

    # Starts an infinite loop
    while True:

        # Gets the current term
        term = 1 / math.factorial(i)

        # If the value of the current term is less than
        # 10 to the power of the negative of the number of decimal places
        if abs(term) < 10 ** (-number_of_decimal_places):

            # Break out of the loop
            break

        # Otherwise, add the term to euler's number
        eulers_number += term

        # Increase i by 1
        i += 1

    # Return euler's number rounded to the number of decimal places needed
    return round(eulers_number, number_of_decimal_places)


def print_leap_years_between(start_year: int, end_year: int) -> None:
    "Function to print all the leap years between a start and end year."

    # Initialise the list of strings to print
    str_list: list[str] = []

    # Iterates over all the years from the start to the end year
    for year in range(start_year, end_year + 1):

        # Get whether the year is a leap year or not
        is_leap_year = year % 4 == 0 and not year % 100 == 0 or year % 400 == 0

        # If the year is a leap year
        if is_leap_year:

            # Add the year to the list as a string
            str_list.append(str(year))

    # Split the list of strings into groups of 8

    # Gets the length of the list of strings
    str_list_len = len(str_list)

    # Get the number of groups of 8
    number_of_groups = str_list_len // 8

    # Iterates over the number of groups
    for group_number in range(1, number_of_groups + 1):

        # Gets the slice of the string list that is a group of 8
        str_list_slice = str_list[(group_number - 1)*8:group_number*8]

        # Prints the slice joined with a comma and a space
        print(", ".join(str_list_slice))

    # Get the remaining years
    remaining_years = str_list[number_of_groups*8:]

    # Print the remaining years
    print(", ".join(remaining_years))


def generate_sgd_rm_conversion_tables() -> None:
    "Function to generate the SGD to RM and RM to SGD conversion table"

    # The conversion rate
    SGD_TO_RM_CONVERSION_RATE = 3.03

    # The list to store the user's input
    data: list[int] = []

    # The list of prompts
    prompts = ["start", "end", "increment (step)"]

    # Iterates over the prompts
    for prompt in prompts:

        # The variable representing whether the input is a number or not
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(f"Please enter the {prompt} value: ")

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Adds the user's input to the list
        data.append(int(user_input))

    # Initialise the list of strings to print
    str_list = ["SGD to RM Table"]

    # Initialise the values to the values given by the user
    start_value = data[0]
    end_value = data[1]
    increment = data[2]

    # Iterates from the start to the end value with an increment,
    # all of which are given by the user
    for dollar_amount in range(start_value, end_value + 1, increment):

        # Convert the dollar amount to RM
        dollar_amount_in_rm = SGD_TO_RM_CONVERSION_RATE * dollar_amount

        # Adds the information to the string list to be printed
        str_list.append(f"S${dollar_amount} : RM{dollar_amount_in_rm}")

    # Add an empty string to the string list.
    # This will be a double newline so there's some spacing between
    # the SGD to RM table and the RM to SGD table
    str_list.append("")

    # Add the header for the RM to SGD table
    str_list.append("RM to SGD table")

    # Initialise the RM amount to the start value
    rm_amount = start_value

    # Iterates while the RM amount is less than the end value
    while rm_amount <= end_value:

        # Get the dollar amount from the amount in RM
        rm_amount_in_dollar = rm_amount / SGD_TO_RM_CONVERSION_RATE

        # Adds the information to the string list to be printed
        str_list.append(f"RM{rm_amount} : S${rm_amount_in_dollar}")

        # Increase the RM amount by the increment
        rm_amount += increment

    # Prints the list of strings joined with a new line character
    print("\n".join(str_list))


def print_triangular_pattern_of_lines() -> None:
    """
    Function to take a height from a user and print a triangular pattern
    of AAs and BBs.
    """

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input(
            "Please enter the height of the triangular pattern: "
        )

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Gets the height of the triangle
    height = int(user_input)

    # The list of strings to print
    str_list: list[str] = []

    # Iterate until the height given
    for i in range(1, height + 1):

        # Gets the quotient and remainder
        # of the number divided by 2
        quotient, remainder = divmod(i, 2)

        # Gets the string at the start
        start_string = "AA" if remainder == 1 else ""

        # Creates the string and add it to the list
        str_list.append(f"{start_string}{'BBAA' * quotient}")

    # Prints the triangular pattern
    print("\n".join(str_list))


def prompt_string_and_print_ascii() -> None:
    """
    The function to prompt the user for a string
    and print the ASCII value of each character in the string
    """

    # Asks the user for an input
    user_input = input("Please enter a string: ")

    # The list of ASCII values
    ascii_values = [str(ord(char)) for char in user_input]

    # Prints the ASCII values
    print(*ascii_values)


def print_multiplication_table() -> None:
    "Function to print the multiplication table from 1 to 12"

    # Initialise the list of strings to print
    str_list: list[str] = []

    # The number range
    number_range = range(1, 12 + 1)

    # Iterates over the numbers
    for first_number in number_range:

        # Adds an empty string to the list for a new line
        str_list.append("")

        # Add the header for the multiplication table
        str_list.append(f"Multiplication table for {first_number}")

        # Iterates over the number range again
        for second_number in number_range:

            # Gets the result of the multiplication
            result = first_number * second_number

            # Adds the multiplication to the list
            str_list.append(f"{first_number} x {second_number} = {result}")

    # Prints the multiplication table joined by new lines
    print("\n".join(str_list))


def all_vowels_present(string: str) -> bool:
    "The function to check if all the vowels are present in the string"

    # The set of all vowels
    vowels = {"a", "e", "i", "o", "u"}

    # Initialise an empty set to store the vowels in the string
    vowels_in_str = set()

    # Iterates over the characters in the string
    for char in string:

        # If the current character, changed to lowercase, is a vowel
        if char.lower() in vowels:

            # Add the character to the set of vowels in the string
            vowels_in_str.add(char)

    # Returns if the set of vowels in the string has the same length
    # as the set of vowels
    return len(vowels_in_str) == len(vowels)


def print_sentence_stats() -> None:
    """
    Function to print out the number of
    words, upper case letters, lower case letters, digits and other characters.
    """

    # Initialise all the variables to store the information required
    number_of_words = 0
    number_of_uppercase = 0
    number_of_lowercase = 0
    number_of_digits = 0
    number_of_other_chars = 0

    # Get the user's input
    user_input = input("Please enter a sentence: ")

    # Iterate over all of the characters of the string
    for char in user_input:

        # Check if the character is an uppercase letter
        if char.isupper():

            # Increment the uppercase letter count by 1
            number_of_uppercase += 1

        # Otherwise, check if the character is a lowercase letter
        elif char.islower():

            # Increment the lowercase letter count by 1
            number_of_lowercase += 1

        # Otherwise, check if the character is a digit
        elif char.isdigit():

            # Increment the digit count by 1
            number_of_digits += 1

        # Otherwise
        else:

            # Increment the count of other characters by 1
            number_of_other_chars += 1

            # If the character is a space character
            if char.isspace():

                # Increment the word count
                number_of_words += 1

    # If the number of words is not zero, increment its count by 1.
    # This is because the number of spaces is always 1 less than the number
    # of words, due to the spaces being the separator between words.
    number_of_words = number_of_words + 1 if number_of_words != 0 else 0

    # The list of strings to print out
    str_list = [
        f"Number of words: {number_of_words}",
        f"Number of uppercase letters: {number_of_uppercase}",
        f"Number of lowercase letters: {number_of_lowercase}",
        f"Number of digits: {number_of_digits}",
        f"Number of other characters: {number_of_other_chars}",
    ]

    # Print the list of strings joined by a new line character
    print("\n".join(str_list))


def encrypt_given_string() -> None:
    "A function to ask the user for a string and encrypt it"

    # Gets the user's input
    user_input = input("Please enter a message you want to encrypt: ")

    # Initialise the list of characters
    list_of_chars: list[str] = []

    # Iterates over the user's input
    for char in user_input:

        # If the character is not a digit or a letter
        if not char.isalnum():

            # Add the character to the list of characters
            list_of_chars.append(char)

            # Continue the loop
            continue

        # Otherwise, check if the character is uppercase
        if char.isupper():

            # Gets the number of the encrypted character
            # 65 is because uppercase A is 65,
            # so subtracting 64 will make uppercase A 0
            new_ordinal = (ord(char) - 65 + 5) % 26 + 65

            # The new character
            new_char = chr(new_ordinal)

        # Otherwise, check if the character is lowercase
        elif char.islower():

            # Gets the number of the encrypted character
            # 97 is because lowercase a is 97,
            # so subtracting 97 will make lowercase a 0
            new_ordinal = (ord(char) - 97 + 5) % 26 + 97

            # The new character
            new_char = chr(new_ordinal)

        # Otherwise, the character is a digit
        else:

            # Gets the number of the encrypted digit
            new_number = (int(char) + 3) % 9

            # The new character
            new_char = str(new_number)

        # Add the new character to the list of characters
        list_of_chars.append(new_char)

    # Prints the encrypted string
    print("".join(list_of_chars))


def is_valid_python_variable() -> None:
    """
    A function to print 'valid' if the given string is a valid Python variable
    name and 'invalid' otherwise.
    """

    # Gets the user's input and strips it
    user_input = input("Please enter a variable name: ").strip()

    # If the user's input is empty, print "Invalid" and exit the function
    if len(user_input) == 0:
        return print("Invalid")

    # The list of ordinals for the numbers
    number_ordinals = [i for i in range(ord("0"), ord("9") + 1)]

    # The list of ordinals for the alphabets
    alphabet_ordinals = [i for i in range(ord("A"), ord("z") + 1)]

    # The set containing the ordinals of all the accepted characters
    # for a Python variable
    valid_char_ordinals = set(number_ordinals + alphabet_ordinals + [ord("_")])

    # If the first character of the string is a digit or special character,
    # print "Invalid" and exit the function
    if (
        (first_char := user_input[0]).isdigit()
        or ord(first_char) not in valid_char_ordinals
    ):
        return print("Invalid")

    # Otherwise, iterate over the string
    for char in user_input:

        # If the ordinal of the character isn't in the set of valid characters,
        # print "Invalid" and exit the function
        if ord(char) not in valid_char_ordinals:
            return print("Invalid")

    # Print "Valid"
    print("Valid")


def calculate_circumference_and_area_of_circle() -> None:
    """
    The function to calculate the circumference and the area of a circle,
    given the radius.
    """

    # The variable representing whether the input is a number or not
    is_number = False

    # While the input isn't a number
    while not is_number:

        # Gets the input
        user_input = input(
            "Please enter the radius of the circle: "
        )

        # Set the is_number variable
        is_number = bool(is_number_regex.match(user_input))

    # Set the radius of the circle to the user's input
    radius = float(user_input)

    # Calculate the circumference and the radius of the circle
    circumference = 2 * math.pi * radius
    area = 2 * math.pi * radius ** 2

    # Print the calculations
    print(
        f"Radius of circle = {radius:.2f}, {circumference = :.2f}, {area = :.2f}"
    )


def is_valid_python_variable_with_keywords_and_reason() -> None:
    """
    A function to print 'valid' if the given string is a valid Python variable
    name and 'invalid' otherwise. This accounts for Python keywords and gives
    a reason for the variable name being invalid.
    """

    # Gets the user's input and strips it
    user_input = input("Please enter a variable name: ").strip()

    # If the user's input is empty, print "Invalid" and exit the function
    if len(user_input) == 0:
        return print("Invalid. Reason: Empty string.")

    # The set of Python keywords
    python_keywords = {
        "and",
        "as",
        "assert",
        "break",
        "class",
        "continue",
        "def",
        "del",
        "elif",
        "else",
        "except",
        "False",
        "finally",
        "for",
        "from",
        "global",
        "if",
        "import",
        "in",
        "is",
        "lambda",
        "None",
        "nonlocal",
        "not",
        "or",
        "pass",
        "raise",
        "return",
        "True",
        "try",
        "while",
        "with",
        "yield",
    }

    # If the user's input is a keyword, print "Invalid" and exit the function
    if user_input in python_keywords:
        return print("Invalid. Reason: The name is a Python keyword.")

    # The list of ordinals for the numbers
    number_ordinals = [i for i in range(ord("0"), ord("9") + 1)]

    # The list of ordinals for the alphabets
    alphabet_ordinals = [i for i in range(ord("A"), ord("z") + 1)]

    # The set containing the ordinals of all the accepted characters
    # for a Python variable
    valid_char_ordinals = set(number_ordinals + alphabet_ordinals + [ord("_")])

    # If the first character of the string is a digit,
    # print "Invalid" and the reason and exit the function
    if user_input[0].isdigit():
        return print(
            "Invalid. Reason: Python variables cannot start with numbers."
        )

    # Otherwise, iterate over the string
    for char in user_input:

        # If the ordinal of the character isn't in the set of valid characters,
        # print "Invalid" and the reason and exit the function
        if ord(char) not in valid_char_ordinals:
            return print(
                f"Invalid. Reason: {char} is not allowed in "
                "Python variable names."
            )

    # Print "Valid"
    print("Valid")


def print_list_of_numbers_as_matrix(list_of_list: list[list[float]]) -> None:
    """
    Function to print a list of list as a matrix.
    It also prints its transpose.
    """

    # The list of strings to print for the matrix
    matrix_str_list: list[str] = []

    # The list of strings to print for the matrix transpose
    transpose_str_list: list[str] = ["" for i in range(len(list_of_list))]

    # Iterates over the list
    for row in list_of_list:

        # The list of strings for the row
        row_str_list: list[str] = []

        # Iterates over the numbers in the row
        for index, number in enumerate(row):

            # Add the number to the list of strings for the row
            row_str_list.append(str(number))

            # Add the number to the transpose at the index
            transpose_str_list[index] += f"{str(number)} "

        # Add the row to the matrix string list joined by spaces
        matrix_str_list.append(" ".join(row_str_list))

    # Prints the matrix
    print("\n".join(matrix_str_list))

    # Print a new line
    print()

    # Print the transpose
    print("\n".join(string.strip() for string in transpose_str_list))


def convert_date_to_list(short_date: str) -> list[int]:
    "Function to convert a date 'dd/mm/yyyy' to a list [dd, mm, yyyy]"
    return [int(date_part) for date_part in short_date.split("/")]


def print_long_date(short_date: str) -> None:
    """
    Function to print the long date format 'dd Month, yyyy' from the
    short date format 'dd/mm/yyyy'
    """

    # The month dictionary
    month_dict = {
        1: "January",
        2: "February",
        3: "March",
        4: "April",
        5: "May",
        6: "June",
        7: "July",
        8: "August",
        9: "September",
        10: "October",
        11: "November",
        12: "December",
    }

    # Convert the date to a list and grab the date, month and year
    date, month, year = [int(date_part) for date_part in short_date.split("/")]

    # Gets the long month from the month
    long_month = month_dict[month]

    # Prints the date in the long date format
    print(f"{date} {long_month}, {year}")


def add_two_vectors(vec_1: list[float], vec_2: list[float]) -> list[float]:
    "Function to add two vectors together"

    # Returns the sum of the two vectors
    return [vec_1[i] + vec_2[i] for i in range(len(vec_1))]


def dot_product_vec(vec_1: list[float], vec_2: list[float]) -> float:
    "Function to get the dot product of two vectors"

    # Returns the dot product of the two vectors
    return sum(vec_1[i] * vec_2[i] for i in range(len(vec_1)))


def print_words_of_a_given_input() -> None:
    "Function to print all the words in a given input, separated by new lines"

    # Gets the user's input
    user_input = input("Please enter a sentence: ").strip()

    # Replace all the punctuation marks with a space
    user_input = re.sub(punctuation_regex, " ", user_input)

    # Splits the string using spaces
    splitted_string = user_input.split()

    # Print all the words joined by new lines
    print("\n".join(splitted_string))


def print_words_of_a_given_input_no_split() -> None:
    """
    Function to print all the words in a given input, separated by new lines,
    but this time without using the str.split function.
    """

    # The set of all punctuation
    punctuation_set = set(".,?!;:'\"()[]{}-")

    # Gets the user's input
    user_input = input("Please enter a sentence: ").strip()

    # Gets the length of the user's input
    input_len = len(user_input)

    # The list of words to print
    word_list: list[str] = []

    # The variable to store the position of the last word
    previous_word_index = 0

    # Iterates over the characters in the input
    for index, char in enumerate(user_input):

        # If the character is punctuation or a space
        if char.isspace() or char in punctuation_set:

            # Gets the word
            word = user_input[previous_word_index:index]

            # Adds the word to the list of words
            # if the word isn't an empty string
            word_list.append(word.strip()) if len(word) > 0 else None

            # Update the previous word index to the current index + 1
            # if the index is less than the length of the input
            previous_word_index = (index + 1
                                   if index + 1 < input_len
                                   else input_len - 1)

    # Adds the last word to the list
    word_list.append(user_input[previous_word_index:])

    # Print the list of words joined with a new line character
    print("\n".join(word_list))


def is_leap_year(year: int) -> bool:
    "The function to return if a year is a leap year"
    return year % 4 == 0 and not year % 100 == 0 or year % 400 == 0


def print_sum_of_two_vectors() -> None:
    """
    Function to read in 2 vectors and print their sum.
    """

    # Initalise the list to store the vectors
    vec_list: list[list[float]] = []

    # Iterates over the number of vectors, which is 2
    for vec_num in range(1, 3):

        # Initialise the vector
        vec: list[float] = []

        # Iterates over the coordinates for the vector
        for nth_coord in range(1, 3):

            # Initialise the is_number variable to False
            is_number = False

            # While the input isn't a number
            while not is_number:

                # Gets the input
                user_input = input(
                    f"Please enter the {nth_coord} coordinate "
                    f"for vector {vec_num}: "
                )

                # Set the is_number variable
                is_number = bool(is_number_regex.match(user_input))

            # Adds the user's input to the vector
            vec.append(float(user_input))

        # Adds the vector to the list of vectors
        vec_list.append(vec)

    # Adds the two vectors together and print the result
    print(add_two_vectors(*vec_list))


def calculate_horizontal_distance_of_projectile_motion(
    velocity: float,
    height: float,
    angle: float
) -> float:
    """
    A function to calculate the horizontal distance of projectile motion

    The velocity is the velocity of the projectile at launch.
    The height is the initial height of the projectile.
    The theta is the angle at which the projectile is launched in radians.
    """

    # Set the gravitational constant g
    g = 9.81

    # Gets the distance using the mathematical equation
    distance = (velocity ** 2 / (2 * g)) * \
        (1 + (1 + (
            (2 * g * height) / (velocity ** 2 * (math.sin(angle) ** 2))
        )) ** 0.5) * math.sin(angle * 2)

    # Returns the distance
    return distance


def print_horizontal_distance_of_projectile_motion() -> None:
    """
    A function to read the velocity, height and angle of projectile motion
    from the user and print the horizontal distance.
    """

    # The list of variables to store
    variable_list = ("velocity", "height", "angle in radians")

    # The list to store the user's input
    data: list[float] = []

    # Iterates over all the variables
    for variable in variable_list:

        # Initialise the is_number variable to False
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(
                f"Please enter the {variable} of projectile motion: "
            )

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Add the user's input to the list as a float
        data.append(float(user_input))

    # Calculate the horizontal distance
    distance = calculate_horizontal_distance_of_projectile_motion(*data)

    # Prints the distance
    print(f"The horizontal distance is {distance} m.")


def roll_dice() -> int:
    "Function to simulate the rolling of a dice"
    return random.randint(1, 6)


def sum_of_three_rolls() -> tuple[int, bool]:
    """
    Function to sum 3 rolls of the dice, and return the sum.

    It also returns whether the 3 rolls are the same.
    """

    # Gets the list of rolls
    rolls = [roll_dice() for i in range(3)]

    # Gets the sum of the 3 rolls
    sum_of_rolls = sum(rolls)

    # Gets whether the 3 rolls are equal
    three_rolls_are_equal = rolls.count(rolls[0]) == len(rolls)

    # Returns the sum of the 3 rolls and whether the 3 rolls are equal
    return (sum_of_rolls, three_rolls_are_equal)


def dice_game() -> None:
    """
    A function to play a dice game.

    The function prints 'Jackpot' if all the dice rolls are the same,
    'Big' if the sum of the dice rolls is 11 and above,
    'Small' if the sum of the dice rolls is 10 and below.
    """

    # Gets the sum of the 3 rolls and if the three rolls are equal
    sum_of_rolls, three_rolls_are_equal = sum_of_three_rolls()

    # If the three rolls are equal
    if three_rolls_are_equal:

        # Print "Jackpot"
        print("Jackpot")

    # Otherwise, if the sum is greater or equal to 11
    elif sum_of_rolls >= 11:

        # Print "Big"
        print("Big")

    # Otherwise
    else:

        # Print "Small"
        print("Small")


def number_of_days_from_jan_1_2023() -> None:
    """
    Function to return the number of days that have passed
    since January 1st 2023.
    """

    # The list of variables
    variables = ("day of the month", "month")

    # The list of the number of days in a specific month
    num_of_days_in_month_list = [
        31,
        28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
    ]

    # The list to store the user's input
    data: list[int] = []

    # Iterates over the variables
    for variable in variables:

        # Initialise the is_number variable to False
        is_number = False

        # While the input isn't a number
        while not is_number:

            # Gets the input
            user_input = input(
                f"Enter the {variable}: "
            )

            # Set the is_number variable
            is_number = bool(is_number_regex.match(user_input))

        # Add the user's input to the list
        data.append(int(user_input))

    # Get the day of the month and the month
    day_of_the_month = data[0]
    month = data[1]

    # Get the number of days from the start of the year
    num_of_days = sum(num_of_days_in_month_list[:month - 1]) + day_of_the_month

    # Print the number of days elapsed
    print(
        "The number of days elapsed from 1/1/2023 to "
        f"{day_of_the_month}/{month}/2023 is {num_of_days}"
    )


def add_income(
    revenue: dict[str, float], shop: str, income: float | int
) -> None:
    "Function to add the income of a shop to the revenue dictionary"

    # Change the income to a floating point number
    income = float(income)

    # If the shop is already inside the revenue dictionary
    if revenue.get(shop) is not None:

        # Add the shop's income to the revenue
        revenue[shop] += income

    # Otherwise
    else:

        # Add the shop to the revenue dictionary
        revenue[shop] = income


def add_shops_to_revenue_dict() -> None:
    "A function to add multiple shops to the revenue dictionary"

    # The revenue dictionary
    revenue = {"Jurong": 1620.55, "Bedok": 2598.60, "Sengkang": 1886.40}

    # Add the income of a shop called "Punggol"
    add_income(revenue, "Punggol", 3000)

    # Add the income of a shop named "Tanjong Pagar"
    add_income(revenue, "Tanjong Pagar", 42069)

    # Add the income of the Jurong shop
    add_income(revenue, "Jurong", 6969.42069)

    # Print the revenue dictionary
    print(revenue)


def check_digit(string: str, index: int = -1) -> bool:
    """
    Function to check if the character at the given index is a digit.
    If the index is not given, it defaults to the last character of the string.
    """

    # If the index is greater than the length of the string - 1,
    # return False immediately
    if index > len(string) - 1:
        return False

    # Returns if the character at the given index is a digit
    return string[index].isdigit()


def area(
    base_or_radius: float,
    height: float = 1.0,
    shape: str = "cir"
) -> float | None:
    """
    Function to get the area of a shape.
    If the shape is not given, it defaults to a circle.
    """

    # The dictionary mapping the shape to the area calculation
    area_dict = {
        "cir": math.pi * (base_or_radius ** 2),
        "rect": base_or_radius * height,
        "tri": base_or_radius * height * (1 / 2)
    }

    # Returns the area calculation
    return area_dict.get(shape)


def insert_into_birthday_dict(
    birthday_dict: dict[str, tuple[str, str, str]],
    ic_number: str,
    birthday_tuple: tuple[str, str, str]
) -> None:
    """
    Function to insert an IC number and the corresponding birthday
    into the birthday dictionary.
    """

    # If the birthday dictionary doesn't already contain the IC number,
    # add the birthday to the dictionary
    if birthday_dict.get(ic_number) is not None:
        birthday_dict[ic_number] = birthday_tuple

    # Otherwise, don't do anything


def check_birthday_in_birthday_dict(
    birthday_dict: dict[str, tuple[str, str, str]],
    ic_number: str,
    birthday_tuple: tuple[str, str, str]
) -> int:
    """
    Function to check if the IC number and the birthday matches up
    in the birthday dictionary.

    The function returns 1 if the IC number exists and the birthday is the
    same as in the dictionary.

    The function returns 2 if the IC number doesn't exist.

    The function returns 3 if the IC number exists but the birthday
    is different.
    """

    # Gets the birthday tuple from the dictionary
    stored_birthday_tuple = birthday_dict.get(ic_number)

    # If the IC number is not found, then return 2
    if stored_birthday_tuple is None:
        return 2

    # Otherwise, return 1 if the birthday tuple matches up with the given one
    # and return 3 if the birthday tuple doesn't match up with the given one
    return 1 if birthday_tuple == stored_birthday_tuple else 3


def exchange_amount(amount: float, rate: float, mode: bool = True) -> float:
    """
    Function to exchange money between SGD and RM.

    amount is the amount of money to be exchanged.

    rate is the amount in RM for 1 SGD

    mode is a boolean indicating whether the function should convert from
    SGD to RM or from RM to SGD. The default is converting from RM to SGD.
    """

    # Rename the mode to to_sgd
    to_sgd = mode

    # Returns the exchanged amount
    return amount / rate if to_sgd else amount * rate


def open_file_with_user_input() -> None:
    "A function to open a file with the user's input"

    # Initialise the is_valid_file variable
    is_valid_file = False

    # Iterates while the file isn't valid
    while not is_valid_file:

        # Get the user's input
        user_input = input("Please enter a file name: ")

        # Set the is_valid_file variable
        is_valid_file = os.path.isfile(user_input)

        # Open the file if the file is valid
        if is_valid_file:
            MyFile = open(user_input)


def copy_text_to_another_file_and_uppercase_it(
    original_file_name: str,
    output_file_name: str,
) -> None:
    """
    A function to copy text in a file
    to another file and uppercase the characters.
    """

    # If the original file doesn't exist, print that it doesn't exist
    # and exit the function
    if not os.path.isfile(original_file_name):
        return print("The file name given doesn't exist")

    # Otherwise, open the original file in read mode
    with open(original_file_name, "r") as original_file:

        # Get all the text in the file and uppercase it
        uppercased_text = original_file.read().upper()

    # Open the output file in write mode
    with open(output_file_name, "w") as output_file:

        # Write the uppercased text to the output file
        output_file.write(uppercased_text)


def copy_text_to_another_file_and_add_line_numbers(
    original_file_name: str,
    output_file_name: str
) -> None:
    """
    A function to copy text in one file and prefix every line
    of the new file with a line number that starts from 1.
    """

    # If the original file doesn't exist, print that it doesn't exist
    # and exit the function
    if not os.path.isfile(original_file_name):
        return print("The file name given doesn't exist")

    # Otherwise, open the original file in read mode
    with open(original_file_name, "r") as original_file:

        # Get the lines in the file
        lines = original_file.readlines()

    # Open the output file in write mode
    with open(output_file_name, "w") as output_file:

        # Write all the lines prefixed with the line number
        # to the output file
        output_file.writelines(
            f"{i + 1} {line}" for i, line in enumerate(lines)
        )


def print_reciprocal_of_numbers() -> None:
    """
    Function that prints the reciprocal of integers from -10 to 10.
    Print 'Infinity' if the integer is 0.
    """

    # Iterates from -10 to 10
    for i in range(-10, 11):

        # If the number is zero, print "Infinity"
        if i == 0:
            print("Infinity")

        # Otherwise, print the reciprocal of the number
        else:
            print(1 / i)


def print_reciprocal_of_numbers_using_try_except() -> None:
    """
    Function that prints the reciprocal of integers from -10 to 10.
    Print 'Infinity' if the integer is 0.
    This function uses the try except block to catch the
    zero division error.
    """

    # Iterates from -10 to 10
    for i in range(-10, 11):

        # Try to print the reciprocal of the nummber
        try:
            print(1 / i)

        # Catch the zero division error
        # and print infinity
        except ZeroDivisionError:
            print("Infinity")


def write_ascii_table_to_file() -> None:
    "Function to write the ASCII table to file"

    # The string list containing the table
    ascii_table: list[str] = []

    # The header of the table
    header = "| No. | ASCII value | Character |"

    # Adds the header to the ASCII table
    ascii_table.append(header)

    # Add the separator to the ASCII table
    ascii_table.append("-" * len(header))

    # Iterates from 32 (the first printable ASCII character, " ") until 255
    for i in range(32, 256):

        # Gets the index of the row
        index = i - 31

        # Adds the required information to the table
        ascii_table.append(f"|{index:^5}|{i:^13}|{chr(i):^11}|")

    # Write the ASCII table to a file called ASCIITable.txt
    with open("ASCIITable.txt", "w") as file:
        file.write("\n".join(ascii_table))


def pretty_print_car_test_results() -> None:
    """
    Function to read a file called CarTest.txt
    and then print out the result in a nice table form.
    """

    # The file name of the car test results
    file_name = "CarTest.txt"

    # If the file doesn't exist, tells the user that it doesn't exist
    if not os.path.exists(file_name):
        return print(f"{file_name} doesn't exist!")

    # Otherwise, open the file to read the car test results
    with open(file_name, "r") as file:

        # Gets the lines in the file
        lines = file.readlines()

    # The table to display the car test results
    results_table: list[str] = []

    # The list of headers for the table
    headers = [
        "Test number",
        "Fuel consumed in litres",
        "Distance travelled in km",
        "Consumption rate in km/litres"
    ]

    # The header line
    header_line = f"| {' | '.join(headers)} |"

    # Add the header line to the results table
    results_table.append(header_line)

    # Add the separator to the table line
    results_table.append("-" * len(header_line))

    # Iterate over each of the lines
    for line in lines:

        # Gets the splitted line
        splitted_line = line.split()

        # If the length of the splitted line list is not 3,
        # continue the loop
        if len(splitted_line) != 3:
            continue

        # Gets the test results
        test_num, fuel_consumed, distance_travelled = splitted_line

        # Calculate the consumption rate
        consumption_rate = float(distance_travelled) / float(fuel_consumed)

        # Add the information to the table
        results_table.append(
            f"| {test_num:^11} |"
            f" {fuel_consumed:^23} |"
            f" {distance_travelled:^24} |"
            f" {consumption_rate:^29} |"
        )

    # Prints the results table
    print("\n".join(results_table))


def convert_integer_to_words(supposed_integer: str) -> str | None:
    "The function to convert integers to words"

    # Initialise the variable to store the string "negative"
    # for negative numbers.
    # This variable will be empty if the number is positive
    negative_str = ""

    # If the integer given is negative
    if supposed_integer.startswith("-"):

        # Set the negative_str variable to "negative" with a space behind
        negative_str = "negative "

        # Remove the dash from the start of the string
        supposed_integer = supposed_integer.replace("-", "", 1)

    # If the string given is not an integer, return None
    if not supposed_integer.isdecimal():
        return None

    # If the integer is 0, then return the word "zero"
    if supposed_integer == "0":
        return "zero"

    # Otherwise, convert the given integer to an integer
    integer = int(supposed_integer)

    # Create the dictionary mapping the numbers to the words
    number_to_word_dict = {
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        10: "ten",
        11: "eleven",
        12: "twelve",
        13: "thirteen",
        14: "fourteen",
        15: "fifteen",
        16: "sixteen",
        17: "seventeen",
        18: "eighteen",
        19: "nineteen",
        20: "twenty",
        30: "thirty",
        40: "forty",
        50: "fifty",
        60: "sixty",
        70: "seventy",
        80: "eighty",
        90: "ninety",
        100: "hundred and",
        10 ** 3: "thousand",
        10 ** 6: "million",
        10 ** 9: "billion",
        10 ** 12: "trillion",
    }

    # The tuple of the powers of 10
    powers_of_10 = (12, 9, 6, 3, 2, 1)

    # The length of the power of 10 tuple
    powers_of_10_len = len(powers_of_10)

    def convert_int_to_words(
        integer: int,
        power_of_10_index: int
    ) -> str:
        "The actual function to convert the integer to words"

        # If the integer given is inside the dictionary, return it immediately
        if (num_in_words := number_to_word_dict.get(integer)) is not None:
            return num_in_words if integer < 100 else f"one {num_in_words}"

        # If the index is greater or equal to the length of the
        # list of powers of 10, then return an empty string
        elif power_of_10_index >= powers_of_10_len:
            return ""

        # Get the current power of 10
        power_of_10 = powers_of_10[power_of_10_index]

        # Get the quotient and the remainder
        quotient, remainder = divmod(integer, 10 ** power_of_10)

        # Initialise the quotient and remainder strings
        quotient_str = ""
        remainder_str = ""

        # If the quotient is greater than 0
        if quotient > 0:

            # If the power of 10 is 1
            if power_of_10 == 1:

                # Gets the quotient string
                quotient_str = number_to_word_dict.get(
                    quotient * 10 ** power_of_10, ""
                )

            # Otherwise
            else:

                # Gets the quotient string and join it with the
                # string for the power of 10
                quotient_str = (convert_int_to_words(
                    quotient, power_of_10_index + 1
                ) + " " + number_to_word_dict.get(
                    10 ** power_of_10, ""
                )).strip()

        # If the remainder is greater than 0
        if remainder > 0:

            # Gets the remainder string
            remainder_str = convert_int_to_words(
                remainder, power_of_10_index + 1
            )

        # Returns the quotient string and the remainder string
        # joined with a space
        return f"{quotient_str} {remainder_str}".strip()

    # Get the result of the convert_int_to_words function
    result = f"{negative_str}{convert_int_to_words(integer, 0)}"

    # If the result ends with "and" with a space in front, then remove it
    if result.endswith(" and"):
        result = result[:-4]

    # Return the result
    return result


def convert_integer_file_to_words() -> None:
    """
    Function to convert a file containing integers to have words instead.
    This function will make a copy of the original file.
    """

    # The file name of the file containing integers
    file_name = "integers.txt"

    # If the file doesn't exist, then print an error and exit the function
    if not os.path.exists(file_name):
        return print(f"{file_name} doesn't exist")

    # Open the file
    with open(file_name, "r") as file:
        lines = file.readlines()

    # The list of strings to write to the new file
    str_list: list[str] = []

    # Iterate over the lines in the file
    for line in lines:

        # Strip the line
        line = line.strip()

        # Convert the integer on the line to a word
        integer_as_word = convert_integer_to_words(line)

        # If the convert integer to words function failed
        if integer_as_word is None:

            # Add an error message to the string list
            str_list.append(f"{line} is not a valid number")

        # Otherwise, add the integer as a word to the string list
        else:
            str_list.append(integer_as_word)

    # Write the list of strings to a new file called "integers_as_word.txt"
    with open("integers_as_word.txt", "w") as file:
        file.write("\n".join(str_list))


if __name__ == "__main__":
    print(convert_integer_to_words("83459345"))
