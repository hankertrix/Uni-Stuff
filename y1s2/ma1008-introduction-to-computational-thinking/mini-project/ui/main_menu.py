# The module for the main menu of the program
# mypy: disable-error-code="attr-defined"

import os.path
import turtle
from decimal import Decimal
from typing import Any, Callable

import default_logos
import draw_lib
import math_utils
import save_lib
import ui.file_explorer
import utils
from constants import APP_NAME, WINDOW_BUFFER_IN_PIXELS

# The default canvas buffer in pixels.
# This is so that there is space
CANVAS_BUFFER = 200

# The list delimiter
LIST_DELIMITER = "."

# The string for all the default logos
WORLD_BANK_LOGO_STR = "World Bank Logo"
CERN_LOGO_STR = "CERN Logo"
RUST_LOGO_STR = "Rust Programming Language Logo"

# The dictionary mapping the string to the logo dictionary
# for the default logos
DEFAULT_LOGOS = {
    WORLD_BANK_LOGO_STR: default_logos.world_bank_logo,
    CERN_LOGO_STR: default_logos.cern_logo,
    RUST_LOGO_STR: default_logos.rust_logo,
}

# The option string for all the transforms
TRANSLATION_OPTION_STR = "Translate"
ROTATION_OPTION_STR = "Rotate"
ROTATION_OF_90_DEG_OPTION_STR = "Rotate by 90 degrees"
SCALING_OPTION_STR = "Scale"
SHEARING_OPTION_STR = "Shear"
REFLECT_ABOUT_X_OPTION_STR = "Reflect about the x-axis"
REFLECT_ABOUT_Y_OPTION_STR = "Reflect about the y-axis"
REFLECT_ABOUT_Y_EQUAL_X_OPTION_STR = "Reflect about the line y = x"
REFLECT_ABOUT_Y_EQUAL_MINUS_X_OPTION_STR = "Reflect about the line y = -x"

# The prompt string for all the transforms
TRANSLATION_PROMPT_STR = "Please enter the translation in the {}."
ROTATION_PROMPT_STR = "\n".join(
    [
        "Please enter the rotation in degrees.",
        "",
        "This rotation angle is measure anticlockwise from the x-axis.",
        "If you would like to rotate clockwise instead, "
        + "please enter a negative angle.",
    ]
).strip()
SCALING_PROMPT_STR = "Please enter the scaling factor in the {}."
SHEARING_PROMPT_STR = "Please enter the shearing factor in the {}."

# The dictionary mapping the string to the prompts and the variables
TRANSFORMATION_PROMPTS_DICT: dict[str, dict] = {
    TRANSLATION_OPTION_STR: {
        "function": math_utils.vec_3d_translate,
        "defaults": (0, 0),
        "prompt": TRANSLATION_PROMPT_STR,
        "variables": ("x-direction", "y-direction"),
    },
    ROTATION_OPTION_STR: {
        "function": math_utils.vec_3d_rotate,
        "defaults": 0,
        "prompt": ROTATION_PROMPT_STR,
    },
    ROTATION_OF_90_DEG_OPTION_STR: {
        "function": math_utils.vec_3d_rotate_90_degrees
    },
    SCALING_OPTION_STR: {
        "function": math_utils.vec_3d_scale,
        "defaults": (1, 1),
        "prompt": SCALING_PROMPT_STR,
        "variables": ("x-direction", "y-direction"),
    },
    SHEARING_OPTION_STR: {
        "function": math_utils.vec_3d_shear,
        "defaults": (0, 0),
        "prompt": SCALING_PROMPT_STR,
        "variables": ("x-direction", "y-direction"),
    },
    REFLECT_ABOUT_X_OPTION_STR: {
        "function": math_utils.vec_3d_reflect_about_x,
    },
    REFLECT_ABOUT_Y_OPTION_STR: {
        "function": math_utils.vec_3d_reflect_about_y,
    },
    REFLECT_ABOUT_Y_EQUAL_X_OPTION_STR: {
        "function": math_utils.vec_3d_reflect_about_line_y_equal_x
    },
    REFLECT_ABOUT_Y_EQUAL_MINUS_X_OPTION_STR: {
        "function": math_utils.vec_3d_reflect_about_line_y_equal_minus_x
    },
}

# The instructions for the colour input
COLOUR_INPUT_INSTRUCTIONS = (
    "The colour can either be the name of the colour, like black, "
    + "or a hex colour string, like #000000, "
    + "or a tuple containing the RGB values ranging from 0 to 255, "
    + "like (0, 0, 0)."
)


def set_manual_input_logo_dict(state: dict, manual_logo_dict: dict) -> None:
    "Function to set the manual input logo dictionary"
    state["manual_logo_input"] = manual_logo_dict


def get_manual_input_logo_dict(state: dict) -> dict:
    "Function to get the manual input logo dictionary"

    # Get the logo dictionary
    logo_dict = state.get("manual_logo_input")

    # If the logo dictionary is not found, then initialise it
    if logo_dict is None:

        # Initialise the logo dictionary
        logo_dict = {"data": []}

        # Set the logo dictionary to the initialised dictionary
        set_manual_input_logo_dict(state, logo_dict)

    # Return the logo dictionary
    return logo_dict


def get_manual_input_logo_data(state: dict) -> list[dict]:
    "Function to get the data in the logo dictionary"

    # Get the logo dictionary
    logo_dict = get_manual_input_logo_dict(state)

    # Get the data from the logo dictionary
    data = logo_dict.get("data")

    # If the data is not found
    if data is None:

        # Initialise the data
        data = []

        # Set the data in the logo dictionary to the initialised data
        logo_dict["data"] = data

    # Return the data
    return data


def get_shape_is_already_filled(state: dict) -> bool | None:
    "Function to get if the current shape is already filled"
    return state.get("shape_already_filled")


def set_shape_already_filled(state: dict, is_already_filled: bool) -> None:
    "Function to set that the shape is already filled or not"
    state["shape_already_filled"] = is_already_filled


def set_mouse_input_vertices(
    state: dict, list_of_vertices: list[list[list[int | Decimal]]]
) -> None:
    "Function to set the list of vertices for the mouse input"
    state["mouse_input_vertices"] = list_of_vertices


def get_mouse_input_vertices(state: dict) -> list[list[list[int | Decimal]]]:
    "Function to get the list of vertices for the mouse input"

    # Get the list of vertices
    list_of_vertices = state.get("mouse_input_vertices")

    # If the list of vertices is None
    if list_of_vertices is None:

        # Initialise the list of vertices
        list_of_vertices = []

        # Set the list of vertices to the initialised list of vertices
        set_mouse_input_vertices(state, list_of_vertices)

    # Return the list of vertices
    return list_of_vertices


def get_desired_action(
    screen: turtle._Screen,
    prompt: str | list[str],
    options_dict: dict[int, tuple[str, Callable[..., Any]]],
    cancelled_callback_function: Callable[..., None] | None = None,
    title: str = APP_NAME,
) -> Callable[..., Any]:
    """
    Function to get the desired action from the user.

    The title parameter is the text to be shown on the
    top of the dialog box.

    The prompt parameter can either by a string or a list of strings.
    If it is a list of strings, the list is joined using the new line character.

    The options_dict parameter should be a dictionary
    with integers as the keys and a tuple of a string
    and a callable function as the value.

    The cancelled callback function is the function
    to call when the dialog is cancelled.
    """

    # If the prompt is a list of strings, combine it into a single string
    if isinstance(prompt, list):
        prompt = "\n".join(prompt).strip()

    # Set the default function to return
    cancelled_callback_function = (
        cancelled_callback_function
        if cancelled_callback_function is not None
        else utils.exit_program(screen)
    )

    # Get the input from the user
    user_input = turtle.numinput(title, prompt, 1, 1, len(options_dict))

    # If the user input is None, which means they cancelled the dialog,
    # return the cancelled callback function
    if user_input is None:
        return cancelled_callback_function

    # Convert the user's input into an integer
    user_input = int(user_input)

    # Get the function from the dictionary.
    # The default value shouldn't ever happen,
    # since the given input should be in the dictionary.
    _, function = options_dict.get(
        user_input, ("", cancelled_callback_function)
    )

    # Return the function for the desired action
    return function


def create_list_of_options(
    options_dict: dict[int, tuple[str, Callable[..., Any]]],
    list_delimiter: str = LIST_DELIMITER,
) -> list[str]:
    "Function to create the list of options to display to the user"

    return [
        f"{option_num}{list_delimiter} {description}"
        for option_num, (description, _) in options_dict.items()
    ]


def get_user_input_text(
    screen: turtle._Screen,
    prompt: str | list[str],
    invalid_input_prompt: str | list[str],
    parser: Callable[[str | None], Any],
    title: str = APP_NAME,
) -> Any:
    """
    Function to get the user's text input.

    The title parameter takes the title of the input box, which
    defaults to the app name.

    The prompt parameter can either be a string or a list of strings.
    If the prompt given is a list of strings, it will be combined with the
    new line character.

    The invalid_input_prompt parameter is a string to be displayed
    to the user when the user's input is invalid.

    The parser is the function to parse the user input given,
    which is either a string or None, into the desired type.

    The function will use the parser to validate the user input, and it will
    call the bool function on the result of the parser, so a falsy value
    should be returned if the user input should be rejected.
    """

    # If the prompt is a list of strings, combine it into a single string
    if isinstance(prompt, list):
        prompt = "\n".join(prompt).strip()

    # If the invalid_input_prompt is a list of strings,
    # combine it into a single string
    if isinstance(invalid_input_prompt, list):
        invalid_input_prompt = "\n".join(invalid_input_prompt).strip()

    # Initialise the input_is_valid variable to False
    input_is_valid = False

    # Initialise the parsed_input variable to None
    parsed_input = None

    # While the user input isn't valid
    while not input_is_valid:

        # Get the input from the user
        user_input = turtle.textinput(title, prompt)

        # Gets the parsed user input
        parsed_input = parser(user_input)

        # Calls the bool function on the parsed value
        # and set it to the input_is_valid variable
        input_is_valid = bool(parsed_input)

        # If the input is valid, return the parsed input
        if input_is_valid:
            return parsed_input

        # Otherwise, tells the user that their input is invalid
        turtle.TK.messagebox.showerror(title, invalid_input_prompt)


def get_user_input_number(
    screen: turtle._Screen,
    prompt: str | list[str],
    default_value: float | None = None,
    min_value: float | None = None,
    max_value: float | None = None,
    title: str = APP_NAME,
) -> Decimal | None:
    """
    Function to get the user's input as a number
    using the turtle.numinput function.

    This function simply forces the user to enter a number
    and not cancel the dialogue.
    """

    # If the prompt is a list of strings, combine it into a single string
    if isinstance(prompt, list):
        prompt = "\n".join(prompt).strip()

    # Get the user's input
    user_input = turtle.numinput(
        title, prompt, default_value, min_value, max_value
    )

    # Return the user's input as a decimal if it's not None
    return Decimal(user_input) if user_input is not None else None


def draw_logo(
    logo_dict: dict,
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
) -> None:
    """
    Function to draw a logo using a dictionary or a string.
    If a string is given, then the logo must be one of the default logos.

    The draw instantly parameter is to determine whether to draw the logo
    showing the drawing process.

    The canvas_buffer and window_buffer parameters are just passed
    to the draw_icon function.

    This function just handles the UI part of drawing an icon, like
    drawing the continue label as well as calling the function for
    the next step.
    """

    # Otherwise, call the draw icon function on the given logo
    draw_lib.draw_icon(
        logo_dict, screen, draw_instantly, canvas_buffer, window_buffer
    )

    # Draw the continue label
    utils.draw_continue_label(screen)

    # The function to handle any interactions with the screen
    handle_interaction = utils.call_without_args(
        utils.exit_ui_component, screen, state
    )

    # Attach the handlers to the screen
    screen.onkeypress(handle_interaction)
    screen.onclick(handle_interaction)

    # Listen for updates
    screen.listen()


def handle_transformation_option(
    transformation: str,
    screen: turtle._Screen,
) -> list[list[int | Decimal]]:
    "Function to handle the transformation option chosen by the user"

    # Get the dictionary of information related to the transformation option
    transformation_info = TRANSFORMATION_PROMPTS_DICT.get(transformation)

    # If the transformation dictionary is somehow None,
    # then return an empty list.
    # This should never happen, since all the cases are determined
    # by the dictionary.
    if transformation_info is None:
        return []

    # Otherwise, get the function for the transformation
    transformation_func = transformation_info.get("function")

    # If the transformation function is somehow None,
    # then return an empty list.
    # This should never happen, since all the transformations in
    # the dictionary have an associated function.
    if transformation_func is None:
        return []

    # Otherwise, get the prompt for the transformation
    transformation_prompt = transformation_info.get("prompt")

    # If there is no prompt for the transformation, then return the output
    # of the function
    if transformation_prompt is None:
        return transformation_func()

    # Otherwise, get the tuple of prompt variables
    prompt_variables = transformation_info.get("variables")

    # Get the default values for the user input
    default_values = transformation_info.get("defaults")

    # If there is no tuple of prompt variables
    if prompt_variables is None:

        # Get the user's input
        # Here the default value should just be one integer or float
        user_input = get_user_input_number(
            screen,
            transformation_prompt,
            default_values,
        )

        # If the user's input is None, then return an empty list
        if user_input is None:
            return []

        # Return the result of the transformation function
        return transformation_func(user_input)

    # Otherwise, initialise a list of the user's input
    user_inputs: list[int | Decimal] = []

    # Iterate over the prompt variables
    for index, variable in enumerate(prompt_variables):

        # Substitute the variable into the prompt string
        prompt = transformation_prompt.format(variable)

        # Get the default value
        default_value = (
            default_values[index]
            if isinstance(default_values, (list, tuple))
            else None
        )

        # Get the user's input
        user_input = get_user_input_number(screen, prompt, default_value)

        # If the user's input is None and the default value isn't None
        if user_input is None:

            # If the default value is None, return an empty list
            if default_value is None:
                return []

            # Otherwise, add the default value to the list
            user_inputs.append(default_value)

            # Continue the loop
            continue

        # Add the user's input to the list of user inputs
        user_inputs.append(user_input)

    # Return the result of the transformation function
    # called with the user's inputs
    return transformation_func(*user_inputs)


def ask_for_transformation(
    screen: turtle._Screen,
    state: dict,
    is_first_time: bool = False,
    title: str = APP_NAME,
) -> list[list[int | Decimal]] | None:
    """
    Function to ask the user for what kind of transformation they want.

    The is first_time parameter tells the function what prompt to give
    the user, depending on whether the it is the first time the user
    is being asked for the transformation or not.
    """

    # The prompt to ask the user for the next transformation
    transformation_question = (
        "What other transformations would you like to add?"
    )

    # The first option
    first_option = "I'm done"

    # If it is the first time the user is being asked this question
    if is_first_time:

        # Change the prompt to be more appropriate for the first time
        transformation_question = (
            "What transformations would you like to add to the logo?"
        )

        # Change the first option to "None"
        first_option = "None"

    # Initialise the dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], Any]]] = {
        1: (first_option, utils.return_none),
        2: (
            TRANSLATION_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                TRANSLATION_OPTION_STR,
                screen,
            ),
        ),
        3: (
            ROTATION_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                ROTATION_OPTION_STR,
                screen,
            ),
        ),
        4: (
            ROTATION_OF_90_DEG_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                ROTATION_OF_90_DEG_OPTION_STR,
                screen,
            ),
        ),
        5: (
            SCALING_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                SCALING_OPTION_STR,
                screen,
            ),
        ),
        6: (
            SHEARING_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                SHEARING_OPTION_STR,
                screen,
            ),
        ),
        7: (
            REFLECT_ABOUT_X_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                REFLECT_ABOUT_X_OPTION_STR,
                screen,
            ),
        ),
        8: (
            REFLECT_ABOUT_Y_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                REFLECT_ABOUT_Y_OPTION_STR,
                screen,
            ),
        ),
        9: (
            REFLECT_ABOUT_Y_EQUAL_X_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                REFLECT_ABOUT_Y_EQUAL_X_OPTION_STR,
                screen,
            ),
        ),
        10: (
            REFLECT_ABOUT_Y_EQUAL_MINUS_X_OPTION_STR,
            utils.call_without_args(
                handle_transformation_option,
                REFLECT_ABOUT_Y_EQUAL_MINUS_X_OPTION_STR,
                screen,
            ),
        ),
    }

    # Create the list of strings for the prompt
    prompt_str_list = [
        transformation_question,
        "",
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, utils.return_none, title=title
    )

    # Calls the function for the desired action, and return its value
    return desired_action()


def ask_for_list_of_transformations(
    screen: turtle._Screen, state: dict, title: str = APP_NAME
) -> list[list[list[int | Decimal]]]:
    """
    Function to ask the user the list of transformations that they desire.

    This is a wrapper function that calls the ask_for_transformation function
    repeatedly until the user states that they are done.
    """

    # Ask for the first transformation
    transformation = ask_for_transformation(screen, state, True, title)

    # The transformation is None, then return an empty list
    if transformation is None:
        return []

    # Otherwise, initialise the list of transformations
    # with the first transformation
    list_of_transformations: list[list[list[int | Decimal]]] = [transformation]

    # Otherwise, iterate while the transformation has some value
    while bool(transformation):

        # Get the transformation
        transformation = ask_for_transformation(screen, state, title=title)

        # If the transformation isn't None, then add it to the list
        if transformation is not None:
            list_of_transformations.append(transformation)

    # Return the list of transformations
    return list_of_transformations


def handle_transform_logo(
    screen: turtle._Screen,
    state: dict,
    logo_dict: dict,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the option to transform the logo"

    # Get the data from the logo dictionary
    data = logo_dict.get("data")

    # If the logo dictionary somehow has no data, then display the main menu
    if data is None:
        return display_main_menu(
            screen,
            state,
            display_welcome_message=False,
            draw_instantly=draw_instantly,
            preview=preview,
            title=title,
        )

    # Call the function to get the list of transformations from the user
    list_of_transformations = ask_for_list_of_transformations(
        screen, state, title
    )

    # Apply the list of transformations to the data
    transformed_data = math_utils.apply_transformations_to_vertices(
        list_of_transformations, data
    )

    # Create the transformed logo dictionary
    transformed_logo_dict = {**logo_dict, "data": transformed_data}

    # Push the post logo drawing handler to the function stack
    utils.push_to_function_stack(
        state,
        utils.call_without_args(
            handle_post_logo_drawing,
            screen,
            state,
            transformed_logo_dict,
            draw_instantly,
            canvas_buffer,
            window_buffer,
            preview,
            title,
        ),
    )

    # Calls the draw logo function on the transformed logo
    draw_logo(
        transformed_logo_dict,
        screen,
        state,
        draw_instantly=draw_instantly,
        canvas_buffer=canvas_buffer,
        window_buffer=window_buffer,
    )


def handle_post_save_logo(
    screen: turtle._Screen,
    state: dict,
    logo_dict: dict,
    file_path: str,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    """
    Function to handle what happens after saving the logo dictionary as a file
    """

    # The prompt to ask the user what they want to do after
    # saving the logo dictionary as a file
    post_save_logo_prompt = (
        f'The logo dictionary has been saved as a file to "{file_path}".\n\n'
        + "What else would you like to do?"
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Transform the logo",
            utils.call_without_args(
                handle_transform_logo,
                screen,
                state,
                logo_dict,
                draw_instantly,
                canvas_buffer,
                window_buffer,
                preview,
                title,
            ),
        ),
        2: (
            "Return to the main menu",
            utils.call_without_args(
                display_main_menu,
                screen,
                state,
                display_welcome_message=False,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        3: ("Exit the program", utils.exit_program(screen)),
    }

    # Get the list of strings that is the prompt to show the user
    prompt_str_list = [
        post_save_logo_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, utils.exit_program(screen), title
    )

    # Calls the function for the desired action
    desired_action()


def filename_parser(filename: str | None) -> str | None:
    "Function to parse the file name given by the user"

    # If the file name given is None, then return None
    if filename is None:
        return None

    # If the file name contains slashes or backslashes,
    # immediately return None
    if "/" in filename or "\\" in filename:
        return None

    # Otherwise, return the file name
    return filename


def handle_saving_logo_dict_as_file(
    screen: turtle._Screen,
    state: dict,
    logo_dict: dict,
    user_given_filename: str | None = None,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the saving of the selected logo file"

    # Get the selected item from the file explorer
    selected_item = ui.file_explorer.get_selected_item(state)

    # Function to re-open the file explorer with
    # the current function as the next function
    re_open_file_explorer = utils.call_without_args(
        open_file_explorer,
        screen,
        state,
        utils.call_without_args(
            handle_saving_logo_dict_as_file,
            screen,
            state,
            logo_dict,
            user_given_filename=None,
            draw_instantly=draw_instantly,
            canvas_buffer=canvas_buffer,
            window_buffer=window_buffer,
            preview=preview,
            title=title,
        ),
    )

    # If the selected item is somehow None
    if selected_item is None:

        # Calls the function to re-open the file explorer
        # and exit the function
        return re_open_file_explorer()

    # Set the save directory to the selected item
    save_directory = selected_item

    # If the save directory isn't actually a directory
    if not os.path.isdir(save_directory):

        # Change the save directory to the directory containing the file
        save_directory = os.path.dirname(save_directory)

    # If the user given file name is not given
    if user_given_filename is None:

        # The prompt for the filename
        filename_prompt = "Please enter a file name for the logo file."

        # The invalid filename prompt
        invalid_filename_prompt = (
            "Your filename is invalid, "
            + "it cannot contain slashes (/) or backslashes (\\). "
            + "Please try again."
        )

        # Get the filename from the user
        filename = get_user_input_text(
            screen,
            filename_prompt,
            invalid_filename_prompt,
            filename_parser,
            title,
        )

    # Otherwise, set the file name to the user given one
    else:
        filename = user_given_filename

    # Add the TOML file extension to the file name
    filename = save_lib.add_toml_file_extension(filename)

    # Get file path of the file to save to
    file_path = os.path.join(save_directory, filename)

    # Try to save the logo dictionary to the file path
    # and get the return code
    return_code = save_lib.save_logo_dict_as_logo_file(file_path, logo_dict)

    # If the return code is 2, which means the file already exists
    if return_code == 2:

        # Ask the user if they want to overwrite the file
        overwrite = turtle.TK.messagebox.askyesno(
            title,
            "The file already exists, overwrite the existing file?",
            default=turtle.TK.messagebox.NO,
        )

        # If the user wants to overwrite the file,
        # try to overwrite the file and get the return code
        if overwrite:
            return_code = save_lib.save_logo_dict_as_logo_file(
                file_path, logo_dict, force=True
            )

        # Otherwise, re-open the file explorer and exit the function
        else:
            return re_open_file_explorer()

    # If the return code is 0, then call the function to handle
    # what happens after the logo is saved
    if return_code == 0:
        return handle_post_save_logo(
            screen,
            state,
            logo_dict,
            file_path,
            draw_instantly,
            canvas_buffer,
            window_buffer,
            preview,
            title,
        )

    # Otherwise, that means an error has occurred while saving the file,
    # so get the prompt to tell the user what happened
    unable_to_save_file_prompt = "\n".join(
        [
            "An error has occurred while saving the file.",
            "",
            "It may be that you don't have permissions to "
            + "save the file to the folder you have chosen, "
            + "or that the file you are overwriting "
            + "is being used by another program.",
            "",
            "What would you like to do?",
        ]
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Enter another file name",
            utils.call_without_args(
                handle_saving_logo_dict_as_file,
                screen,
                state,
                logo_dict,
                user_given_filename=None,
                draw_instantly=draw_instantly,
                canvas_buffer=canvas_buffer,
                window_buffer=window_buffer,
                preview=preview,
                title=title,
            ),
        ),
        2: (
            "Select another folder and use the same file name",
            utils.call_without_args(
                handle_save_logo_option,
                screen,
                state,
                logo_dict,
                user_given_filename=filename,
                draw_instantly=draw_instantly,
                canvas_buffer=canvas_buffer,
                window_buffer=window_buffer,
                preview=preview,
                title=title,
            ),
        ),
        3: (
            "Select another folder and another file name",
            utils.call_without_args(
                handle_save_logo_option,
                screen,
                state,
                logo_dict,
                user_given_filename=None,
                draw_instantly=draw_instantly,
                canvas_buffer=canvas_buffer,
                window_buffer=window_buffer,
                preview=preview,
                title=title,
            ),
        ),
        4: (
            "Return to the main menu",
            utils.call_without_args(
                display_main_menu,
                screen,
                state,
                display_welcome_message=False,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        5: ("Exit the program", utils.exit_program(screen)),
    }

    # Get the list of strings for the prompt
    prompt_str_list = [
        unable_to_save_file_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, utils.exit_program(screen), title
    )

    # Call the function for the desired action
    desired_action()


def handle_save_logo_option(
    screen: turtle._Screen,
    state: dict,
    logo_dict: dict,
    user_given_filename: str | None = None,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the save logo option"

    # Open the file explorer with the function
    # to handle the saving of the logo dictionary as
    # a file being the next function
    open_file_explorer(
        screen,
        state,
        utils.call_without_args(
            handle_saving_logo_dict_as_file,
            screen,
            state,
            logo_dict,
            user_given_filename,
            draw_instantly,
            canvas_buffer,
            window_buffer,
            preview,
            title,
        ),
        filter_for_toml_only=True,
        title=title,
    )


def handle_post_logo_drawing(
    screen: turtle._Screen,
    state: dict,
    logo_dict: dict,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    """
    Function to handle what happens after drawing a logo
    """

    # The post logo drawing prompt
    post_logo_drawing_prompt = (
        "The logo has been drawn.\n\nWhat else would you like to do?"
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Transform the logo",
            utils.call_without_args(
                handle_transform_logo,
                screen,
                state,
                logo_dict,
                draw_instantly,
                canvas_buffer,
                window_buffer,
                preview,
                title,
            ),
        ),
        2: (
            "Save the drawn logo",
            utils.call_without_args(
                handle_save_logo_option,
                screen,
                state,
                logo_dict,
                user_given_filename=None,
                draw_instantly=draw_instantly,
                canvas_buffer=canvas_buffer,
                window_buffer=window_buffer,
                preview=preview,
                title=title,
            ),
        ),
        3: (
            "Return to the main menu",
            utils.call_without_args(
                display_main_menu,
                screen,
                state,
                display_welcome_message=False,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        4: ("Exit the program", utils.exit_program(screen)),
    }

    # The prompt string as a list of strings
    prompt_str_list = [
        post_logo_drawing_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, utils.exit_program(screen), title
    )

    # Calls the function for the desired action
    desired_action()


def get_logo_dict(logo: dict | str) -> dict | None:
    "Function to get the logo dictionary"

    # If the logo is a string
    if isinstance(logo, str):

        # Get the default logo
        default_logo = DEFAULT_LOGOS.get(logo)

        # If the default logo is None, return None.
        # This should not happen normally, since every time
        # this function is called, it is all handled
        # in code, not by the user.
        if default_logo is None:
            return None

        # Otherwise, set the logo to the default logo found
        logo = default_logo

    # Return the logo dictionary
    return logo


def handle_draw_logo(
    screen: turtle._Screen,
    state: dict,
    logo: dict | str,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    """
    Function to handle the drawing of the logo
    and pushing a post drawing handler to the function stack
    """

    # Get the logo dictionary
    logo_dict = get_logo_dict(logo)

    # If the logo is somehow None, then display the main menu
    if logo_dict is None:
        return display_main_menu(screen, state, title=title)

    # Otherwise, push the post drawing handler to the function stack
    utils.push_to_function_stack(
        state,
        utils.call_without_args(
            handle_post_logo_drawing,
            screen,
            state,
            logo_dict,
            draw_instantly,
            canvas_buffer,
            window_buffer,
            preview,
            title,
        ),
    )

    # Calls the draw logo function to draw the logo
    draw_logo(
        logo_dict,
        screen,
        state,
        draw_instantly=draw_instantly,
        canvas_buffer=canvas_buffer,
        window_buffer=window_buffer,
    )


def handle_draw_default_logos(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the user interaction for drawing a default logo"

    # The prompt to ask the user what logo they want to draw
    draw_default_logo_prompt = "What logo would you like to draw?"

    # The wrapped display main menu function
    wrapped_display_main_menu = utils.call_without_args(
        display_main_menu,
        screen,
        state,
        display_welcome_message=False,
        draw_instantly=draw_instantly,
        preview=preview,
        title=title,
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            WORLD_BANK_LOGO_STR,
            utils.call_without_args(
                handle_draw_logo,
                screen,
                state,
                WORLD_BANK_LOGO_STR,
                draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        2: (
            CERN_LOGO_STR,
            utils.call_without_args(
                handle_draw_logo,
                screen,
                state,
                CERN_LOGO_STR,
                draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        3: (
            RUST_LOGO_STR,
            utils.call_without_args(
                handle_draw_logo,
                screen,
                state,
                RUST_LOGO_STR,
                draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        4: ("Go back", wrapped_display_main_menu),
    }

    # The list of string for the prompt
    prompt_str_list = [
        draw_default_logo_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the function to draw the logo that the user wants
    draw_logo_func = get_desired_action(
        screen,
        prompt_str_list,
        options_dict,
        wrapped_display_main_menu,
        title,
    )

    # Call the draw logo function
    draw_logo_func()


def open_file_explorer(
    screen: turtle._Screen,
    state: dict,
    next_function: Callable[..., None],
    filter_for_toml_only: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to open the file explorer and push the next function to the stack"

    # The format string
    format_string = "{} -> {}"

    # The file explorer documentation
    documentation = [
        "The file explorer should be quite intuitive to use. "
        + "You can use the mouse to click on the item that you want "
        + "or you can use the key binds below.",
        "",
        format_string.format("Up Arrow Key", "Move the cursor up 1 item"),
        format_string.format("Down Arrow Key", "Move the cursor down 1 item"),
        format_string.format("Left Arrow Key", "Go to the parent folder"),
        format_string.format(
            "Right Arrow Key", "Select a file or enter a folder"
        ),
        format_string.format("w", "Move the cursor up 1 item"),
        format_string.format("a", "Go to the parent folder"),
        format_string.format("s", "Move the cursor down 1 item"),
        format_string.format("d", "Select a file or enter a folder"),
        format_string.format("h", "Go to the parent folder"),
        format_string.format("j", "Move the cursor down 1 item"),
        format_string.format("k", "Move the cursor up 1 item"),
        format_string.format("l", "Select a file or enter a folder"),
        format_string.format(
            "c", "Select the current folder (for saving a file)"
        ),
    ]

    # Tell the user how to use the file explorer
    turtle.TK.messagebox.showinfo(title, "\n".join(documentation).strip())

    # Push the function to the stack
    utils.push_to_function_stack(state, next_function)

    # If filtering for TOML files only, then open the file explorer with
    # the is TOML file function as the file filter and exit the function
    if filter_for_toml_only:
        return ui.file_explorer.open_file_explorer(
            state, screen, save_lib.is_toml_file
        )

    # Otherwise, open the file explorer with no file filter
    ui.file_explorer.open_file_explorer(state, screen)


def handle_invalid_logo_file(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle having an invalid logo file"

    # The invalid logo file prompt
    invalid_logo_file_prompt = (
        "You have selected an invalid logo file. "
        + "What would you like to do?"
    )

    # The string for selecting another file
    select_another_file_str = "Select another file"

    # The wrapped display main menu function
    wrapped_display_main_menu = utils.call_without_args(
        display_main_menu,
        screen,
        state,
        display_welcome_message=False,
        draw_instantly=draw_instantly,
        preview=preview,
        title=title,
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            select_another_file_str,
            utils.call_without_args(
                handle_load_logo_file,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        2: ("Return to the main menu", wrapped_display_main_menu),
        3: ("Exit the program", utils.exit_program(screen)),
    }

    # The list of prompts
    prompt_str_list = [
        invalid_logo_file_prompt,
        "",
        "If you would like to fix the file, "
        + "you can edit the logo file in accordance to the format "
        + "documented in the README file and then select the "
        + f'"{select_another_file_str}" option to select the same file again',
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, wrapped_display_main_menu, title
    )

    # Calls the function for the desired action
    desired_action()


def load_logo_file_and_draw_logo(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    """
    Function to load the file returned from the file explorer and draw the icon
    """

    # Get the file that is returned from the file explorer
    file_path = ui.file_explorer.get_selected_item(state)

    # If the file path is somehow None, then open the file explorer again,
    # calling this function as the next function
    if file_path is None:
        return open_file_explorer(
            screen,
            state,
            utils.call_without_args(
                load_logo_file_and_draw_logo,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
            filter_for_toml_only=True,
            title=title,
        )

    # Load the file into a logo dictionary
    logo_dict = save_lib.open_logo_file(file_path)

    # If the logo dictionary is None
    if logo_dict is None:

        # Calls the function to handle the invalid logo file
        # and exit the function
        return handle_invalid_logo_file(
            screen, state, draw_instantly, preview, title
        )

    # Otherwise, push the post logo drawing handler to the function stack
    utils.push_to_function_stack(
        state,
        utils.call_without_args(
            handle_post_logo_drawing,
            screen,
            state,
            logo_dict,
            draw_instantly,
            preview=preview,
            title=title,
        ),
    )

    # Call the function to draw the logo
    draw_logo(
        logo_dict,
        screen,
        state,
        draw_instantly=draw_instantly,
    )


def handle_load_logo_file(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the option to load a logo file"

    # Open the file explorer
    open_file_explorer(
        screen,
        state,
        utils.call_without_args(
            load_logo_file_and_draw_logo,
            screen,
            state,
            draw_instantly,
            preview,
            title,
        ),
        filter_for_toml_only=True,
        title=title,
    )


def is_valid_colour(colour: Any) -> bool:
    "Function to return if a colour is valid or not"

    # Get the initial colour
    initial_colour = turtle.pencolor()

    # Try block to catch any errors
    try:

        # Try to set the turtle's pen colour
        turtle.pencolor(colour)

    # If there's an error, catch it and return False
    except Exception:
        return False

    # Always set the pen colour back to the original colour
    finally:
        turtle.pencolor(initial_colour)

    # Return True if there's no error
    return True


def parse_colour(colour: str | None) -> str | tuple[float, float, float] | None:
    "Function to parse the colour given by the user"

    # If the colour is None, return the word "skip"
    if colour is None:
        return "skip"

    # Make the string lower case and
    # strip out the brackets, parentheses, quotes, and whitespace
    # from the string
    colour = colour.lower().strip("()[]'\"").strip()

    # If the colour is the word "skip", return the word "skip"
    if colour == "skip":
        return "skip"

    # If the colour is the words "skip all", return the words "skip all"
    if colour == "skip all":
        return "skip all"

    # Split the colour at the commas
    colour_list = colour.split(",")

    # If the list has 3 items, then it must be an RGB tuple
    if len(colour_list) == 3:

        # Try block to catch any errors
        try:

            # Try to convert all of the strings into floats
            converted_colour_tuple: tuple = tuple(
                float(colour) for colour in colour_list
            )

        # If there is an error, then return None
        except Exception:
            return None

        # If the colour given is valid, then return the converted colour tuple
        if is_valid_colour(converted_colour_tuple):
            return converted_colour_tuple

        # Otherwise, return None
        else:
            return None

    # Otherwise, return the colour if the colour is a valid colour string,
    # and None otherwise
    return colour if is_valid_colour(colour) else None


def ask_for_other_properties(
    screen: turtle._Screen, state: dict, title: str = APP_NAME
) -> dict:
    """
    Function to ask for the other properties of an edge.

    This will be properties like the pen colour,
    fill colour, and pen thickness.
    """

    # The dictionary containing the other properties
    other_properties: dict = {}

    # The skip instruction
    skip_instruction = "\n".join(
        [
            'Type "skip" to skip this property.',
            'Type "skip all" to skip the rest of the properties.',
        ]
    ).strip()

    # Get whether the shape is already being filled by a colour
    shape_is_already_filled = get_shape_is_already_filled(state)

    # If the shape is already filled
    if shape_is_already_filled:

        # The prompt for the end fill property
        end_fill_prompt = (
            "Do you want to stop filling the fill colour on this line? (Y/N)"
            + f"\n\n{skip_instruction}"
        )

        # Get the user's input
        user_input = turtle.textinput(title, end_fill_prompt)

        # If the isn't None
        if user_input is not None:

            # Change it to lower case
            user_input = user_input.lower().strip("'\"").strip()

            # If it starts with "y"
            if user_input.startswith("y"):

                # Add the end fill property to the dictionary
                other_properties["end_fill"] = True

                # Set that the shape is not already filled in the state
                set_shape_already_filled(state, False)

            # Otherwise, if it is skip all,
            # return the dictionary of other properties
            elif user_input == "skip all":
                return other_properties

    # The prompt for the colour properties
    colour_properties_prompt = "\n".join(
        [
            "Please enter the {} colour. ",
            "",
            COLOUR_INPUT_INSTRUCTIONS,
            "",
            skip_instruction,
        ]
    ).strip()

    # The prompt for when the user gives an invalid colour
    invalid_colour_prompt = (
        "You have given an invalid colour, please try again."
    )

    # The tuple of colour types, which depends on whether the
    # shape is already being filled by a colour
    colour_types = ("pen",) if shape_is_already_filled else ("pen", "fill")

    # Iterates over the colour types
    for colour_type in colour_types:

        # Get the user's input
        user_input = get_user_input_text(
            screen,
            colour_properties_prompt.format(colour_type, colour_type),
            invalid_colour_prompt,
            parse_colour,
            title,
        )

        # If the user's input is skip, then continue the loop
        if user_input == "skip":
            continue

        # If the user's input is skip all,
        # then return the dictionary of other properties
        if user_input == "skip all":
            return other_properties

        # Adds the user input to the dictionary for the colour
        other_properties[f"{colour_type}_colour"] = user_input

        # If the colour type is the fill colour
        if colour_type == "fill":

            # Add the start fill property to the dictionary
            # and set it to True
            other_properties["start_fill"] = True

            # Set that the shape is already filled in the state
            set_shape_already_filled(state, True)

    # The prompt for the pen size
    pen_size_prompt = "Please enter the thickness of the pen as a whole number."

    # Get the user's input for the pen size
    pen_size_input = get_user_input_number(
        screen, pen_size_prompt, 1, 1, title=title
    )

    # If the user skips the input, return the other properties dictionary
    if pen_size_input is None:
        return other_properties

    # Otherwise, set the pen size to the user's input
    other_properties["pen_size"] = int(pen_size_input)

    # Return the other properties dictionary
    return other_properties


def handle_mouse_input_add_edge(
    screen: turtle._Screen,
    state: dict,
    is_chosen_method: bool = False,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    """
    Function to handle adding an edge to the logo dictionary
    for the mouse input method.
    """

    # Get the data from the logo dictionary
    data = get_manual_input_logo_data(state)

    # Get the list of vertices
    list_of_vertices = get_mouse_input_vertices(state)

    # Initialise the edge dictionary
    edge_dict = {"vertices": list_of_vertices}

    # Get the other properties
    other_properties = ask_for_other_properties(screen, state, title)

    # Update the edge dictionary with the other properties
    edge_dict.update(other_properties)

    # Add the edge dictionary to the data
    data.append(edge_dict)

    # Set the list of vertices for the mouse input to an empty list
    set_mouse_input_vertices(state, [])

    # If this function is the chosen input method,
    # then set the function to choose the edge type for the next edge
    # as the function to call
    if is_chosen_method:
        func_to_call = utils.call_without_args(
            choose_edge_type,
            screen,
            state,
            is_text_input_method=False,
            is_chosen_input_method=is_chosen_method,
            draw_instantly=draw_instantly,
            preview=preview,
            title=title,
        )

    # Otherwise,
    # set the function to choose the input method as the function to call
    else:
        func_to_call = utils.call_without_args(
            choose_input_method, screen, state, draw_instantly, preview, title
        )

    # If no preview is wanted, calls the function to call
    # and exit the function
    if not preview:
        return func_to_call()

    # Otherwise, push the function to call to the function stack
    utils.push_to_function_stack(state, func_to_call)

    # Get the logo dictionary
    logo_dict = get_manual_input_logo_dict(state)

    # Draw the logo
    draw_logo(logo_dict, screen, state, draw_instantly=True)


def handle_mouse_click_for_mouse_input(
    screen: turtle._Screen,
    state: dict,
    max_number_of_points: int,
    is_chosen_method: bool = False,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> Callable[[float, float], None]:
    "Function to handle the mouse click for the mouse input method"

    def inner(x: float, y: float) -> None:
        "The inner function to actually handle the mouse click"

        # Get the list of vertices
        list_of_vertices = get_mouse_input_vertices(state)

        # If the number of vertices is
        # more than or equal to the maximum number of points
        if len(list_of_vertices) >= max_number_of_points:

            # Push the function to add the edge
            # to the function stack
            utils.push_to_function_stack(
                state,
                utils.call_without_args(
                    handle_mouse_input_add_edge,
                    screen,
                    state,
                    is_chosen_method,
                    draw_instantly,
                    preview,
                    title,
                ),
            )

            # Calls the function to exit the UI component
            return utils.exit_ui_component(screen, state)

        # Otherwise, if previewing is wanted
        if preview:

            # Draw the logo
            draw_lib.draw_icon(
                get_manual_input_logo_dict(state), screen, draw_instantly=True
            )

        # Add the mouse click position to the
        # list of vertices
        list_of_vertices.append(math_utils.vec_2d(x, y))

        # Tells the user that a point has been added
        turtle.TK.messagebox.showinfo(title, "The point has been added!")

        # If the new number of vertices is less than
        # the maximum number of points, exit the function
        if len(list_of_vertices) < max_number_of_points:
            return

        # Otherwise, that means that all the required vertices have been
        # added, so call the function again with dummy arguments
        # to exit the function
        inner(0, 0)

    # Return the inner function
    return inner


def handle_mouse_input_method(
    screen: turtle._Screen,
    state: dict,
    number_of_points: int,
    is_chosen_method: bool = False,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the mouse input method"

    # The instructions for adding a point using the mouse
    mouse_input_instructions = (
        "Select a point using the left clicking on a point on the screen."
    )

    # Show the instruction to the user
    turtle.TK.messagebox.showinfo(title, mouse_input_instructions)

    # If previewing is wanted
    if preview:

        # Draw the logo
        draw_lib.draw_icon(
            get_manual_input_logo_dict(state), screen, draw_instantly=True
        )

    # Register the handler for the mouse input
    screen.onclick(
        handle_mouse_click_for_mouse_input(
            screen,
            state,
            number_of_points,
            is_chosen_method,
            draw_instantly,
            preview,
            title,
        )
    )

    # Listen for updates
    screen.listen()


def parse_user_given_coordinates(
    string: str | None,
) -> list[list[int | Decimal]]:
    "Function to parse the user given coordinates"

    # If the string is None, then return an empty list
    if string is None:
        return []

    # Strip out the parentheses and brackets, as well as whitespace
    # from the string
    string = string.strip("()[]").strip()

    # Split the string at the commas
    splitted_string = string.split(",")

    # If the splitted string doesn't have 2 items, return an empty list
    if len(splitted_string) != 2:
        return []

    # Try to convert the splitted string to floating point numbers
    try:
        coordinates = [float(number) for number in splitted_string]

    # If there's an error,
    # return an empty list
    except Exception:
        return []

    # Otherwise, put the coordinates into a 2D vector
    return math_utils.vec_2d(*coordinates)


def handle_text_input_method(
    screen: turtle._Screen,
    state: dict,
    number_of_points: int,
    is_chosen_method: bool = False,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the text input method"

    # Get the data for the logo dictionary
    data = get_manual_input_logo_data(state)

    # The prompt variables,
    # which corresponds to the number of points on the edge
    prompt_variables = (
        ("first", "second")
        if number_of_points == 2
        else ("first", "second", "third", "fourth")
    )

    # The type of edge
    edge_type = "straight" if number_of_points == 2 else "curved"

    # The instructions for the input
    input_instructions = "\n".join(
        [
            "The point should be a tuple of the "
            + "x-coordinate and the y-coordinate, like this:",
            "(x-coordinate, y-coordinate)",
            "",
            "For example:",
            "(1, 2)",
        ]
    ).strip()

    # The prompt for the edge
    edge_prompt = (
        "Please enter the {} point"
        + f"for the {edge_type} line."
        + f"\n\n{input_instructions}"
    )

    # The invalid input prompt
    invalid_input_prompt = (
        f"You have entered an invalid tuple.\n\n{input_instructions}"
    )

    # Initialise the list of vertices
    vertices = []

    # Iterate over the prompt variables
    for prompt_variable in prompt_variables:

        # Get the user's input for the coordinates
        user_input = get_user_input_text(
            screen,
            edge_prompt.format(prompt_variable),
            invalid_input_prompt,
            parse_user_given_coordinates,
        )

        # Add the user's input to the list of vertices
        vertices.append(user_input)

    # Initialise the dictionary to contain the edge
    edge_dict = {"vertices": vertices}

    # Get the other properties from the user
    other_properties = ask_for_other_properties(screen, state, title)

    # Add the other properties to the edge dictionary
    edge_dict.update(other_properties)

    # Add the edge dictionary to the data
    data.append(edge_dict)

    # If this function is the chosen input method,
    # then set the function to choose the edge type for the next edge
    # as the function to call
    if is_chosen_method:
        func_to_call = utils.call_without_args(
            choose_edge_type,
            screen,
            state,
            is_text_input_method=True,
            is_chosen_input_method=is_chosen_method,
            draw_instantly=draw_instantly,
            preview=preview,
            title=title,
        )

    # Otherwise,
    # set the function to choose the input method as the function to call
    else:
        func_to_call = utils.call_without_args(
            choose_input_method, screen, state, draw_instantly, preview, title
        )

    # If no preview is wanted, calls the function to call
    # and exit the function
    if not preview:
        return func_to_call()

    # Otherwise, push the function to call to the function stack
    utils.push_to_function_stack(state, func_to_call)

    # Get the logo dictionary
    logo_dict = get_manual_input_logo_dict(state)

    # Draw the logo
    draw_logo(logo_dict, screen, state, draw_instantly=True)


def draw_manual_input_logo(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the drawing of the manually inputted logo"

    # Get the logo dictionary for the manual input
    logo_dict = get_manual_input_logo_dict(state)

    # Calls the function to draw the logo
    handle_draw_logo(
        screen,
        state,
        logo_dict,
        draw_instantly=draw_instantly,
        preview=preview,
        title=title,
    )


def choose_edge_type(
    screen: turtle._Screen,
    state: dict,
    is_text_input_method: bool,
    is_chosen_input_method: bool = False,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the manual input to create a logo"

    # The prompt to ask the user what kind of line they want
    edge_type_prompt = "What kind of line do you want to add?"

    # The wrapped choose input method function
    wrapped_choose_input_method = utils.call_without_args(
        choose_input_method, screen, state, draw_instantly, preview, title
    )

    # Initialise the input method function
    input_method_func: Callable[..., None]

    # If the input method is text input
    if is_text_input_method:
        input_method_func = handle_text_input_method

    # Otherwise, it is the mouse input
    else:
        input_method_func = handle_mouse_input_method

    # The options dictionary for the edge type
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "A straight line",
            utils.call_without_args(
                input_method_func,
                screen,
                state,
                number_of_points=2,
                is_chosen_method=is_chosen_input_method,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        2: (
            "A curved line",
            utils.call_without_args(
                input_method_func,
                screen,
                state,
                number_of_points=4,
                is_chosen_method=is_chosen_input_method,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        3: (
            "I'm done, draw the logo",
            utils.call_without_args(
                draw_manual_input_logo,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        4: ("Choose a different input method", wrapped_choose_input_method),
    }

    # The list of strings for the prompt
    prompt_str_list = [
        edge_type_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Gets the desired action
    desired_action = get_desired_action(
        screen,
        prompt_str_list,
        options_dict,
        wrapped_choose_input_method,
        title,
    )

    # Calls the function for the desired action
    desired_action()


def choose_input_method(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to get the user's choice of input method"

    # The prompt for the input method
    input_method_prompt = (
        "Please choose what input method you would like to use."
    )

    # The wrapped handle custom logo function
    wrapped_handle_custom_logo = utils.call_without_args(
        handle_draw_custom_logo, screen, state, draw_instantly, preview, title
    )

    # The options dictionary
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Typing in the coordinates manually",
            utils.call_without_args(
                choose_edge_type,
                screen,
                state,
                is_text_input_method=True,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        2: (
            "Using the mouse to click on the points",
            utils.call_without_args(
                choose_edge_type,
                screen,
                state,
                is_text_input_method=False,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        3: (
            "Typing in the coordinates manually for all points",
            utils.call_without_args(
                choose_edge_type,
                screen,
                state,
                is_text_input_method=True,
                is_chosen_input_method=True,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        4: (
            "Using the mouse to click on the points for all points",
            utils.call_without_args(
                choose_edge_type,
                screen,
                state,
                is_text_input_method=False,
                is_chosen_input_method=True,
                draw_instantly=draw_instantly,
                preview=preview,
                title=title,
            ),
        ),
        5: ("Go back", wrapped_handle_custom_logo),
    }

    # Create the list containing the prompt
    prompt_str_list = [
        input_method_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the desired action
    desired_action = get_desired_action(
        screen, prompt_str_list, options_dict, wrapped_handle_custom_logo, title
    )

    # Calls the function for the desired action
    desired_action()


def handle_manual_input(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the manual input option"

    # Initialise the dictionary to store the user's logo
    manual_logo_dict: dict = {"data": []}

    # The skip instruction
    skip_instruction = 'Type "skip" to skip adding the background colour.'

    # The prompt for the background colour
    background_colour_prompt = [
        "What background colour would you like for the logo?",
        "",
        COLOUR_INPUT_INSTRUCTIONS,
        "",
        skip_instruction,
    ]

    # The invalid background colour prompt
    invalid_background_colour_prompt = (
        "The background colour you have given is invalid. "
        + "Please try again."
    )

    # Ask the user for the background colour
    background_colour = get_user_input_text(
        screen,
        background_colour_prompt,
        invalid_background_colour_prompt,
        parse_colour,
        title,
    )

    # If the background colour is not None, "skip", or "skip all"
    if background_colour not in ("skip", "skip all", None):

        # Set the background colour in the manual input logo dictionary
        manual_logo_dict["background_colour"] = background_colour

    # Set the manual input logo to the state
    set_manual_input_logo_dict(state, manual_logo_dict)

    # Set the shape is already filled variable to False
    set_shape_already_filled(state, False)

    # Set the number of vertices for the mouse input
    # to an empty list
    set_mouse_input_vertices(state, [])

    # Call the function to choose the input method
    choose_input_method(screen, state, draw_instantly, preview, title)


def handle_draw_custom_logo(
    screen: turtle._Screen,
    state: dict,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to handle the option of drawing the custom logo"

    # The prompt to ask the user if they want to manually input
    # or give a file
    custom_logo_prompt = "How to you want to draw a custom logo?"

    # The wrapped display main menu function
    wrapped_display_main_menu = utils.call_without_args(
        display_main_menu,
        screen,
        state,
        display_welcome_message=False,
        draw_instantly=draw_instantly,
        preview=preview,
        title=title,
    )

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Input the logo manually",
            utils.call_without_args(
                handle_manual_input,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        2: (
            "Load a logo file",
            utils.call_without_args(
                handle_load_logo_file,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        3: ("Go back", wrapped_display_main_menu),
    }

    # Initialise the list of strings for the prompt
    prompt_str_list = [
        custom_logo_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the user's desired action
    desired_action = get_desired_action(
        screen,
        prompt_str_list,
        options_dict,
        wrapped_display_main_menu,
        title,
    )

    # Calls the function to get the desired action
    desired_action()


def display_main_menu(
    screen: turtle._Screen,
    state: dict,
    display_welcome_message: bool = True,
    draw_instantly: bool = False,
    preview: bool = True,
    title: str = APP_NAME,
) -> None:
    "Function to display the main menu of the program"

    # The welcome message
    welcome_message = f"Welcome to {APP_NAME}, a program to draw logos!"

    # The prompt for the main menu
    main_menu_prompt = "What would you like to do?"

    # The dictionary of options
    options_dict: dict[int, tuple[str, Callable[[], None]]] = {
        1: (
            "Draw one of the 3 default logos",
            utils.call_without_args(
                handle_draw_default_logos,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        2: (
            "Draw a custom logo",
            utils.call_without_args(
                handle_draw_custom_logo,
                screen,
                state,
                draw_instantly,
                preview,
                title,
            ),
        ),
        3: ("Exit", utils.exit_program(screen)),
    }

    # Initialise the list of strings for the prompt.
    # The empty strings in the list is for new line characters
    prompt_str_list = [
        welcome_message if display_welcome_message else "",
        "",
        main_menu_prompt,
        "",
    ] + create_list_of_options(options_dict)

    # Get the user's desired action
    desired_action = get_desired_action(
        screen,
        prompt_str_list,
        options_dict,
        title=title,
    )

    # Calls the function for the desired action
    desired_action()
