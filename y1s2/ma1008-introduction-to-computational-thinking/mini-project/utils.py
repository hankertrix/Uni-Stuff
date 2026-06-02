# The module containing the utilities used in the project

import turtle
from decimal import Decimal
from typing import Any, Callable

from constants import (BOTTOM_LEFT_BUFFER_IN_PIXELS, CANVAS_BUFFER_IN_PIXELS,
                       CONTINUE_LABEL, CONTINUE_LABEL_FONT,
                       WINDOW_BUFFER_IN_PIXELS)


def init_state() -> dict:
    "Function to initialise the state object for the entire program"

    # Turn off formatting for this dictionary.
    # fmt: off
    # The initial application state for the entire program.
    return {

        # The state for the file explorer
        "file_explorer_selected_item": None,
        "file_explorer_selected_item_index": 1,

        # The logo for the manual input
        "manual_logo_input": None,

        # The variable to tell whether the current shape
        # is already filled or not
        "shape_already_filled": None,

        # The variable to keep track of the vertices added
        "mouse_input_vertices": None,

        # The function stack to be pushed to and popped from.
        # During the running of the program, functions
        # will be added to this stack to be called later.
        "function_stack": [],
    }

    # Turn on formatting again
    # fmt: on


def push_to_function_stack(state: dict, func: Callable[..., None]) -> None:
    "Function to push to the function stack in the state dictionary"

    # Get the function stack
    function_stack = state.get("function_stack")

    # If the function stack doesn't exist, create the function stack
    if function_stack is None:

        # Set the function stack to an empty list
        function_stack = []

        # Add the function stack to the dictionary
        state["function_stack"] = function_stack

    # Push the function given to the function stack
    function_stack.append(func)


def pop_from_function_stack(
    state: dict, screen: turtle._Screen | None = None
) -> Callable[..., None]:
    "Function to pop the last function off of the function stack"

    # If the screen isn't given
    if screen is None:

        # Get the screen from turtle
        screen = turtle.Screen()

    # Get the function stack
    function_stack = state.get("function_stack")

    # If the function stack doesn't exist, return the exit program function
    if function_stack is None:
        return exit_program(screen)

    # If the function stack is empty, also return the exit program function
    if len(function_stack) < 1:
        return exit_program(screen)

    # Otherwise, return the last function off of the stack
    # and remove the function from the stack
    return function_stack.pop()


def init_turtle(
    width: float | int = 0.5,
    height: float | int = 0.75,
    start_x: int | None = None,
    start_y: int | None = None,
    *,
    resize_canvas: bool = True,
    window_buffer: int = WINDOW_BUFFER_IN_PIXELS,
) -> turtle._Screen:
    """
    Function to initialise turtle with the default settings.

    The given arguments are used to set up the screen and
    have the same default values as the screen.setup function.
    """

    # Initialise the turtle screen
    screen = turtle.Screen()

    # Set up the window with the given arguments
    screen.setup(width, height, start_x, start_y)

    # Hide the turtle cursor
    turtle.hideturtle()

    # Set turtle's speed to the fastest possible one
    turtle.speed(0)

    # Set the colour mode to 255 for RGB values
    # so RGB values are represented from 0 - 255
    turtle.colormode(255)

    # Put the pen up
    turtle.penup()

    # If the canvas shouldn't be resized,
    # return the screen immediately
    if not resize_canvas:
        return screen

    # If the width and height is an integer,
    # then set the canvas size to the given width and height
    # minus the window buffer
    if isinstance(width, int) and isinstance(height, int):
        screen.screensize(width - window_buffer, height - window_buffer)

    # Otherwise
    else:

        # Get the window width and height
        window_width, window_height = (
            screen.window_width(),
            screen.window_height(),
        )

        # Set the canvas size to be the
        # window buffer smaller than the window size
        screen.screensize(
            window_width - window_buffer, window_height - window_buffer
        )

    # Return the screen for the mouse click handler
    return screen


def init_application(
    width: float | int = 0.5,
    height: float | int = 0.75,
    start_x: int | None = None,
    start_y: int | None = None,
    *,
    resize_canvas: bool = True,
    window_buffer: int = WINDOW_BUFFER_IN_PIXELS,
) -> tuple[dict, turtle._Screen]:
    """
    The function to initialise the application
    and wraps the other initialisation functions.
    """

    # Initialise the application state
    state = init_state()

    # Initialise turtle and get the screen object
    screen = init_turtle(
        width,
        height,
        start_x,
        start_y,
        resize_canvas=resize_canvas,
        window_buffer=window_buffer,
    )

    # Return the state dictionary and the screen object
    return (state, screen)


def resize_screen(
    width: float | int | Decimal,
    height: float | int | Decimal,
    screen: turtle._Screen | None = None,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER_IN_PIXELS,
    always_resize: bool = False,
) -> None:
    """
    Function to resize the turtle screen.

    Takes an integer width and height, with the width
    representing the range of values on the x-axis,
    and the height representing the range of values on the
    y-axis.

    The screen variable takes a TurtleScreen object. If the object given
    is None, then it will use the turtle.screensize function.

    The buffer variable takes a number, and represents the amount of
    pixels to add to the width and height of the screen so that the icon
    can be drawn nicely.

    The always resize will always resize the screen, regardless of
    whether the current size of the screen is sufficient
    to draw the icon or not. It is by default False to have a better
    user experience.
    """

    # If the screen is not given, use the turtle module instead
    if screen is None:
        screen = turtle.Screen()

    # Change all the variables to a decimal
    width, height, canvas_buffer = (
        Decimal(width),
        Decimal(height),
        Decimal(canvas_buffer),
    )

    # Initialise the variables for the new width and height
    # and add the buffer to the them
    new_width: int = round(width + canvas_buffer)
    new_height: int = round(height + canvas_buffer)

    # If resizing is always wanted
    if always_resize:

        # Resize the window
        screen.setup(new_width + window_buffer, new_height + window_buffer)

        # Resize the canvas
        screen.screensize(
            new_width,
            new_height,
        )

        # Exit the function
        return

    # Gets the current canvas size
    current_width, current_height = [
        round(size) for size in turtle.screensize()
    ]

    # If the new width with the buffer is
    # smaller than the current width,
    # set the new width to the current width
    if new_width < current_width:
        new_width = current_width

    # If the new height with the buffer is
    # smaller than the current height,
    # set the new height to the current height
    if new_height < current_height:
        new_height = current_height

    # If the new width and height with the buffer are exactly the same
    # as the current width and height, don't resize the screen and
    # exit the function
    if (new_width, new_height) == (current_width, current_height):
        return

    # Resize the window with the new width and height
    screen.setup(new_width + window_buffer, new_height + window_buffer)

    # Resize the canvas with the new width and height
    screen.screensize(new_width, new_height)


def get_font_line_space(
    screen: turtle._Screen, font: tuple[str, int, str]
) -> int:
    "Function to get the font line space of a font"

    # Get the root of the screen object
    root = screen.getcanvas().winfo_toplevel()

    # Gets the line space of the font
    font_line_space = root.tk.getint(
        root.tk.call("font", "metrics", font, "-linespace")
    )

    # Returns the line space of the font
    return font_line_space


def get_bottom_left_of_screen(
    screen: turtle._Screen,
    buffer: float | int = BOTTOM_LEFT_BUFFER_IN_PIXELS,
) -> tuple[int, int]:
    "Function to get the coordinates of the bottom left of the screen"

    # Gets the current screen size
    width, height = screen.screensize()

    # Returns the bottom left of the screen
    return (round(-width / 2 + buffer), round(-height / 2 + buffer))


def draw_continue_label(
    screen: turtle._Screen | None = None,
    label: str = CONTINUE_LABEL,
    font: tuple[str, int, str] = CONTINUE_LABEL_FONT,
) -> None:
    "Function to draw the continue label"

    # If the screen is None, get the screen using turtle
    if screen is None:
        screen = turtle.Screen()

    # Get the initial turtle position
    initial_position = turtle.pos()

    # Get the initial pen colour
    initial_pen_colour = turtle.pencolor()

    # Get the bottom left of the screen
    bottom_left_of_screen = get_bottom_left_of_screen(screen)

    # Go to the bottom left of the screen
    turtle.goto(bottom_left_of_screen)

    # Change the turtle's colour to black
    turtle.color("black")

    # Write the label to the bottom left of the screen
    turtle.write(label, align="left", font=font)

    # Go back to the initial position
    turtle.goto(initial_position)

    # Set the pen colour to the initial colour
    turtle.pencolor(initial_pen_colour)


def call_without_args(
    func: Callable[..., Any], *args, **kwargs
) -> Callable[..., Any]:
    """
    The function to call a function without arguments by wrapping
    the actual function call in a function that takes no arguments.

    The first parameter called func is the function to call,
    and the arguments to the function can be passed in
    the rest of the parameters.
    """

    def wrapper(*dummy_args, **dummy_kwargs) -> None:
        """
        The wrapper function to return which calls the given
        function without arguments.

        The dummy arguments in this function is so that
        the function can take arguments if they are passed,
        but doesn't do anything with them.
        """
        return func(*args, **kwargs)

    # Return the wrapper function
    return wrapper


def exit_program(screen: turtle._Screen) -> Callable[..., None]:
    "The function to exit the program"

    def inner(*args, **kwargs) -> None:
        "The actual function to exit the program"

        # Exit the program
        screen.bye()

    # Return the inner function
    return inner


def return_none(*args, **kwargs) -> None:
    """
    Function to just literally return None.

    This function exists because lambda functions
    are not allowed. Extremely annoying prohibition.
    """
    return None


def exit_ui_component(screen: turtle._Screen, state: dict) -> None:
    "Function to clean up the screen and exit the UI component"

    # Clear the screen of all handlers and drawings
    screen.clear()

    # Hide the turtle
    turtle.hideturtle()

    # Lift the pen up
    turtle.penup()

    # Call the last function off the stack
    pop_from_function_stack(state, screen)()
