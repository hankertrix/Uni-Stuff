# The module to draw the title screen

import turtle

import utils
from constants import (APP_NAME, CONTINUE_LABEL, CONTINUE_LABEL_FONT,
                       FONT_FAMILY)
from ui.main_menu import display_main_menu

# The colours for the icon of the title screen
COLOURS = [
    "black",
    "magenta",
    "pink",
    "blue",
    "green",
    "yellow",
    "orange",
    "red",
]

# The initial width and height of the screen
INITIAL_SCREEN_SIZE = (600, 1000)

# The font for the title
TITLE_FONT = (FONT_FAMILY, 40, "bold")

# The y coordinate of the title
TITLE_Y_COORD = 350


def draw_title(
    x_coord: float | int = 0,
    y_coord: float | int = TITLE_Y_COORD,
    title: str = APP_NAME,
    font: tuple[str, int, str] = TITLE_FONT,
) -> None:
    "Function to draw the title of the application"

    # Gets the initial position
    initial_position = turtle.pos()

    # Go to the given coordinates
    turtle.goto(x_coord, y_coord)

    # Draw the title at the given coordinates
    turtle.write(title, align="center", font=font)

    # Go back to the initial position
    turtle.goto(initial_position)


def draw_icon(
    screen: turtle._Screen,
    x_coord: float | int = 0,
    y_coord: float | int = 0,
    show_all_at_once: bool = False,
    speed: float | int = 0,
) -> None:
    """
    Function to draw the title screen icon.

    It takes the x and y coordinates to draw the icon,
    which defaults to (0, 0).

    The show all at once option just stops the screen
    from updating until the icon is drawn, so the process of the
    circles being drawn isn't shown.
    """

    # If the icon is to be shown all at once,
    # stop automatic screen updates
    if show_all_at_once:
        screen.tracer(False)

    # Get the initial width
    initial_width = turtle.width()

    # Get the initial position
    initial_position = turtle.pos()

    # Get the initial speed
    initial_speed = turtle.speed()

    # Go to the given coordinates
    turtle.goto(x_coord, y_coord)

    # Set the width to 6
    turtle.width(6)

    # Set the speed to the speed given
    turtle.speed(speed)

    # Set the pen down
    turtle.pendown()

    # Iterates over the colours in the list
    for colour in COLOURS:

        # Set the fill colour to the colour
        turtle.fillcolor(colour)

        # Begin the fill
        turtle.begin_fill()

        # Draw the biggest circle
        turtle.circle(145)

        # Draw the second largest circle
        turtle.circle(130, -360)

        # Draw the second smallest circle
        turtle.circle(115)

        # Draw the smallest circle
        turtle.circle(100, -360)

        # End the fill
        turtle.end_fill()

        # Turn the turtle 45 degrees clockwise
        turtle.right(45)

    # Lift the pen up
    turtle.penup()

    # Set the fill colour to nothing
    turtle.fillcolor("")

    # Set the turtle speed to the initial speed
    turtle.speed(initial_speed)

    # Set the turtle's width back to the initial width
    turtle.width(initial_width)

    # Go back to the initial position
    turtle.goto(initial_position)

    # Enable screen updates again if screen updates
    # have been disabled
    if show_all_at_once:
        screen.tracer(True)


def display_title_screen(
    state: dict,
    screen: turtle._Screen,
    title_x_coord: float | int = 0,
    title_y_coord: float | int = TITLE_Y_COORD,
    title: str = APP_NAME,
    title_font: tuple[str, int, str] = TITLE_FONT,
    icon_x_coord: float | int = 0,
    icon_y_coord: float | int = 0,
    show_all_at_once: bool = False,
    speed: float | int = 0,
    continue_label: str = CONTINUE_LABEL,
    continue_label_font: tuple[str, int, str] = CONTINUE_LABEL_FONT,
) -> None:
    "Function to display the title screen"

    # Draw the title
    draw_title(title_x_coord, title_y_coord, title, title_font)

    # Draw the icon
    draw_icon(screen, icon_x_coord, icon_y_coord, show_all_at_once, speed)

    # Draw the continue label
    utils.draw_continue_label(screen, continue_label, continue_label_font)

    # The function to handle any interactions
    handle_interaction = utils.call_without_args(
        utils.exit_ui_component, screen, state
    )

    # Attach handlers to handle any interaction with the title screen
    screen.onkeypress(handle_interaction)
    screen.onclick(handle_interaction)

    # Listen for updates
    screen.listen()


def _test() -> None:
    "Function to test the title screen"

    # Initialise the application state
    state = utils.init_state()

    # Initialise the turtle
    screen = utils.init_turtle()

    # Draw the title screen
    display_title_screen(state, screen)

    # Runs the main loop
    screen.mainloop()


# Name safeguard
if __name__ == "__main__":
    _test()
