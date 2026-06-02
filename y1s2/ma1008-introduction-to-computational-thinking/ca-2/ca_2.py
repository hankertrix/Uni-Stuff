# Module to find the difference between 2 times,
# that is within 24 hours of each other

from typing import Callable


def get_user_input(
    prompt: str,
    invalid_prompt: str,
    validator: Callable[[str], bool]
) -> str:
    "Function to get the user's input"

    # Initialise the is_valid variable to false
    is_valid = False

    # While the user's input is not valid
    while not is_valid:

        # Prompts the user for the input
        user_input = input(prompt)

        # Set the is valid variable to the result of the validator function
        is_valid = validator(user_input)

        # If the prompt isn't valid, print a message telling the user
        if not is_valid:
            print(invalid_prompt)

    # Returns the user's input
    return user_input


def get_time_value(time_str: str) -> list[int] | None:
    "Get time value from the time string, converted to 24 hours"

    # Replace the colon in the time with a space
    time_str = time_str.replace(":", " ", 1)

    # Get a list from the time string
    time_list = time_str.split()

    # If the list's length is not 3, return None
    if len(time_list) != 3:
        return None

    # Gets the time info from the list
    hour_str, minute_str, am_or_pm = time_list

    # If the hour and minutes are not decimals, return None
    if not hour_str.isdecimal() or not minute_str.isdecimal():
        return None

    # Convert the hour and minutes to integers
    hour = int(hour_str)
    minute = int(minute_str)

    # Change the am_or_pm string to uppercase
    am_or_pm = am_or_pm.upper()

    # If the hour is not between 1 and 12, return None
    if hour not in range(1, 13):
        return None

    # Otherwise, if the minute is not between 0 and 59, return None
    elif minute not in range(0, 60):
        return None

    # If the am_or_pm string is not AM or PM
    elif am_or_pm not in ("AM", "PM"):
        return None

    # If the hour is 12, set the hour to zero
    if hour == 12:
        hour = 0

    # If the am_or_pm string is PM, add 12 to the hour
    if am_or_pm == "PM":
        hour += 12

    # Return the hours and minutes in a list
    return [hour, minute]


def get_time_difference(
    earlier_time_list: list[int],
    later_time_list: list[int]
) -> tuple[int, int]:
    "Function to get the time difference between two times"

    # If the time given as later is "earlier" than the earlier time,
    # add 24 hours to the hour of the later time
    if later_time_list < earlier_time_list:
        later_time_list[0] += 24

    # Convert the time to minutes for both
    earlier_time_in_min = earlier_time_list[0] * 60 + earlier_time_list[1]
    later_time_in_min = later_time_list[0] * 60 + later_time_list[1]

    # Subtract the earlier time from the later time
    time_difference_in_min = later_time_in_min - earlier_time_in_min

    # Convert the time difference to minutes and hours
    hours = int(time_difference_in_min // 60)
    minutes = int(time_difference_in_min - hours * 60)

    # Return the time difference as a tuple of hours and minutes
    return (hours, minutes)


def main() -> None:
    "The main function to run"

    # The list to store the user's inputs
    user_inputs: list[str] = []

    # The tuple of prompts
    prompts = (
        "Please enter the earlier time: ",
        "Please enter the later time: "
    )

    # The invalid prompt to display to the user
    invalid_prompt = "** Invalid input **"

    # Iterates over the prompts
    for prompt in prompts:

        # Calls the get_user_input function and add the result to the list
        user_inputs.append(
            get_user_input(
                prompt,
                invalid_prompt,
                lambda user_input: bool(get_time_value(user_input))
            )
        )

    # The list of times from the user's input
    times: list[list[int]] = []

    # Iterates over the user's inputs
    for user_input in user_inputs:

        # If the time value isn't None
        if (time_value := get_time_value(user_input)) is not None:

            # Add the time value to the list of times
            times.append(time_value)

    # Gets the time difference
    time_difference = get_time_difference(*times)

    # Prints the time difference
    print(
        "The time difference is {} hours and {} minutes".format(
            *time_difference
        )
    )


# Name safeguard
if __name__ == "__main__":
    main()
