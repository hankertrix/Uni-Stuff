# The module to handle saving and loading of saved data

import os
import tomllib
from decimal import Decimal
from typing import Any, Hashable

import math_utils


def convert_obj_to_toml_str(obj: Any, indent_level: int = 0) -> str:
    """
    Function to convert a Python object to a TOML string.

    The indent level parameter is an internal parameter for
    recursion, and should not be passed when using this function.
    """

    # The string to use for indentation, which is 4 spaces
    indent_str = " " * 4

    # The new line character, which is a line break character
    new_line_char = "\n"

    # Get the indentation string at the front of the line
    indentation_str = new_line_char + indent_str * (indent_level + 1)

    # If the object is a boolean, return the boolean in lowercase
    if isinstance(obj, bool):
        return "true" if obj else "false"

    # Otherwise, if the object is an integer, float or decimal
    elif isinstance(obj, (int, float, Decimal)):

        # Get the string of the number and uppercase it
        number_str = str(obj).upper()

        # If the number starts with 0E, set the number string to "0"
        if number_str.startswith("0E"):
            number_str = "0"

        # Return the number string
        return number_str

    # Otherwise, if the object is a string, return the quoted string
    elif isinstance(obj, str):
        return f'"{obj}"'

    # Otherwise, if the object is a list or a tuple
    elif isinstance(obj, (list, tuple)):

        # If there is one item or less in the list
        if len(obj) <= 1:

            # Get the string representing the list
            list_str = ", ".join(convert_obj_to_toml_str(item) for item in obj)

            # Return the list in square brackets
            return f"[{list_str}]"

        # Otherwise, get the TOML string for all the items in the list
        toml_strings = [
            indentation_str + convert_obj_to_toml_str(item, indent_level + 1)
            for item in obj
        ]

        # Set the format string to be the one for a list, with square brackets
        format_str = "[%s]"

        # Return the string joined with a comma
        return format_str % (
            ",".join(toml_strings)
            + f"{new_line_char}{indent_str * indent_level}"
        )

    # Otherwise, if the object is a dictionary
    elif isinstance(obj, dict):

        # If the dictionary is empty, return the empty dictionary
        if len(obj) < 1:
            return "{}"

        # Otherwise, get the TOML string for the items in the dictionary
        toml_strings = [
            f"{key} = " + convert_obj_to_toml_str(value, indent_level + 1)
            for key, value in obj.items()
        ]

        # Return the string joined with a comma wrapped in curly braces
        return "{ %s }" % ", ".join(toml_strings)

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


def convert_all_floats_to_decimal(data: Any) -> Any:
    "Convert all the floats in an object to a decimal"

    # If the data given is a list or a tuple
    if isinstance(data, (list, tuple)):

        # Gets the converted list
        converted_list = [convert_all_floats_to_decimal(item) for item in data]

        # Return the converted list if the data is a list,
        # otherwise, return a tuple
        return (
            converted_list if isinstance(data, list) else tuple(converted_list)
        )

    # Otherwise, if the data given is a dictionary,
    # convert all the float values to a decimal
    elif isinstance(data, dict):
        return {
            key: convert_all_floats_to_decimal(value)
            for key, value in data.items()
        }

    # Otherwise, if the data given is a float,
    # convert it to a decimal
    elif isinstance(data, float):
        return Decimal(data)

    # Otherwise, just return the object
    else:
        return data


def is_toml_file(filename: str) -> bool:
    "Function to check if a file is a TOML file"
    return filename.strip().lower().endswith(".toml")


def read_logo_file(filename: str) -> dict | None:
    "Function to read the saved data from a TOML file"

    # Try block to catch errors
    try:

        # Open the file and return the dictionary,
        # with the floats all converted to decimals
        with open(filename, "rb") as file:
            return tomllib.load(file, parse_float=Decimal)

    # Catch the TOMLDecodeError and the FileNotFoundError and return None
    except (tomllib.TOMLDecodeError, FileNotFoundError):
        return None


def is_valid_logo_data(logo_data: list[dict] | tuple[dict] | dict) -> bool:
    """
    Function to check if the logo data from the logo dictionary is valid.
    """

    # If the logo data is a list or a tuple
    if isinstance(logo_data, (list, tuple)):

        # If the list or tuple is empty, return False
        if len(logo_data) < 1:
            return False

        # Otherwise, iterate over all the items in the list
        # and return if all of the items are valid
        return all(is_valid_logo_data(item) for item in logo_data)

    # If the logo data given is not a dictionary, return False
    if not isinstance(logo_data, dict):
        return False

    # Otherwise, get the vertices from the dictionary
    vertices = logo_data.get("vertices")

    # If the vertices is not a list or a tuple, then return False
    if not isinstance(vertices, (list, tuple)):
        return False

    # Gets the length of the list of vertices
    number_of_vertices = len(vertices)

    # If the number of vertices in the list is not 2 or 4,
    # return False
    if number_of_vertices not in (2, 4):
        return False

    # Otherwise, iterate over all of the items in the vertices
    for vertex in vertices:

        # Try to catch errors
        try:

            # If the vertex inside the list of vertices is not a 2 x 1 matrix,
            # which is a 2D vector, then return False
            if math_utils.matrix_shape(vertex) != (2, 1):
                return False

        # If there's an error, return False
        except Exception:
            return False

    # Otherwise, return True
    return True


def is_valid_logo_dict(logo_dict: dict) -> bool:
    """
    Function to check if a dictionary is a valid dictionary containing
    the data for drawing a logo.
    """

    # Gets the data for the logo
    logo_data = logo_dict.get("data")

    # If the data is None, then return False
    if logo_data is None:
        return False

    # Return if the logo data is valid or not
    return is_valid_logo_data(logo_data)


def open_logo_file(filename: str) -> dict | None:
    "Function to open the saved logo file"

    # Read the logo file
    logo_file = read_logo_file(filename)

    # If the logo file is None, then return None
    if logo_file is None:
        return None

    # Otherwise, if the logo file is invalid, also return None
    if not is_valid_logo_dict(logo_file):
        return None

    # Otherwise, return the logo file
    return logo_file


def add_toml_file_extension(file_path: str) -> str:
    """
    Function to add the TOML file extension to a given file path.

    This function will not add the TOML file extension if the
    filename already contains the TOML file extension.
    """

    # If the file path is a directory, then return it as is
    if os.path.isdir(file_path):
        return file_path

    # If the file path doesn't have the TOML file extension
    if not is_toml_file(file_path):

        # Add the TOML file extension to the file path
        file_path = f"{file_path}.toml"

    # Return the file path
    return file_path


def save_logo_dict_as_logo_file(
    file_path: str, logo_dict: dict, force: bool = False
) -> int:
    """
    Function to save a logo dictionary as a TOML file.

    This function returns a code to tell the caller if an error
    has occurred.

    The force parameter tells the function to overwrite the
    file, even if the file already exists in the directory.
    The return code 2 will never be returned if the force
    parameter is set to True.

    0 means no error, everything succeeded.
    1 means an error was encountered.
    2 means a file is being overwritten, the function will
    need to be called with the force parameter set to True
    to overwrite the file.
    """

    # If the force parameter is False, and the file path already exists,
    # return 2 to tell the caller that the file is being overwritten
    if not force and os.path.exists(file_path):
        return 2

    # Convert the dictionary to a TOML string
    toml_str = convert_dict_to_toml_str(logo_dict)

    # Try block to catch any errors
    try:

        # Open the file in write mode
        with open(file_path, "w") as file:

            # Write the TOML string to the file
            file.write(toml_str)

    # If there's an error, return 1 to indicate an error
    except Exception:
        return 1

    # Otherwise, return 0 to say that all is fine
    return 0
