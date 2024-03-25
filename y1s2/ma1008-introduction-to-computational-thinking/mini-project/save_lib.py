# The module to handle saving and loading of saved data

import tomllib
from decimal import Decimal
from typing import Any, Hashable


def convert_obj_to_toml_str(obj: Any) -> str:
    "Function to convert a Python object to a TOML string"

    # If the object is a boolean
    if isinstance(obj, bool):
        return "true" if obj else "false"

    # Otherwise, if the object is an integer, float or decimal
    elif isinstance(obj, (int, float, Decimal)):
        return str(obj)

    # Otherwise, if the object is a string
    elif isinstance(obj, str):
        return f'"{obj}"'

    # Otherwise, if the object is a list or a tuple
    elif isinstance(obj, (list, tuple)):

        # Get the string representing the list
        list_str = ", ".join(convert_obj_to_toml_str(item) for item in obj)

        # Return the list in square brackets
        return f"[{list_str}]"

    # Otherwise, if the object is a dictionary
    elif isinstance(obj, dict):

        # Get the string representing the dictionary
        dict_str = ", ".join(
            f"{key} = {convert_obj_to_toml_str(value)}"
            for key, value in obj.items()
        )

        # Return the dictionary in curly braces
        return "{ " + dict_str + " }"

    # Otherwise, raise an error
    else:
        raise ValueError(f"{type(obj).__name__} {obj!r} is not supported")


def sort_dict_items(item: tuple[Hashable, Any]) -> int:
    """
    Function to sort the dictionary items.

    This sorting will put non-container types like integers and floats
    first in the list, then lists after, then the dictionaries after.
    """

    # Get the value of the key
    _, value = item

    # If the item is a dictionary, return 2
    if isinstance(value, dict):
        return 2

    # Otherwise, if the item is a list or a tuple, return 1
    elif isinstance(value, (list, tuple)):
        return 1

    # Otherwise, return 0
    else:
        return 0


def collection_contains_dict(collection: list | tuple) -> bool:
    "Function to check if a collection contains a dictionary"

    # If the length of the collection is less than 1, return False
    if len(collection) < 1:
        return False

    # Otherwise, return if the first item in the collection is a dictionary
    return isinstance(collection[0], dict)


def convert_dict_to_toml_str(dic: dict, table_name: str = "") -> str:
    "Function to convert a dictionary to a TOML string"

    # Initialise the list to contain the TOML string
    toml_str: list[str] = []

    # Iterates over the items in the dictionary,
    # sorted by whether or not they are a collection, or a dictionary.
    #
    # This is because there is no way to signify the end of a TOML table,
    # so the values that are not inside a TOML table must come before
    # the values that are inside a TOML table.
    for key, value in sorted(dic.items(), key=sort_dict_items):

        # Get the key for the table header
        table_key = f"{table_name}.{key}" if table_name else key

        # If the item is a dictionary
        if isinstance(value, dict):

            # Add the string to the list of TOML strings
            toml_str.append(
                f"\n[{table_key}]\n"
                f"{convert_dict_to_toml_str(value, table_key)}"
            )

        # Otherwise, if the item is a list or tuple
        elif isinstance(value, (list, tuple)) and collection_contains_dict(
            value
        ):

            # Iterate over all of the items in the list
            for item in value:

                # Add the string to the list of TOML strings
                toml_str.append(
                    f"\n[[{table_key}]]\n"
                    f"{convert_dict_to_toml_str(item, table_key)}"
                )

        # Otherwise
        else:

            # If there is a "." in the key when converted to a string,
            # wrap the key in double quotes so as to not turn the key
            # into a dictionary
            if "." in str(key):
                key = f'"{key}"'

            # Add the key and it's corresponding value to the TOML string
            toml_str.append(f"{key} = {convert_obj_to_toml_str(value)}")

    # Returns the TOML string joined with new line characters
    return "\n".join(toml_str).strip()


def read_saved_data(file_name: str) -> dict:
    "Function to read the saved data from a TOML file"

    # Open the file and return the dictionary
    with open(file_name, "rb") as file:
        return tomllib.load(file)
