# The module to handle the drawing

import turtle
from decimal import Decimal
from typing import Any, cast

import math_utils
import utils
from constants import CANVAS_BUFFER_IN_PIXELS, WINDOW_BUFFER_IN_PIXELS

# The default number of segments
DEFAULT_NUMBER_OF_SEGMENTS = 100


def draw_cubic_bezier_curve(
    vertices: list[list[list[int | Decimal]]],
    number_of_segments: int | None = DEFAULT_NUMBER_OF_SEGMENTS,
    pen_remains_down: bool = False,
) -> None:
    """
    Function to draw a cubic Bezier curve.

    The number of segments determines how smooth the curve will look.
    The higher the number of segments, the smoother it'll look, but it'll
    probably also take a longer time to draw. It defaults to 100 segments.

    The pen_remains_down parameter determines whether the pen still be drawing
    after the drawing is completed. It is by default False.
    """

    # If the list of vertices doesn't have 4 points, raise an error
    if (num_of_vertices := len(vertices)) != 4:
        raise ValueError(
            "The list of vertices must have 4 points to draw a bezier curve. "
            f"{num_of_vertices} points are given instead"
        )

    # If the number of segments given is None, set it to 100
    if number_of_segments is None:
        number_of_segments = DEFAULT_NUMBER_OF_SEGMENTS

    # Get the 4 points
    point_1, point_2, point_3, point_4 = vertices

    # Iterates over the number of segments
    for i in range(number_of_segments + 1):

        # Gets the t value for the cubic Bezier equation
        t = Decimal(i / (number_of_segments))

        # Get the x value for the point
        x = (
            point_1[0][0] * (1 - t) ** 3
            + 3 * point_2[0][0] * t * (1 - t) ** 2
            + 3 * point_3[0][0] * t * t * (1 - t)
            + point_4[0][0] * t**3
        )

        # Get the y value for the point
        y = (
            point_1[1][0] * (1 - t) ** 3
            + 3 * point_2[1][0] * t * (1 - t) ** 2
            + 3 * point_3[1][0] * t * t * (1 - t)
            + point_4[1][0] * t**3
        )

        # Make the pen go to the point
        # The goto function takes a float,
        # so the decimal values are being converted to float
        turtle.goto(float(x), float(y))

        # Put the pen down if it is the first item
        if i == 0:
            turtle.pendown()

    # If the pen should not remain down, lift the pen up
    if not pen_remains_down:
        turtle.penup()


def draw_straight_edge(
    vertices: list[list[list[int | Decimal]]],
    pen_remains_down: bool = False,
) -> None:
    """
    Function to draw a straight edge.

    The pen_remains_down parameter determines whether the pen still be drawing
    after the drawing is completed. It is by default False.
    """

    # If the list of vertices doesn't have 2 points, raise an error
    if (num_of_vertices := len(vertices)) != 2:
        raise ValueError(
            "The list of vertices must have 4 points to draw a straight edge. "
            f"{num_of_vertices} points are given instead"
        )

    # Get the 2 points
    point_1, point_2 = vertices

    # Get the x and y coordinates of the first point
    x_1, y_1 = point_1[0][0], point_1[1][0]

    # Get the x and y coordinates of the first point
    x_2, y_2 = point_2[0][0], point_2[1][0]

    # Go to the first point
    turtle.goto(float(x_1), float(y_1))

    # Put the pen down
    turtle.pendown()

    # Go to the second point
    turtle.goto(float(x_2), float(y_2))

    # If the pen should not remain down, lift the pen up
    if not pen_remains_down:
        turtle.penup()


def is_straight_edge(vertices: list[list[list[int | Decimal]]]) -> bool:
    """
    Function to figure out if the list of vertices
    is a straight edge or a curved edge
    """

    # Gets the length of the list of vertices
    num_of_points = len(vertices)

    # If the list of vertices has only 2 points, then it is a straight edge
    if num_of_points == 2:
        return True

    # If the list of vertices has only 4 points, then it is a bezier curve
    elif num_of_points == 4:
        return False

    # Otherwise, raise an error
    else:
        raise ValueError(
            "Invalid list of vertices, "
            "expected a list of 2 points or 4 points. "
            f"Received a list of {num_of_points} points instead."
        )


def draw(data: dict | list | tuple) -> None:
    """
    The function to draw any edge.

    The function takes either a dictionary or a list.
    For a dictionary, the data structure should look like:

        {
            "vertices": list[list[list[int | Decimal]]],
            "fill_colour": Optional[tuple[int] | list[int] | str] = "blue",
            "pen_colour": Optional[tuple[int] | list[int] | str] = "red",
            "pen_size": Optional[int] = 1,
            "start_fill": Optional[bool] = True,
            "end_fill": Optional[bool] = False,
            "number_of_segments": Optional[int] = 100,
        }

        The vertices is a list of points, and the points
        are matrices of type list[[int | Decimal]] and is required.

        Fill colour, pen colour, pen size, start fill, end fill,
        and the number of segments are optional.

        The start fill property tells the function whether to start filling.
        If this is not set to True, the fill colour won't be used.

        The end fill property tells the function whether to stop the fill.

        The number of segments is the number of segments
        for drawing the bezier curve.

    For a list, the data structure should be a list of dictionaries
    like the one above or a list of a list of dictionaries
    like the one above.
    """

    # If the data given is a list or a tuple
    if isinstance(data, (list, tuple)):

        # Iterate over the items in the list or tuple
        # and call the function on the items
        for item in data:
            draw(item)

        # Exit the function
        return

    # Otherwise, if the data given is not a dictionary,
    # raise an error
    elif not isinstance(data, dict):
        raise ValueError(
            "The draw function expects a dictionary. "
            f"Received {repr(type(data))} instead"
        )

    # Otherwise, get the list of vertices from the dictionary
    vertices = data.get("vertices")

    # If the vertices is not a list or tuple, then raise an error
    if not isinstance(vertices, (list, tuple)):
        raise ValueError(
            "The list of vertices in the dictionary is not a list or a tuple. "
            f"Received {repr(type(vertices))} instead"
        )

    # Cast the vertices type to the correct type
    vertices = cast(list[list[list[int | Decimal]]], vertices)

    # Get the pen colour
    pen_colour = data.get("pen_colour", turtle.pencolor())

    # Get the pen size
    pen_size = data.get("pen_size", 1)

    # Get the number of segments
    number_of_segments = data.get(
        "number_of_segments", DEFAULT_NUMBER_OF_SEGMENTS
    )

    # Get the type of edge
    is_straight_edge_type = is_straight_edge(vertices)

    # Set the pen size
    turtle.pensize(pen_size)

    # Set the pen colour, fill colour and background colour
    turtle.pencolor(pen_colour)

    # If the turtle should start filling,
    # and the fill colour isn't None
    # and the turtle is not already filling,
    if (
        data.get("start_fill", False)
        and (fill_colour := data.get("fill_colour")) is not None
        and not turtle.filling()
    ):

        # Set the fill colour
        turtle.fillcolor(fill_colour)

        # Start the fill
        turtle.begin_fill()

    # If the edge is straight, call the draw_straight_edge function
    if is_straight_edge_type:
        draw_straight_edge(vertices)

    # Otherwise, call the draw_cubic_bezier_curve function
    else:
        draw_cubic_bezier_curve(vertices, number_of_segments)

    # If the filling should be stopped and the turtle is already filling
    if data.get("end_fill", False) and turtle.filling():

        # Stop the fill
        turtle.end_fill()

        # Set the fill colour to the transparent colour
        turtle.fillcolor("")


def get_min_and_max_coordinates_from_vertices(
    vertices: list[list[list[int | Decimal]]],
) -> tuple[int | Decimal, int | Decimal, int | Decimal, int | Decimal]:
    """
    Function to get the minimum and maximum coordinates when given a list
    of vertices.
    """

    # If the list of vertices is empty, then return a tuple of zeros
    if len(vertices) < 1:
        return (0, 0, 0, 0)

    # Initialise the variables to store the maximum and minimum
    # x and y values with the x and y values of the first vertex
    minimum_x: int | Decimal = vertices[0][0][0]
    maximum_x: int | Decimal = vertices[0][0][0]
    minimum_y: int | Decimal = vertices[0][1][0]
    maximum_y: int | Decimal = vertices[0][1][0]

    # Iterates over all the points after the first vertex
    for vertex in vertices[1:]:

        # Get the x and y values from the vector
        x_value = vertex[0][0]
        y_value = vertex[1][0]

        # If the x value is lower than the minimum x value,
        # set the minimum x value to the x value
        if x_value < minimum_x:
            minimum_x = x_value

        # If the x value is higher than the maximum x value,
        # set the maximum x value to the x value
        if x_value > maximum_x:
            maximum_x = x_value

        # If the y value is lower than the minimum y value,
        # set the minimum y value to the y value
        if y_value < minimum_y:
            minimum_y = y_value

        # If the y value is higher than the maximum y value,
        # set the maximum y value to the y value
        if y_value > maximum_y:
            maximum_y = y_value

    # Return the minimum and maximum x and y values
    return (minimum_x, maximum_x, minimum_y, maximum_y)


def get_min_and_max_coords_from_list_of_min_max_coords(
    list_of_min_max_coordinates: (
        list[list] | tuple[list] | list[tuple] | tuple[tuple] | list | tuple
    ),
) -> tuple[int | Decimal, int | Decimal, int | Decimal, int | Decimal]:
    """
    Function to get the minimum and maximum coordinates when given
    a list of minimum and maximum coordinates.
    """

    # If the list of minimum and maximum coordinates is empty,
    # then return a tuple of zeros
    if len(list_of_min_max_coordinates) < 1:
        return (0, 0, 0, 0)

    # If the list of minimum and maximum coordinates is list of lists,
    # return the result of the function call on the list of the function call
    # on the inner list
    elif isinstance(list_of_min_max_coordinates, list) and isinstance(
        list_of_min_max_coordinates[0], list
    ):
        return get_min_and_max_coords_from_list_of_min_max_coords(
            [
                get_min_and_max_coords_from_list_of_min_max_coords(item)
                for item in list_of_min_max_coordinates
            ]
        )

    # Initialise the variables to store the minimum and maximum
    # x and y values with the first minimum and maximum coordinates
    # in the list
    minimum_x: int | Decimal = list_of_min_max_coordinates[0][0]
    maximum_x: int | Decimal = list_of_min_max_coordinates[0][1]
    minimum_y: int | Decimal = list_of_min_max_coordinates[0][2]
    maximum_y: int | Decimal = list_of_min_max_coordinates[0][3]

    # Iterate over all the items in the list after the first one
    for min_x, max_x, min_y, max_y in list_of_min_max_coordinates[1:]:

        # If the current minimum x value is lower than the minimum x value,
        # set the minimum x value to the current minimum x value
        if min_x < minimum_x:
            minimum_x = min_x

        # If the current maximum x value is higher than the maximum x value,
        # set the maximum x value to the current maximum x value
        if max_x > maximum_x:
            maximum_x = max_x

        # If the current minimum y value is lower than the minimum y value,
        # set the minimum y value to the current minimum y value
        if min_y < minimum_y:
            minimum_y = min_y

        # If the current maximum y value is higher than the maximum y value,
        # set the maximum y value to the current maximum y value
        if max_y > maximum_y:
            maximum_y = max_y

    # Return the minimum and maximum coordinates
    return (minimum_x, maximum_x, minimum_y, maximum_y)


def get_min_and_max_coordinates_from_data(
    data: list[list[dict]] | list[dict] | dict,
) -> Any:
    """
    Function to get the minimum and maximum coordinates when given a dictionary
    containing the list of vertices.
    """

    # If the data given is a list or a tuple
    if isinstance(data, (list, tuple)):
        return [get_min_and_max_coordinates_from_data(item) for item in data]

    # Otherwise, if the data given not a dictionary,
    # raise an error
    if not isinstance(data, dict):
        raise ValueError(
            "This function expects a dictionary. "
            f"Received {repr(type(data))} instead"
        )

    # Otherwise, get the list of vertices
    vertices = data.get("vertices")

    # If the dictionary doesn't have the key called vertices,
    # raise an error
    if vertices is None:
        raise ValueError(
            "This function expects the dictionary "
            "to contain a list of vertices. "
            "The given dictionary doesn't contain a list of vertices."
        )

    # Returns the result of the get_min_and_max_coordinates_from_vertices
    # function
    return get_min_and_max_coordinates_from_vertices(vertices)


def get_min_screen_size(
    data: list[list[dict]] | list[dict] | dict,
) -> tuple[int | Decimal, int | Decimal]:
    "Function to get the minimum screen size to draw the given list of vertices"

    # Get the maximum and minimum x and y values
    # from the get_min_and_max_coordinates function
    min_max_coordinates = get_min_and_max_coordinates_from_data(data)

    # If the return value is a list
    if isinstance(min_max_coordinates, list):

        # Initialise the variables to store the maximum and minimum
        # x and y values
        minimum_x, maximum_x, minimum_y, maximum_y = (
            get_min_and_max_coords_from_list_of_min_max_coords(
                min_max_coordinates
            )
        )

    # Otherwise
    else:

        # Set the minimum and maximum x and y values to the
        # return value of get_min_and_max_coordinates function
        minimum_x, maximum_x, minimum_y, maximum_y = min_max_coordinates

    # Calculate the minimum width of the screen
    min_width = (
        max(  # type: ignore [call-overload]
            abs(minimum_x),
            abs(maximum_x),
        )
        * 2
    )

    # Calculate the minimum height of the screen
    min_height = (
        max(  # type: ignore [call-overload]
            abs(minimum_y),
            abs(maximum_y),
        )
        * 2
    )

    # Returns the minimum width and height as a tuple
    return (min_width, min_height)


def draw_icon(
    icon: dict,
    screen: turtle._Screen | None = None,
    draw_instantly: bool = False,
    canvas_buffer: float | int | Decimal = CANVAS_BUFFER_IN_PIXELS,
    window_buffer: float | int = WINDOW_BUFFER_IN_PIXELS,
) -> None:
    """
    Function to draw an icon.

    The icon dictionary passed must have
    a key called "data" that contains all the
    data for drawing the icon, which includes the list
    of dictionaries containing the vertices and the colours.
    The icon dictionary can also have a key called
    "background_colour" to specify a background colour
    for the icon being drawn.

    Example icon dictionary:
    {
        "data": dict,
        "background_colour": Optional[tuple[int] | list[int] | str] = "white"
    }

    The draw_instantly parameter passed to this function also makes
    it possible to draw an icon instantly, as it can disable screen updates
    for all of the calls to the drawing function,
    which will make the icon display instantly.

    The canvas_buffer and window_buffer parameters are simply passed
    to the resize screen function.

    This function is just to pull out the icon data from the dictionary
    and set the background colour if necessary. The drawing
    is done using another function.
    """

    # Get the screen object
    screen = screen if screen is not None else turtle.Screen()

    # If the icon should be drawn instantly
    if draw_instantly:

        # Disable screen updates
        screen.tracer(False)

    # Gets the data from the dictionary
    icon_data = icon.get("data")

    # If the icon data is None, raise an error
    if icon_data is None:
        raise ValueError(
            'This function expects a dictionary with a key called "data" '
            "that contains the icon data for the function to draw. "
            "Please provide a valid icon dictionary."
        )

    # Get the minimum screen size to draw the icon
    min_width, min_height = get_min_screen_size(icon_data)

    # Resize the screen if necessary
    utils.resize_screen(
        min_width, min_height, screen, window_buffer, canvas_buffer
    )

    # Get the background colour
    background_colour = icon.get("background_colour", screen.bgcolor())

    # Set the background colour
    screen.bgcolor(background_colour)

    # Draw the icon using the icon data
    draw(icon_data)

    # If screen updates have been disabled, re-enable them
    if draw_instantly:
        screen.tracer(True)


def _test() -> None:
    "Function to test the drawing library."

    # Initialise the turtle module
    utils.init_turtle()

    # Approximate an circle as a bezier
    circle = math_utils.approximate_arc_as_bezier(
        math_utils.vec_2d(0, 0),
        math_utils.math_pi,
        start_angle=0,
        radius=500,
        pen_size=5,
    )

    draw(circle)

    # Approximate an circle as a bezier
    circle = math_utils.approximate_arc_as_bezier(
        math_utils.vec_2d(0, 0),
        math_utils.math_pi / 3,
        math_utils.vec_2d(0, 500),
        pen_colour="blue",
        pen_size=3,
    )

    draw(circle)

    # The four points for the bezier curve
    point_1 = [[200], [-100]]
    point_2 = [[-100], [0]]
    point_3 = [[100], [200]]
    point_4 = [[-150], [100]]

    # Put the points into a dictionary
    edge = {
        "vertices": [point_1, point_2, point_3, point_4],
        "pen_colour": [255, 0, 0],
    }

    # Draw the bezier curve
    draw(edge)


# Name safeguard
if __name__ == "__main__":
    _test()
