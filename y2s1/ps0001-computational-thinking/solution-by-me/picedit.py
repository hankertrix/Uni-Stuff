import os
from collections import deque, namedtuple
from typing import Any, Callable, NamedTuple, cast

import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np


@lambda _: _()
def define_globals() -> None:

    # The minimum value for RGB values
    globals()["MIN_RGB_VALUE"] = 0

    # The maximum value for RGB values
    globals()["MAX_RGB_VALUE"] = 255

    # Create a named tuple to store the state
    globals()["State"] = namedtuple(
        "State",
        [
            "function_stack",
            "images",
            "image_pointer",
        ],
    )


def clamp(value: int, min_value: int, max_value: int) -> int:
    """The function to clamp a value within a range"""
    return np.clip(value, min_value, max_value)


def rgb_clamp(rgb_value: int) -> int:
    """
    The function to clamp an RGB value to be within the
    maximum and minimum values for RGB values.
    """
    return clamp(
        rgb_value, globals()["MIN_RGB_VALUE"], globals()["MAX_RGB_VALUE"]
    )


def edit_image_rgb(
    image: np.ndarray,
    calculate_new_rgb_func: Callable[
        [int, int, int, int, int],
        list[int] | np.ndarray,
    ],
    selection_mask: np.ndarray | None = None,
) -> np.ndarray:
    """
    Function to edit the RGB values of an image.

    This function takes an image,
    a selection mask and a function
    to edit the RGB values of the image.

    The selection mask is a numpy array
    with the same shape as the image,
    where each element is either 0 or 1.
    0 represents a pixel that is not selected,
    and 1 represents a pixel that is selected.

    The function must take 5 arguments,
    representing the red, green and blue values,
    as well as the row index and column index,
    and return a new RGB value as a list of integers.
    """

    # Get the height and width of the image
    image_height, image_width, _ = image.shape

    # If the selection mask is not provided, create a mask
    # that selects all pixels
    if selection_mask is None:
        selection_mask = np.ones((image_height, image_width))

    # Initialise the edited image
    edited_image = image.copy()

    # Iterate over each row of the image
    for row in range(image_height):

        # Iterate over each column of the image
        for column in range(image_width):

            # If the pixel is not selected, skip it
            if selection_mask[row][column] == 0:
                continue

            # Get the RGB value of the pixel
            rgb_value = image[row][column]

            # Get the red, green and blue values of the pixel
            red, green, blue = rgb_value

            # Call the function to get the new RGB values
            new_rgb_value = calculate_new_rgb_func(
                red, green, blue, row, column
            )

            # Add the new RGB value to the edited image
            edited_image[row][column] = np.array(new_rgb_value)

    # Return the edited image
    return edited_image


def edit_brightness(image: np.ndarray, value: int) -> np.ndarray:
    """
    Function to edit the brightness of an image.

    This function takes an image and returns
    the image with the brightness edited.

    The value given must be within 0 - 255,
    any value that is outside of this range
    will be clamped to the nearest value.
    """

    # Clamp the value to be within -255 - 255
    value = clamp(
        value, -globals()["MAX_RGB_VALUE"], globals()["MAX_RGB_VALUE"]
    )

    # Create the function to calculate the new RGB values
    # to edit the brightness
    def change_rgb_brightness(red: int, green: int, blue: int, *_) -> list[int]:
        """Function to change the brightness of an RGB value."""

        # Calculate the new red, green and blue values
        new_red = rgb_clamp(red + value)
        new_green = rgb_clamp(green + value)
        new_blue = rgb_clamp(blue + value)

        # Return the new RGB values
        return [new_red, new_green, new_blue]

    # Call the function to edit the RGB values
    edited_image = edit_image_rgb(image, change_rgb_brightness)

    # Return the edited image
    return edited_image


def edit_contrast(image: np.ndarray, value: int) -> np.ndarray:
    """Function to edit the contrast of an image."""

    # Clamp the value to be within -255 - 255
    value = clamp(
        value, -globals()["MAX_RGB_VALUE"], globals()["MAX_RGB_VALUE"]
    )

    # Get the contrast correction factor
    contrast_correction_factor = (259 * (value + 255)) / (255 * (259 - value))

    # Create the function to calculate the new RGB values
    # to edit the contrast
    def change_rgb_contrast(red: int, green: int, blue: int, *_) -> list[int]:
        """Function to change the contrast of an RGB value."""

        # Calculate the new red, green and blue values
        new_red = rgb_clamp(int(contrast_correction_factor * (red - 128) + 128))
        new_green = rgb_clamp(
            int(contrast_correction_factor * (green - 128) + 128)
        )
        new_blue = rgb_clamp(
            int(contrast_correction_factor * (blue - 128) + 128)
        )

        # Return the new RGB values
        return [new_red, new_green, new_blue]

    # Call the function to edit the RGB values
    edited_image = edit_image_rgb(image, change_rgb_contrast)

    # Return the edited image
    return edited_image


def grayscale_effect_rgb(red: int, green: int, blue: int, *_) -> list[int]:
    """Function to edit the RGB values of an image to make it grayscale."""

    # Calculate the rgb value
    new_rgb_value = int(0.3 * red + 0.59 * green + 0.11 * blue)

    # Return the edited RGB values
    return [new_rgb_value, new_rgb_value, new_rgb_value]


def grayscale_effect(image: np.ndarray) -> np.ndarray:
    """Function to convert an image to grayscale."""

    # Apply the function to edit the RGB values using the grayscale effect
    edited_image = edit_image_rgb(image, grayscale_effect_rgb)

    # Return the edited image
    return edited_image


def image_convolution(image: np.ndarray, kernel: np.ndarray) -> np.ndarray:
    """
    Function to perform convolution on a matrix using a given kernel.

    The kernel is a 3 x 3 matrix.
    """

    # Get the height and width of the image
    image_height, image_width, image_channels = image.shape

    # Get the size of the kernel
    kernel_size = len(kernel)

    # Create the output matrix
    output_matrix = image.copy()

    # Iterate over each row of the image
    for row in range(1, image_height - 1):

        # Iterate over each column of the image
        for column in range(1, image_width - 1):

            # Otherwise, iterate over the channels
            for channel in range(image_channels):

                # Get the convolution region
                convolution_region = image[
                    row - 1 : row + kernel_size - 1,
                    column - 1 : column + kernel_size - 1,
                    channel,
                ]

                # Get the convolution value
                convolution_value = np.sum(convolution_region * kernel)

                # Set the output matrix to the RGB value
                output_matrix[row, column, channel] = convolution_value

    # Return the output matrix
    return output_matrix


def gaussian_blur_effect(image: np.ndarray) -> np.ndarray:
    """Function to apply a Gaussian blur effect to an image."""

    # Create the kernel matrix for the Gaussian blur effect
    kernel_matrix = np.array(
        [
            [0.0625, 0.125, 0.0625],
            [0.125, 0.25, 0.125],
            [0.0625, 0.125, 0.0625],
        ]
    )

    # Convolve the image with the kernel matrix
    convolved_image = image_convolution(image, kernel_matrix)

    # Return the convolved image
    return convolved_image


def edge_detection_effect(image: np.ndarray) -> np.ndarray:
    """
    Function to apply an edge detection effect to an image.

    This function will make the discontinuities in the image
    stand out more.
    """

    # Create the kernel matrix for the edge detection effect
    kernel_matrix = np.array(
        [
            [-1, -1, -1],
            [-1, 8, -1],
            [-1, -1, -1],
        ]
    )

    # Convolve the image with the kernel matrix
    output_image = image_convolution(image, kernel_matrix)

    # Increase the brightness of the convolved image by 128
    image_with_increased_brightness = edit_brightness(output_image, 128)

    # Set the output image to the image with increased brightness,
    # ignoring the edges
    output_image[1:-1, 1:-1] = image_with_increased_brightness[1:-1, 1:-1]

    # Return the output image
    return output_image


def embossed_effect(image: np.ndarray) -> np.ndarray:
    """
    Function to apply an embossed effect to an image.
    """

    # Create the kernel matrix for the embossed effect
    kernel_matrix = np.array(
        [
            [-1, -1, 0],
            [-1, 0, 1],
            [0, 1, 1],
        ]
    )

    # Convolve the image with the kernel matrix
    output_image = image_convolution(image, kernel_matrix)

    # Increase the brightness of the convolved image by 128
    image_with_increased_brightness = edit_brightness(output_image, 128)

    # Set the output image to the image with increased brightness,
    # ignoring the edges
    output_image[1:-1, 1:-1] = image_with_increased_brightness[1:-1, 1:-1]

    # Return the output image
    return output_image


def create_rectangular_mask(
    image: np.ndarray,
    top_left_coordinates: tuple[int, int],
    bottom_right_coordinates: tuple[int, int],
) -> np.ndarray:
    """Function to create a rectangular mask."""

    # Get the height and width of the image
    image_height, image_width, _ = image.shape

    # Create a mask that selects none of the pixels
    selection_mask = np.zeros((image_height, image_width))

    # Get the top left rows and columns
    top_left_row, top_left_column = top_left_coordinates

    # Get the bottom right rows and columns
    bottom_right_row, bottom_right_column = bottom_right_coordinates

    # Iterate over each row
    for row in range(top_left_row, bottom_right_row + 1):

        # Iterate over each column
        for column in range(top_left_column, bottom_right_column + 1):

            # Set the selection mask to 1 at the current row and column
            selection_mask[row][column] = 1

    # Return the selection mask
    return selection_mask


def calculate_colour_distance(
    first_rgb_value: np.ndarray, second_rgb_value: np.ndarray
) -> float:
    """
    Function to calculate the colour distance between two RGB values.

    It uses the formula:
        colour_distance = sqrt(
            (2 + (r_avg / 256)) * (r_1 - r_2)^2
            + 4 * (g_1 - g_2)^2
            + (2 + ((255 - r_avg) / 256)) * (b_1 - b_2)^2
        )
    """

    # Get the red, green and blue values of the first RGB value
    red_1, green_1, blue_1 = first_rgb_value

    # Get the red, green and blue values of the second RGB value
    red_2, green_2, blue_2 = second_rgb_value

    # Calculate the average red value
    average_red = (red_1 + red_2) / 2

    # Get the square of the difference
    # between the first and second red values
    red_squared_difference = (red_1 - red_2) ** 2

    # Get the square of the difference
    # between the first and second green values
    green_squared_difference = (green_1 - green_2) ** 2

    # Get the square of the difference
    # between the first and second blue values
    blue_squared_difference = (blue_1 - blue_2) ** 2

    # Calculate the colour distance using the formula
    colour_distance = np.sqrt(
        (2 + (average_red / 256)) * red_squared_difference
        + 4 * green_squared_difference
        + (2 + ((255 - average_red) / 256)) * blue_squared_difference
    )

    # Return the colour distance
    return colour_distance


def adjacent_pixel_is_eligible_for_magic_wand_selection(
    image: np.ndarray,
    checked_pixels: np.ndarray,
    current_pixel_coordinates: tuple[int, int],
    adjacent_pixel_direction: str,
    rgb_value_to_compare: np.ndarray,
    colour_distance_threshold: int,
) -> tuple[bool, int, int]:
    """
    Function to check if an adjacent pixel is
    eligible for magic wand selection.
    """

    # Get the total number of rows and columns
    # in the image
    total_rows, total_columns, _ = image.shape

    # Initialise the adjacent pixel's row and column
    adjacent_pixel_row, adjacent_pixel_column = current_pixel_coordinates

    # If the pixel direction is left of the current pixel
    if adjacent_pixel_direction == "Left":

        # Subtract 1 from the pixel's column
        adjacent_pixel_column -= 1

    # Otherwise, if the pixel direction is right of the current pixel
    elif adjacent_pixel_direction == "Right":

        # Add 1 to the pixel's column
        adjacent_pixel_column += 1

    # Otherwise, if the pixel direction is above the current pixel
    elif adjacent_pixel_direction == "Above":

        # Subtract 1 from the pixel's row
        adjacent_pixel_row -= 1

    # Otherwise, if the pixel direction is below the current pixel
    elif adjacent_pixel_direction == "Below":

        # Add 1 to the pixel's row
        adjacent_pixel_row += 1

    # If the adjacent pixel's row is outside
    # of the image's bounds, return False
    # and the adjacent pixel's row and column
    if adjacent_pixel_row < 0 or adjacent_pixel_row >= total_rows:
        return False, adjacent_pixel_row, adjacent_pixel_column

    # If the adjacent pixel's column is outside
    # of the image's bounds, return False
    # and the adjacent pixel's row and column
    if adjacent_pixel_column < 0 or adjacent_pixel_column >= total_columns:
        return False, adjacent_pixel_row, adjacent_pixel_column

    # Get the current pixel's row and column
    current_pixel_row, current_pixel_column = current_pixel_coordinates

    # If the adjacent has already been checked,
    # return False and the adjacent pixel's row and column
    if checked_pixels[adjacent_pixel_row][adjacent_pixel_column] == 1:
        return False, adjacent_pixel_row, adjacent_pixel_column

    # Set the checked pixels to 1 at the adjacent pixel
    checked_pixels[adjacent_pixel_row][adjacent_pixel_column] = 1

    # Calculate the colour distance between
    # the current pixel and the adjacent pixel
    colour_distance = calculate_colour_distance(
        rgb_value_to_compare,
        image[adjacent_pixel_row][adjacent_pixel_column],
    )

    # If the colour distance is greater than
    # the colour distance threshold, return False
    # and the adjacent pixel's row and column
    if colour_distance > colour_distance_threshold:
        return False, adjacent_pixel_row, adjacent_pixel_column

    # Otherwise, return True and the adjacent pixel's row and column
    return True, adjacent_pixel_row, adjacent_pixel_column


def create_magic_wand_mask(
    image: np.ndarray,
    given_pixel_coordinates: tuple[int, int],
    colour_distance_threshold: int,
) -> np.ndarray:
    """
    Function to create a magic wand mask.

    This function takes an image,
    a given pixel coordinate and
    a threshold value and returns
    a selection mask with the selection.
    """

    # Initialise the storage to store the connected pixels
    connected_pixels: deque[tuple[int, int]] = deque()

    # Get the given pixel's row and column
    given_pixel_row, given_pixel_column = given_pixel_coordinates

    # Get the RGB value of the given pixel
    given_pixel_rgb_value = image[given_pixel_row][given_pixel_column]

    # Get the height and width of the image
    image_height, image_width, _ = image.shape

    # Create the selection mask with all pixels unselected
    selection_mask = np.zeros((image_height, image_width))

    # Create a matrix to store whether the pixel has been checked
    checked_pixels = np.zeros((image_height, image_width))

    # Append the given pixel to the storage
    connected_pixels.append((given_pixel_row, given_pixel_column))

    # While the storage for connected pixels is not empty
    while connected_pixels:

        # Remove the connected pixel from the storage
        current_pixel_row, current_pixel_column = connected_pixels.popleft()

        # Iterate over all of the pixel directions
        for adjacent_pixel_direction in ("Left", "Right", "Above", "Below"):

            # Check if the adjacent pixel is eligible for selection
            is_eligible, adjacent_pixel_row, adjacent_pixel_column = (
                adjacent_pixel_is_eligible_for_magic_wand_selection(
                    image,
                    checked_pixels,
                    (current_pixel_row, current_pixel_column),
                    adjacent_pixel_direction,
                    given_pixel_rgb_value,
                    colour_distance_threshold,
                )
            )

            # If the adjacent pixel is not eligible for selection,
            # continue the loop
            if not is_eligible:
                continue

            # Otherwise, set the selection mask to 1 at the adjacent pixel
            selection_mask[adjacent_pixel_row][adjacent_pixel_column] = 1

            # Add the adjacent pixel coordinates
            # to the storage of connected pixels
            connected_pixels.append((adjacent_pixel_row, adjacent_pixel_column))

    # Return the selection mask
    return selection_mask


def combine_images(
    original_image: np.ndarray,
    new_image: np.ndarray,
    selection_mask: np.ndarray,
) -> np.ndarray:
    """
    Function to combine two images.

    The function takes three arguments:
        original_image: The original image.
        new_image: The new image to be combined with the original image.
        selection_mask: A numpy array with the same shape as the
                        original image, where each element is either
                        0 or 1. 0 represents a pixel that is not selected,
                        and 1 represents a pixel that is selected.
    """

    # Create the function to edit the image rgb values
    def replace_old_image_with_new_image_rgb(
        _, __, ___, row: int, column: int
    ) -> np.ndarray:
        """
        Function to edit the RGB values of the original
        image with the new image.
        """

        # Get the RGB value of the pixel in the new image
        new_image_rgb_value = new_image[row][column]

        # Return the RGB value of the new image
        return new_image_rgb_value

    # Call the function to edit the RGB values
    combined_image = edit_image_rgb(
        original_image, replace_old_image_with_new_image_rgb, selection_mask
    )

    # Return the combined image
    return combined_image


def handle_user_input(
    prompt: str | list[str],
    message_on_invalid_input: str,
    validation_function: Callable[[str], tuple[bool, Any]] | None = None,
) -> Any:
    """
    Function to handle the user input.

    This function takes a prompt as a string,
    or a list of strings.
    If the prompt is a list of strings,
    the prompt will be combined with a
    new line character.

    The function also takes a validation function
    as a callable, which is called with the user input
    and returns a tuple of a boolean and the parsed
    input from the user.
    """

    # If the prompt is a list of strings,
    # combine the prompts with a new line character
    if isinstance(prompt, list):
        prompt = "\n".join(prompt)

    # If the validation function is not provided,
    # set it to a function that always returns True
    # and the input as the parsed input
    if validation_function is None:

        def validation_function(input: str) -> tuple[bool, str]:
            """
            Function to always return True
            and the input as the parsed input
            regardless of the input.
            """
            return True, input

    # Initialise the variable to store
    # whether the user's input is valid
    is_valid = False

    # While the user's input is not valid
    while not is_valid:

        # Get the user's input
        user_input = input(prompt)

        # Call the validation function
        is_valid, parsed_input = validation_function(user_input)

        # If the user's input is valid, break the loop
        if is_valid:
            break

        # Otherwise, display the message on invalid input
        print(message_on_invalid_input.format(user_input))

    # Return the parsed input
    return parsed_input


def initialise_state() -> NamedTuple:
    """Function to initialise the state."""

    # Initialise the state
    state = globals()["State"](
        function_stack=[],
        images=[],
        image_pointer=[-1],
    )

    # Return the state
    return state


def push_to_function_stack(state, function: Callable[[Any], None]) -> None:
    """Function to push a function to the function stack."""
    state.function_stack.append(function)


def pop_from_function_stack(state) -> Any:
    """Function to pop a function from the function stack and call it."""

    # If the function stack is empty, exit the function
    if not state.function_stack:
        return

    # Pop the function from the function stack
    # and call it.
    return state.function_stack.pop()()


def get_image_pointer(state) -> int:
    """Function to get the image pointer."""
    return state.image_pointer[0]


def set_image_pointer(state, value: int) -> None:
    """Function to set the image pointer."""
    state.image_pointer[0] = value


def get_current_image_and_mask(
    state,
) -> tuple[np.ndarray, np.ndarray] | tuple[None, None]:
    """Function to get the current image."""

    # Get the image pointer
    image_pointer = get_image_pointer(state)

    # If the image pointer is -1, return None
    if image_pointer == -1:
        return (None, None)

    # Otherwise, return the current image and mask
    return state.images[image_pointer]


def change_image_pointer(state, amount: int = 1) -> None:
    """Function to change the image pointer."""

    # Get the image pointer
    image_pointer = get_image_pointer(state)

    # Clamp the image pointer to be within the range of the images list
    new_image_pointer = clamp(image_pointer + amount, 0, len(state.images) - 1)

    # Set the image pointer to the new image pointer
    set_image_pointer(state, new_image_pointer)


def increment_image_pointer(state, amount: int = 1) -> None:
    """Function to increment the image pointer."""

    # Change the image pointer to the new image pointer
    change_image_pointer(state, amount)


def decrement_image_pointer(state, amount: int = 1) -> None:
    """Function to decrement the image pointer."""

    # Change the image pointer to the new image pointer
    change_image_pointer(state, -amount)


def add_image_and_mask_to_state(
    state, image: np.ndarray, mask: np.ndarray
) -> None:
    """Function to add an image and its mask to the state."""

    # Get the current image pointer and increment it by 1
    image_pointer = get_image_pointer(state) + 1

    # If the image pointer is past the length of the images list
    if image_pointer >= len(state.images):

        # Append the image and mask to the images list
        state.images.append((image, mask))

        # Set the image pointer to the last index of the images list
        set_image_pointer(state, len(state.images) - 1)

        # Exit the function
        return

    # Otherwise, insert the image at the image pointer
    state.images.insert(image_pointer, (image, mask))

    # Increment the image pointer by 1
    increment_image_pointer(state, 1)


def display_current_image(state, show_mask: bool = False) -> None:
    """Function to display the current image."""

    # Get the current image and mask
    image, mask = get_current_image_and_mask(state)

    # If the show mask is True, display the mask and exit the function
    if show_mask:
        return display_image(image, mask)

    # Otherwise, create the mask with all pixels selected
    all_pixels_selected_mask = np.ones_like(mask)

    # Display the image using the mask with all pixels selected
    display_image(image, all_pixels_selected_mask)


def load_user_picture(state, failed: bool = False) -> None:
    """Function to load a picture provided by the user."""

    # Get the user's input
    user_input = handle_user_input(
        f"""Please enter {
            'another' if failed else 'the'
        } path to the picture you want to load: """,
        message_on_invalid_input="The path you have given ({}) does not exist.",
        validation_function=lambda input: (
            os.path.isfile(input.strip()),
            input.strip(),
        ),
    )

    # Try to load the image
    try:
        image, mask = load_image(user_input)

    # If an error occurs, display the error message
    # and call the function again
    except Exception as e:
        print(e)
        return load_user_picture(state, True)

    # Otherwise, add the image and its mask to the state
    add_image_and_mask_to_state(state, image, mask)

    # Display the current image
    display_current_image(state)

    # Call the function to display the menu again
    display_menu(state)


def save_user_picture(state, failed: bool = False) -> None:
    """Function to save the current picture."""

    # Get the current image
    current_image, _ = get_current_image_and_mask(state)

    # If the current image is None, then display the menu again
    if current_image is None:
        display_menu(state)

    # Get the user's input
    user_input = handle_user_input(
        f"Please enter {
            'another' if failed else 'a'
            } path to save the picture to: ",
        message_on_invalid_input="The path you have given ({}) does not exist.",
    )

    # Try to save the image
    try:
        save_image(user_input, current_image)

    # If an error occurs, display the error message
    # and call the function again
    except Exception as e:
        print(e)
        return save_user_picture(state, True)

    # Otherwise, display the menu again
    display_menu(state)


def handle_undo(state) -> None:
    """Function to undo the last action."""

    # Get the current image pointer
    current_image_pointer = get_image_pointer(state)

    # Decrement the image pointer by 1
    decrement_image_pointer(state, 1)

    # Get the new image pointer
    new_image_pointer = get_image_pointer(state)

    # If the new image pointer is the same as the current image pointer
    if new_image_pointer == current_image_pointer:

        # Print that there is nothing to undo
        print("There is nothing to undo.")

    # Otherwise
    else:

        # Print that the undo was successful
        print("Undid the last action.")

        # Display the current image
        display_current_image(state)

    # Call the function to display the menu again
    display_menu(state)


def handle_redo(state) -> None:
    """Function to redo the last undo."""

    # Get the current image pointer
    current_image_pointer = get_image_pointer(state)

    # Increment the image pointer by 1
    increment_image_pointer(state, 1)

    # Get the new image pointer
    new_image_pointer = get_image_pointer(state)

    # If the new image pointer is the same as the current image pointer
    if new_image_pointer == current_image_pointer:

        # Print that there is nothing to undo
        print("There is nothing to redo.")

    # Otherwise
    else:

        # Print that the redo was successful
        print("Redid the last undo.")

        # Display the current image
        display_current_image(state)

    # Call the function to display the menu again
    display_menu(state)


def is_valid_number(input: str) -> tuple[bool, int | None]:
    """Function to validate a number."""

    # Strip the whitespace from the input
    input = input.strip()

    # Try to convert the input to an integer
    try:
        number = int(input)

    # If an error occurs, return False and None
    except ValueError:
        return False, None

    # Otherwise, return True and the number
    return True, number


def is_valid_rgb_value(input: str) -> tuple[bool, int | None]:
    """Function to validate an RGB value."""

    # Get whether or not the input is a valid number
    is_valid, number = is_valid_number(input)

    # If the input is not a valid number, return False and None
    if not is_valid:
        return False, None

    # Otherwise, if the number is not within the valid range,
    # return False and None
    if not -globals()["MAX_RGB_VALUE"] <= number <= globals()["MAX_RGB_VALUE"]:
        return False, None

    # Otherwise, return True and the number
    return True, number


def adjust_image(
    state,
    adjustment_function: Callable[[np.ndarray, Any], np.ndarray],
    handle_user_input_func: Callable[[], Any] | None = None,
    failure_fallback_func: Callable[[Any], None] | None = None,
) -> None:
    """Function to adjust the image."""

    # Get the current image
    current_image, current_mask = get_current_image_and_mask(state)

    # If the failure fallback function is not provided,
    # set it to the display menu function
    if failure_fallback_func is None:
        failure_fallback_func = display_menu

    # If the current image is None, call the failure fallback function
    if current_image is None or current_mask is None:
        return failure_fallback_func(state)

    # Initialise the user's input to None
    user_input = None

    # If the handle user input function is provided,
    # get the user's input
    if handle_user_input_func is not None:
        user_input = handle_user_input_func()

    # Call the adjustment function with the user's input
    adjusted_image = adjustment_function(current_image, user_input)

    # Create a mask with all pixels selected
    all_pixels_selected_mask = np.ones_like(current_mask)

    # Initialise the edited image
    edited_image = adjusted_image

    # If the current mask is not the same as the all pixels selected mask
    if not (current_mask == all_pixels_selected_mask).all():

        # Combine the current image and mask with the edited image and mask
        edited_image = combine_images(
            current_image, adjusted_image, current_mask
        )

    # Add the edited image and its mask to the state
    add_image_and_mask_to_state(state, edited_image, current_mask)

    # Display the current image
    display_current_image(state)

    # Call the function to display the menu again
    display_menu(state)


def adjust_brightness(state) -> None:
    """Function to adjust the brightness of the current image."""

    # Create the user input handler function
    def user_input_handler() -> int | None:
        """Function to handle the user input."""
        return handle_user_input(
            [
                "Please enter the brightness value to adjust the image by.",
                "It must be an integer between -255 and 255.",
                "--> ",
            ],
            message_on_invalid_input="The brightness value you have given ({}) "
            + "is not between -255 and 255.",
            validation_function=is_valid_rgb_value,
        )

    # Call the adjust image function with the user input handler
    adjust_image(state, change_brightness, user_input_handler)


def adjust_contrast(state) -> None:
    """Function to adjust the contrast of the current image."""

    # Create the user input handler function
    def user_input_handler() -> int | None:
        return handle_user_input(
            [
                "Please enter the contrast value to adjust the image by.",
                "It must be an integer between -255 and 255.",
                "--> ",
            ],
            message_on_invalid_input="The contrast value you have given ({}) "
            + "is not between -255 and 255.",
            validation_function=is_valid_rgb_value,
        )

    # Call the adjust image function with the user input handler
    adjust_image(state, change_contrast, user_input_handler)


def apply_grayscale(state) -> None:
    """Function to apply grayscale to the current image."""

    # Call the adjust image function with grayscale effect
    adjust_image(state, lambda image, *_: grayscale_effect(image))


def apply_blur(state) -> None:
    """Function to apply blur to the current image."""

    # Call the adjust image function with the blur effect
    adjust_image(state, lambda image, *_: gaussian_blur_effect(image))


def apply_edge_detection(state) -> None:
    """Function to apply edge detection to the current image."""

    # Create the function to apply edge detection to the image
    def edge_detection_function(image, *_) -> np.ndarray:
        """Function to apply edge detection to the image."""

        # Apply edge detection to the image
        edited_image = edge_detection_effect(image)

        # Increase the brightness of the edited image by 128
        final_image = edit_brightness(edited_image, 128)

        # Return the final image
        return final_image

    # Call the adjust image function with edge detection effect
    adjust_image(state, edge_detection_function)


def apply_emboss_effect(state) -> None:
    """Function to apply emboss effect to the current image."""

    # Create the function to apply emboss effect to the image
    def emboss_effect_function(image, *_) -> np.ndarray:
        """Function to apply emboss effect to the image."""

        # Apply emboss effect to the image
        edited_image = embossed_effect(image)

        # Increase the brightness of the edited image by 128
        final_image = edit_brightness(edited_image, 128)

        # Return the final image
        return final_image

    # Call the adjust image function with emboss effect
    adjust_image(state, emboss_effect_function)


def handle_new_mask(
    state,
    handle_user_input_func: Callable[[np.ndarray], Any],
    mask_function: Callable[[np.ndarray, Any], np.ndarray],
    failure_fallback_func: Callable[[Any], None] | None = None,
) -> None:
    """Function to handle the creation of a new mask."""

    # Get the current image
    current_image, _ = get_current_image_and_mask(state)

    # If the failure fallback function is not provided,
    # set it to the display menu function
    if failure_fallback_func is None:
        failure_fallback_func = display_menu

    # If the current image is None, call the failure fallback function
    if current_image is None:
        return failure_fallback_func(state)

    # Get the user's input
    user_input = handle_user_input_func(current_image)

    # Call the mask function with the user's input
    new_mask = mask_function(current_image, user_input)

    # Add the current image with the new mask to the state
    add_image_and_mask_to_state(state, current_image, new_mask)

    # Display the current image with the mask
    display_current_image(state, show_mask=True)

    # Call the function to display the menu again
    display_menu(state)


def validate_user_input_for_coordinates(
    user_input: str, image: np.ndarray
) -> tuple[bool, tuple[int, int] | None]:
    """Function to validate the user's input for coordinate input."""

    # Strip the whitespace from the input
    input = user_input.strip()

    # Strip the brackets from the input
    input = input.strip("[]{}()")

    # If the input is empty
    if len(input) < 1:
        return False, None

    # Otherwise, split the input at the comma
    # and strip the whitespace from each item
    split_input = [item.strip() for item in input.split(",")]

    # Initialise the coordinates
    coordinates: list[int] = []

    # Iterate over each item in the split input
    for index, item in enumerate(split_input):

        # If the index is greater than 1, break the loop
        if index > 1:
            break

        # Try block to catch errors
        try:

            # Convert the item to an integer
            int_item = int(item)

            # Add the integer item to the coordinates
            coordinates.append(int_item)

        # If an error occurs, return False and None
        except ValueError:
            return False, None

    # Get the x and y coordinates
    x, y = coordinates

    # Get the height and width of the image
    image_height, image_width, _ = image.shape

    # If the x coordinate is outside of the image's bounds,
    # or if the y coordinate is outside of the image's bounds,
    # return False and None
    if x not in range(image_height + 1) or y not in range(image_width + 1):
        return False, None

    # Otherwise, return True and the coordinates
    return True, (x, y)


def make_rectangular_mask(state) -> None:
    """Function to make a rectangular mask."""

    # Create the user input handler function
    def user_input_handler(
        image: np.ndarray,
    ) -> tuple[tuple[int, int], tuple[int, int]]:
        """The function to handle the user input."""

        # Initialise the dictionary to store the user's input
        user_input_dict: dict[str, None | tuple[int, int]] = {
            "top left": None,
            "bottom right": None,
        }

        # Iterate over each key in the user input dictionary
        for key in user_input_dict.keys():

            # Initialise the user's input to None
            user_input = None

            # While the user's input is None
            while user_input is None:

                # Get the user's input for the key
                user_input = handle_user_input(
                    [
                        f"Please enter the {key} coordinates.",
                        "It should be in the format:",
                        "x, y",
                        "where x and y are integers",
                        "--> ",
                    ],
                    message_on_invalid_input="The coordinates you have given "
                    + "({}) is not in the format: x, y\n"
                    + "or isn't an integer",
                    validation_function=(
                        lambda input: validate_user_input_for_coordinates(
                            input, image
                        )
                    ),
                )

            # Add the user's input to the user input dictionary
            user_input_dict[key] = user_input

        # Get the image height and width
        image_width, image_height, _ = image.shape

        # Initialise the list of coordinates
        coordinates_list: list[tuple[int, int]] = []

        # Iterate over each item in the user input dictionary
        for key, coordinates in user_input_dict.items():

            # If the coordinates don't exist,
            # call the user input handler function again
            if coordinates is None:
                return user_input_handler(image)

            # Get the x and y coordinates
            x, y = coordinates

            # If the coordinates are outside of the image's bounds,
            # call the user input handler function again
            if x not in range(image_width + 1) or y not in range(
                image_height + 1
            ):
                return user_input_handler(image)

            # Add the coordinates to the list of coordinates
            coordinates_list.append((x, y))

        # Otherwise, return  the top left coordinates
        # and the bottom right coordinates
        return cast(
            tuple[tuple[int, int], tuple[int, int]], tuple(coordinates_list)
        )

    # Create the function to create a rectangular mask with the user's input
    def create_rectangular_mask_with_user_input(
        image: np.ndarray, user_input: tuple[tuple[int, int], tuple[int, int]]
    ) -> np.ndarray:
        """Function to create a rectangular mask with the user's input."""

        # Get the top left coordinates and the bottom right coordinates
        top_left_coordinates, bottom_right_coordinates = user_input

        # Call the create rectangular mask function with
        # the top left coordinates and the bottom right coordinates
        rectangular_mask = create_rectangular_mask(
            image, top_left_coordinates, bottom_right_coordinates
        )

        # Return the rectangular mask
        return rectangular_mask

    # Call the function to create the new mask
    handle_new_mask(
        state, user_input_handler, create_rectangular_mask_with_user_input
    )


def make_magic_wand_mask(state) -> None:
    """Function to make a magic wand mask."""

    # Create the user input handler function
    def user_input_handler(image: np.ndarray) -> tuple[tuple[int, int], int]:
        """Function to handle the user input."""

        # Get the user's input for the start pixel
        user_input_start_pixel = handle_user_input(
            [
                "Please enter the coordinates of the start pixel.",
                "It should be in the format:",
                "x, y",
                "where x and y are integers",
                "--> ",
            ],
            message_on_invalid_input="The coordinates you have given "
            + "({}) is not in the format: x, y\n"
            + "or isn't an integer",
            validation_function=(
                lambda input: validate_user_input_for_coordinates(input, image)
            ),
        )

        # Get the user's input for the colour distance threshold
        user_input_colour_distance_threshold = handle_user_input(
            [
                "Please enter the colour distance threshold.",
                "It must be an integer.",
                "--> ",
            ],
            message_on_invalid_input="The coordinates you have given "
            + "({}) is not in the format: x, y\n"
            + "or isn't an integer",
            validation_function=is_valid_number,
        )

        # If the user's input is None,
        # call the user input handler function again
        if (
            user_input_start_pixel is None
            or user_input_colour_distance_threshold is None
        ):
            return user_input_handler(image)

        # Otherwise, get the coordinates of the start pixel
        start_pixel_x, start_pixel_y = user_input_start_pixel

        # Get the height and width of the image
        image_height, image_width, _ = image.shape

        # If the start pixel's x coordinate is outside of the image's bounds,
        # or if the start pixel's y coordinate
        # is outside of the image's bounds,
        # call the user input handler function again
        if start_pixel_x not in range(
            image_height + 1
        ) or start_pixel_y not in range(image_width + 1):
            return user_input_handler(image)

        # Otherwise, return the start pixel's coordinates
        # and the colour distance threshold
        return user_input_start_pixel, user_input_colour_distance_threshold

    # Create the function to create a magic wand mask with the user's
    def create_magic_wand_mask_with_user_input(
        image: np.ndarray, user_input: tuple[tuple[int, int], int]
    ) -> np.ndarray:

        # Get the start pixel's coordinates and the colour distance threshold
        start_pixel, colour_distance_threshold = user_input

        # Call the create magic wand mask function
        new_mask = create_magic_wand_mask(
            image, start_pixel, colour_distance_threshold
        )

        # Return the new mask
        return new_mask

    # Call the function to handle the new mask
    handle_new_mask(
        state, user_input_handler, create_magic_wand_mask_with_user_input
    )


def display_menu(state=None) -> None:
    """Function to display the menu."""

    # If the state is None, initialise it
    if state is None:
        state = initialise_state()

    # Create the dictionary that maps the user's input
    # to the corresponding function and description
    input_to_function: dict[str, tuple[Callable[[Any], None], str]] = {
        "e": (lambda _: _, "exit"),
        "l": (load_user_picture, "load a picture"),
        "s": (save_user_picture, "save the current picture"),
        "u": (handle_undo, "undo the last action"),
        "r": (handle_redo, "redo the last undo"),
        "1": (adjust_brightness, "adjust brightness"),
        "2": (adjust_contrast, "adjust contrast"),
        "3": (apply_grayscale, "apply grayscale"),
        "4": (apply_blur, "apply blur"),
        "5": (apply_edge_detection, "edge detection"),
        "6": (apply_emboss_effect, "embossed"),
        "7": (make_rectangular_mask, "rectangle select"),
        "8": (make_magic_wand_mask, "magic wand select"),
    }

    # If there are no images in the state, display only the first 2 options
    if not state.images:
        input_to_function = {
            key: value
            for index, (key, value) in enumerate(input_to_function.items())
            if index < 2
        }

    # Create the prompt list to display the menu
    prompt_list = [
        f"{key} - {description}"
        for key, (_, description) in input_to_function.items()
    ]

    # Add the arrows to the prompt list
    prompt_list.append("--> ")

    # Create the prompt to display the menu
    prompt = "What do you want to do?\n" + "\n".join(prompt_list)

    def menu_input_validator(input: str) -> tuple[bool, str]:
        """Function to handle the user input for the menu."""

        # Strip the whitespace from the input
        input = input.strip()

        # If the input is empty
        if len(input) < 1:

            # Return False and the input
            return False, input

        # Get the first character of the input
        first_character = input[0]

        # If the first character can be found
        # in the input to function dictionary,
        # return True and the first character
        if input_to_function.get(first_character) is not None:
            return True, first_character

        # Otherwise, return False and the first character
        return False, first_character

    # Get the user's input
    user_input = handle_user_input(
        prompt,
        message_on_invalid_input="The input you have given ({}) "
        + "is not an option on the menu.",
        validation_function=menu_input_validator,
    )

    # Get the dictionary result for the user's input
    dict_result = input_to_function.get(user_input)

    # If the result of the dictionary is None,
    # display the menu again and exit the function
    if dict_result is None:
        return display_menu(state)

    # Otherwise, get the function from the dictionary result
    function, description = dict_result

    # Call the function with the state
    function(state)


# Required functions


def change_brightness(image, value):
    return edit_brightness(image, value)


def change_contrast(image, value):
    return edit_contrast(image, value)


def grayscale(image):
    return grayscale_effect(image)


def blur_effect(image):
    return gaussian_blur_effect(image)


def edge_detection(image):
    return edge_detection_effect(image)


def embossed(image):
    return embossed_effect(image)


def rectangle_select(image, x, y):
    return create_rectangular_mask(image, x, y)


def magic_wand_select(image, x, thres):
    return create_magic_wand_mask(image, x, thres)


def compute_edge(mask):
    rsize, csize = len(mask), len(mask[0])
    edge = np.zeros((rsize, csize))
    if np.all((mask == 1)):
        return edge
    for r in range(rsize):
        for c in range(csize):
            if mask[r][c] != 0:
                if (
                    r == 0
                    or c == 0
                    or r == len(mask) - 1
                    or c == len(mask[0]) - 1
                ):
                    edge[r][c] = 1
                    continue

                is_edge = False
                for var in [(-1, 0), (0, -1), (0, 1), (1, 0)]:
                    r_temp = r + var[0]
                    c_temp = c + var[1]
                    if 0 <= r_temp < rsize and 0 <= c_temp < csize:
                        if mask[r_temp][c_temp] == 0:
                            is_edge = True
                            break

                if is_edge == True:
                    edge[r][c] = 1

    return edge


def save_image(filename, image):
    img = image.astype(np.uint8)
    mpimg.imsave(filename, img)


def load_image(filename):
    img = mpimg.imread(filename)
    if len(img[0][0]) == 4:  # if png file
        img = np.delete(img, 3, 2)
    if (
        type(img[0][0][0]) == np.float32
    ):  # if stored as float in [0,..,1] instead of integers in [0,..,255]
        img = img * 255
        img = img.astype(np.uint8)
    mask = np.ones(
        (len(img), len(img[0]))
    )  # create a mask full of "1" of the same size of the loaded image
    img = img.astype(np.int32)
    return img, mask


def display_image(image, mask):
    # if using Spyder, please go to
    # "Tools -> Preferences -> IPython console -> Graphics -> Graphics Backend"
    # and select "inline"
    tmp_img = image.copy()
    edge = compute_edge(mask)
    for r in range(len(image)):
        for c in range(len(image[0])):
            if edge[r][c] == 1:
                tmp_img[r][c][0] = 255
                tmp_img[r][c][1] = 0
                tmp_img[r][c][2] = 0

    plt.imshow(tmp_img)
    plt.axis("off")
    plt.show()
    print("Image size is", str(len(image)), "x", str(len(image[0])))


def menu():
    display_menu()


if __name__ == "__main__":
    menu()
