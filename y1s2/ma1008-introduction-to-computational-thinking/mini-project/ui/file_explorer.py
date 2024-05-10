# Module to draw a file explorer window using turtle

import os.path
import turtle
from typing import Callable

import utils
from constants import FONT, FONT_SPACING, WINDOW_BUFFER_IN_PIXELS

# The string for the parent directory
PARENT_DIRECTORY_STR = "🔙 Go to parent folder"


def get_selected_item(state: dict) -> str | None:
    "Function to get the selected item in the state dictionary"
    return state.get("file_explorer_selected_item")


def set_selected_item(state: dict, selected_item: str) -> None:
    "Function to set the selected item index in the state dictionary"
    state["file_explorer_selected_item"] = selected_item


def get_selected_item_index(state: dict) -> int:
    "Function to get the selected item in the state dictionary"
    return state.get("file_explorer_selected_item_index", 1)


def set_selected_item_index(state: dict, selected_item_index: int) -> None:
    "Function to set the selected item index in the state dictionary"
    state["file_explorer_selected_item_index"] = selected_item_index


def no_file_filter(filename: str) -> bool:
    """
    Function to just return True to not filter out any files.

    This function is here because lambda functions are not allowed.
    It's a really dumb rule, especially when it's goal is to try to
    prevent people from using ChatGPT to generate code.
    """
    return True


def get_directories_and_files(
    path: str, file_filter_func: Callable[[str], bool] = no_file_filter
) -> tuple[list[str], list[str]]:
    """
    Function that takes a path name and returns a tuple of the
    directories and the files present at the current path.

    The file filter function takes a string that is the
    file name, and returns a boolean indicating
    whether to include the item in the list of files.

    The first item of the tuple returned is the list of
    directories, and the second item is the list of files
    in the current directory.
    """

    # Gets the list of items in the directory
    directory_items = os.listdir(path)

    # Initialise the list of directories
    directory_list: list[str] = []

    # Initialise the list of files
    file_list: list[str] = []

    # Iterates over all the items in the current directory
    for item in directory_items:

        # Gets the absolute path of the items
        absolute_path = os.path.join(path, item)

        # If the item is not a file, add it to the list of directories
        if not os.path.isfile(absolute_path):
            directory_list.append(absolute_path)

        # Otherwise, if the item is a file that satisfies the
        # file filter function given
        elif file_filter_func(absolute_path):

            # Add the file to the list of files
            file_list.append(absolute_path)

    # Return the sorted list of directories and files
    return (sorted(directory_list), sorted(file_list))


def get_min_screen_size(
    directories: list[str],
    files: list[str],
    screen: turtle._Screen,
    font: tuple[str, int, str] = FONT,
    font_spacing: int = FONT_SPACING,
) -> tuple[int, int]:
    """
    Function to get the minimum screen size based coordinates
    range dictionary given.
    """

    # Gets the line space of the font
    font_line_space = utils.get_font_line_space(screen, font)

    # Gets the base name of all the items.
    # Remove the emoji part and the space from
    # the parent directory string
    directory_items = [
        os.path.basename(item)
        for item in [PARENT_DIRECTORY_STR[2:]] + directories + files
    ]

    # Get the minimum height of the screen
    min_height = len(directory_items) * (font_line_space + font_spacing)

    # Gets the longest string in the list of directory items
    longest_string = max(directory_items, key=len)

    # Disable screen updates so that the drawing operation is done instantly
    screen.tracer(False)

    # Go to the middle of the screen
    turtle.goto(0, 0)

    # Set the pen colour to the current background colour
    turtle.pencolor(screen.bgcolor())

    # Write the longest string with some additional characters in front
    # to make up for the emoji
    turtle.write(f"1234 {longest_string}", move=True, align="left", font=font)

    # Clear the screen
    turtle.clear()

    # Re-enable screen updates
    screen.tracer(True)

    # Get the minimum width
    min_width, _ = turtle.pos()

    # Returns the minimum width and height
    return (round(min_width), min_height)


def get_top_left_of_screen(
    screen: turtle._Screen,
) -> tuple[int, int]:
    "Function to get the coordinates of the top left of the screen"

    # Gets the current screen size
    width, height = screen.screensize()

    # Returns the top left of the screen
    return (round(-width / 2), round(height / 2))


def get_coord_range_dict(
    directory_list: list[str],
    file_list: list[str],
    screen: turtle._Screen,
    font: tuple[str, int, str] = FONT,
    font_spacing: int = FONT_SPACING,
    start_coordinates: tuple[int, int] | None = None,
) -> dict[tuple[int, int, range, range], str]:
    """
    Function to create a dictionary containing the coordinate range
    for the mouse click mapped to the file name.
    """

    # Gets the line space of the font
    font_line_space = utils.get_font_line_space(screen, font)

    # Gets the coordinates of the top left of the screen if the
    # start coordinates aren't given
    if start_coordinates is None:
        start_coordinates = get_top_left_of_screen(screen)

    # Initialise the x and top y variables to the start coordinates
    x, top_y = start_coordinates

    # Get the width of the screen
    screen_width, _ = turtle.screensize()

    # Get the minimum x coordinate
    min_x = round(-screen_width / 2)

    # Get the maximum x coordinate
    max_x = round(screen_width / 2)

    # The range of x coordinates
    range_x = range(min_x, max_x + 1)

    # Initialise the dictionary mapping the range to the string
    coord_range_dict: dict[tuple[int, int, range, range], str] = {}

    # Iterates over the directory list and the file list,
    # with the directory list coming before the file list
    for item in [PARENT_DIRECTORY_STR] + directory_list + file_list:

        # Gets the bottom y coordinate
        bot_y = round(top_y - font_line_space - font_spacing)

        # Get the range of y values
        range_y = range(bot_y, top_y + 1)

        # Map the tuple with the x and the bottom y coordinates
        # and the range to the file name.
        # The y coordinate takes the bottom value
        # as turtle draws the font above its current position
        coord_range_dict[(x, bot_y, range_x, range_y)] = item

        # Set the y coordinate to the next y value
        top_y = bot_y

    # Return the dictionary
    return coord_range_dict


def draw_highlight_box(range_x: range, range_y: range, colour: str) -> None:
    "Function to draw the highlighted box to indicate a selected item"

    # Get the coordinates to draw the box
    start_x = range_x[0]
    end_x = range_x[-1]
    start_y = range_y[0]
    end_y = range_y[-1]

    # Set the fill colour to the regular colour
    turtle.fillcolor(colour)

    # Go to the first point of the box
    turtle.goto(start_x, start_y)

    # Start the fill
    turtle.begin_fill()

    # Go to the rest of the points on the box
    turtle.goto(end_x, start_y)
    turtle.goto(end_x, end_y)
    turtle.goto(start_x, end_y)

    # Stop the fill
    turtle.end_fill()


def draw_directory_item(
    coords_and_range: tuple[int, int, range, range],
    directory_item: str,
    is_selected: bool = False,
    font: tuple[str, int, str] = FONT,
) -> None:
    """
    Function to draw a directory item based on whether
    it is a file or a directory.
    """

    # Take the pen up
    turtle.penup()

    # Initialise the item to write to the screen
    string = os.path.basename(directory_item)

    # Grabs the coordinates and ranges from the given tuple
    x, y, range_x, range_y = coords_and_range

    # If the item is a file
    if os.path.isfile(directory_item):

        # Add the emoji for a file before it
        string = f"📄 {string}"

        # Set the colour
        colour = "#373a41"

        # Set the inverted colour
        inverted_colour = "#f9f9f9"

    # Otherwise
    else:

        # If the directory item is not the go to parent folder item
        if directory_item not in [PARENT_DIRECTORY_STR]:

            # Add the folder emoji before it
            string = f"📁 {string}"

        # Set the colour
        colour = "#275fe4"

        # Set the inverted colour
        inverted_colour = "#d8a01b"

    # If the directory item is selected
    if is_selected:

        # Draw the highlight box
        draw_highlight_box(range_x, range_y, colour)

        # Set the pen colour to the inverted colour
        turtle.pencolor(inverted_colour)

    # Otherwise
    else:

        # Set the pen colour to the regular colour
        turtle.pencolor(colour)

    # Go to the coordinates
    turtle.goto(x, y)

    # Write the string on to the screen
    turtle.write(string, move=False, align="left", font=font)


def draw_file_explorer(
    screen: turtle._Screen,
    coord_range_dict: dict[tuple[int, int, range, range], str],
    selected_item_index: int = 1,
    font: tuple[str, int, str] = FONT,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
) -> None:
    """
    Function to draw the file explorer items in a turtle window.

    The font parameter takes a tuple with 3 items:
        1st item: The name of the font
        2nd item: The size of the font
        3rd item: The type of the font like "normal", "bold", or "italic".
    """

    # Clear the screen
    turtle.clear()

    # If the file explorer should be displayed all at once,
    # disable screen updates
    if show_all_at_once:
        screen.tracer(False)

    # Take up the pen
    turtle.penup()

    # Get the length of the coordinates and range dictionary
    coord_range_dict_length = len(coord_range_dict)

    # If the selected item index is greater than the length of
    # the coordinates and range dictionary, set the index
    # to 1 less than the length of the dictionary only if
    # the length of the dictionary is more than 1.
    # Otherwise, set the selected item index to 0
    if selected_item_index >= coord_range_dict_length:
        selected_item_index = (
            coord_range_dict_length - 1 if coord_range_dict_length > 1 else 0
        )

    # Iterates over the items in the coordinates and range dictionary
    for index, (coords_and_range, item) in enumerate(coord_range_dict.items()):

        # Get if the item is selected
        item_is_selected = index == selected_item_index

        # Draw the directory item
        draw_directory_item(coords_and_range, item, item_is_selected, font)

    # If screen updates have been disabled, re-enable them
    if show_all_at_once:
        screen.tracer(True)


def get_selected_item_from_selected_item_index(
    coord_range_dict: dict[tuple[int, int, range, range], str],
    selected_item_index: int,
) -> str:
    """
    Function to get the selected item from the coordinate range dictionary
    with the selected item index.
    """

    # Gets the values of the coordinate range dictionary
    coord_range_dict_values = list(coord_range_dict.values())

    # Return the selected item at that index
    return coord_range_dict_values[selected_item_index]


def handle_selected_item(
    screen: turtle._Screen,
    state: dict,
    file_filter_func: Callable[[str], bool] = no_file_filter,
    font: tuple[str, int, str] = FONT,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
    save: bool = False,
    given_selected_item: str | None = None,
) -> Callable[[], None]:
    "Function to handle the selection of an item"

    def inner() -> None:
        "The actual function to handle the selection of an item"

        # Initialise the selected item to the given
        # selected item
        selected_item = given_selected_item

        # If the given selected item is None
        if selected_item is None:
            selected_item = get_selected_item(state)

        # If the selected item is somehow still None, exit the function
        if selected_item is None:
            return

        # If the file explorer is saving the file
        if save:

            # Set the selected item to the current directory
            set_selected_item(state, os.getcwd())

            # Calls the clean up code and exit the file explorer
            return utils.exit_ui_component(screen, state)

        # If the selected item is not a directory
        if os.path.isfile(selected_item):

            # Set the selected item in the dictionary to the current item
            set_selected_item(state, selected_item)

            # Calls the clean up code and exit the file explorer
            return utils.exit_ui_component(screen, state)

        # Otherwise, check if the selected item is the parent directory item
        elif selected_item == PARENT_DIRECTORY_STR:

            # Change the current working directory to the parent directory
            os.chdir("..")

        # Otherwise, change the directory to the selected item
        else:
            os.chdir(selected_item)

        # Get the directory and files
        directories, files = get_directories_and_files(
            os.getcwd(), file_filter_func
        )

        # Get the minimum screen size
        min_width, min_height = get_min_screen_size(
            directories, files, screen, font, font_spacing
        )

        # Resize the window if necessary
        utils.resize_screen(min_width, min_height, screen, window_buffer)

        # Get the coordinates range dictionary for the new directory
        coord_range_dict = get_coord_range_dict(
            directories,
            files,
            screen,
            font,
            font_spacing,
        )

        # If the length of the coordinates range dictionary is 1 or less,
        # then set the selected item index to 0
        if len(coord_range_dict) <= 1:
            set_selected_item_index(state, 0)

        # Otherwise, set the selected item index to 1
        else:
            set_selected_item_index(state, 1)

        # Gets the selected item from the coordinates and range dictionary
        new_selected_item = get_selected_item_from_selected_item_index(
            coord_range_dict, get_selected_item_index(state)
        )

        # Update the selected item to the new one from
        # the coordinate range dictionary
        set_selected_item(state, new_selected_item)

        # Draw the file explorer
        draw_file_explorer(
            screen,
            coord_range_dict,
            get_selected_item_index(state),
            font,
            font_spacing,
            show_all_at_once,
        )

    # Return the inner function
    return inner


def handle_mouse_click(
    screen: turtle._Screen,
    state: dict,
    file_filter_func: Callable[[str], bool] = no_file_filter,
    font: tuple[str, int, str] = FONT,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
) -> Callable[[float, float], None]:
    "Function to handle a mouse click on the file explorer window"

    # Define the actual function to handle the mouse click
    def inner(x: float, y: float) -> None:

        # Get the coordinates range dictionary for the new directory
        coord_range_dict = get_coord_range_dict(
            *get_directories_and_files(os.getcwd(), file_filter_func),
            screen,
            font,
            font_spacing,
        )

        # Iterates over the items in the coordinates and range dictionary
        for ranges, item in coord_range_dict.items():

            # Get the range for the x coordinate and the y coordinate
            _, _, range_x, range_y = ranges

            # If the x and y coordinates are in the range
            if x in range_x and y in range_y:

                # Set the selected item
                set_selected_item(state, item)

                # Set the selected item back to 1
                set_selected_item_index(state, 1)

                # Call the function to handle the selected item
                # and exit the function
                return handle_selected_item(
                    screen,
                    state,
                    file_filter_func,
                    font,
                    window_buffer,
                    font_spacing,
                    show_all_at_once,
                )()

    # Return the inner function
    return inner


def handle_directional_keys(
    state: dict,
    screen: turtle._Screen,
    is_up: bool,
    file_filter_func: Callable[[str], bool] = no_file_filter,
    font: tuple[str, int, str] = FONT,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
    wrap: bool = False,
) -> Callable[[], None]:
    """
    Function to handle when the up or down keys are pressed.

    The is_up variable is a boolean that tells the
    function what direction the key is pressed.

    The wrap variable is to decide whether to wrap the selected item
    when going past the last item or first item in the list of items.
    By default, this option is set to False.
    """

    def inner() -> None:
        "The actual function to handle when the up or down keys are pressed"

        # Get the index of the selected item
        selected_item_index = get_selected_item_index(state)

        # Get the coordinates range dictionary for the current directory
        coord_range_dict = get_coord_range_dict(
            *get_directories_and_files(os.getcwd(), file_filter_func),
            screen,
            font,
            font_spacing,
        )

        # Get the number of items in the current directory
        num_of_items = len(coord_range_dict)

        # If the direction is up, subtract 1 from the selected item index
        if is_up:
            selected_item_index -= 1

        # Otherwise, add one to the selected item index
        else:
            selected_item_index += 1

        # If wrapping is wanted
        if wrap:

            # Wrap the selected item index using the modulo operator
            selected_item_index %= num_of_items

        # Otherwise
        else:

            # If the selected item index is less than 0, then set it to 0
            if selected_item_index < 0:
                selected_item_index = 0

            # Otherwise, if the selected item index
            # is more than or equal to the number of items,
            # set it to 1 less than the maximum number of items
            elif selected_item_index >= num_of_items:
                selected_item_index = num_of_items - 1

        # Set the selected item index in the state
        # to the new selected item index
        set_selected_item_index(state, selected_item_index)

        # Get the new selected item
        new_selected_item = get_selected_item_from_selected_item_index(
            coord_range_dict, get_selected_item_index(state)
        )

        # Set the new selected item
        set_selected_item(state, new_selected_item)

        # Draw the file explorer
        draw_file_explorer(
            screen,
            coord_range_dict,
            get_selected_item_index(state),
            font,
            font_spacing,
            show_all_at_once,
        )

    # Returns the inner function
    return inner


def attach_handlers(
    state: dict,
    screen: turtle._Screen,
    file_filter_func: Callable[[str], bool] = no_file_filter,
    font: tuple[str, int, str] = FONT,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
    wrap: bool = False,
) -> None:
    """
    Function to attach all the handlers to the file explorer screen
    """

    # Attach the mouse click handler
    screen.onclick(
        handle_mouse_click(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
        )
    )

    # Attach the handler for the up key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            True,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "Up",
    )

    # Attach the handler for the down key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            False,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "Down",
    )

    # Attach the handler for the k key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            True,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "k",
    )

    # Attach the handler for the j key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            False,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "j",
    )

    # Attach the handler for the k key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            True,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "w",
    )

    # Attach the handler for the j key
    screen.onkeypress(
        handle_directional_keys(
            state,
            screen,
            False,
            file_filter_func,
            font,
            font_spacing,
            show_all_at_once,
            wrap,
        ),
        "s",
    )

    # Attach the handler for the left key,
    # which is to go up to the parent directory
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
            given_selected_item=PARENT_DIRECTORY_STR,
        ),
        "Left",
    )

    # Attach the handler for the right key,
    # which is to enter a directory or pick an item
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
        ),
        "Right",
    )

    # Attach the handler for the h key,
    # which is to go up to the parent directory
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
            given_selected_item=PARENT_DIRECTORY_STR,
        ),
        "h",
    )

    # Attach the handler for the l key,
    # which is to enter a directory or pick an item
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
        ),
        "l",
    )

    # Attach the handler for the a key,
    # which is to go up to the parent directory
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
            given_selected_item=PARENT_DIRECTORY_STR,
        ),
        "a",
    )

    # Attach the handler for the d key,
    # which is to enter a directory or pick an item
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
        ),
        "d",
    )

    # Attach the handler for the enter key,
    # which is to enter a directory or pick an item
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
        ),
        "Return",
    )

    # Attach the handler for the c key
    # which is to return the current directory
    screen.onkeypress(
        handle_selected_item(
            screen,
            state,
            file_filter_func,
            font,
            window_buffer,
            font_spacing,
            show_all_at_once,
            save=True,
        ),
        "c",
    )

    # Listen for updates
    screen.listen()


def open_file_explorer(
    state: dict,
    screen: turtle._Screen | None = None,
    file_filter_func: Callable[[str], bool] = no_file_filter,
    font: tuple[str, int, str] = FONT,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    font_spacing: int = FONT_SPACING,
    show_all_at_once: bool = True,
    wrap: bool = False,
) -> None:
    "Function to open the file explorer"

    # If the screen isn't given, set the screen to the turtle one
    if screen is None:
        screen = turtle.Screen()

    # Get the list of directories and files
    directories, files = get_directories_and_files(
        os.getcwd(), file_filter_func
    )

    # Get the minimum screen size
    min_width, min_height = get_min_screen_size(
        directories, files, screen, font, font_spacing
    )

    # Resize the window if necessary
    utils.resize_screen(min_width, min_height, screen, window_buffer)

    # Get the coordinates and range dictionary
    coord_range_dict = get_coord_range_dict(
        directories, files, screen, font, font_spacing
    )

    # Get the selected item index
    selected_item_index = get_selected_item_index(state)

    # Get the selected item
    selected_item = get_selected_item_from_selected_item_index(
        coord_range_dict, selected_item_index
    )

    # Set the selected item in the state to the selected item
    set_selected_item(state, selected_item)

    # Attach all the handlers to the file explorer screen
    attach_handlers(
        state,
        screen,
        file_filter_func,
        font,
        window_buffer,
        font_spacing,
        show_all_at_once,
        wrap,
    )

    # Draw the file explorer
    draw_file_explorer(
        screen,
        coord_range_dict,
        get_selected_item_index(state),
        font,
        font_spacing,
        show_all_at_once,
    )


def _test() -> None:
    "The test function to test the file explorer"

    # Initialise the file explorer window
    screen = utils.init_turtle(resize_canvas=False)

    # Initialise the state object
    state = utils.init_state()

    # Open the file explorer
    open_file_explorer(state, screen, wrap=True)

    # Run the main loop
    screen.mainloop()


# Name safeguard
if __name__ == "__main__":
    _test()
