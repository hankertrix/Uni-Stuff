# The module to handle the drawing

import turtle
import typing
from decimal import Decimal

# The default number of segments
DEFAULT_NUMBER_OF_SEGMENTS = 100


def init_turtle() -> None:
    "Function to initialise turtle with the default settings"

    # Hide the turtle cursor
    turtle.hideturtle()

    # Set turtle's speed to the fastest possible one
    turtle.speed(0)

    # Set the colour mode to 255 for RGB values
    # so RGB values are represented from 0 - 255
    turtle.colormode(255)

    # Put the pen up
    turtle.penup()


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


def get_edge_type(vertices: list[list[list[int | Decimal]]]) -> str:
    "Function to figure out the type of vertices if the type isn't given"

    # Gets the length of the list of vertices
    num_of_points = len(vertices)

    # If the list of vertices has only 2 points, then it is a straight edge
    if num_of_points == 2:
        return "straight"

    # If the list of vertices has only 4 points, then it is a bezier curve
    elif num_of_points == 4:
        return "bezier"

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
            "fill_colour": tuple[int] | list[int] | str = "blue",
            "pen_colour": tuple[int] | list[int] | str = "red",
            "pen_size": int = 1,
            "number_of_segments": int = 100,
        }

        The vertices is a list of points, and the points
        are matrices of type list[[int | Decimal]] and is required.

        Fill colour, pen colour, pen size,
        and the number of segments are optional.

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
    vertices = typing.cast(list[list[list[int | Decimal]]], vertices)

    # Get the fill colour
    fill_colour = data.get("fill_colour", "")

    # Get the pen colour
    pen_colour = data.get("pen_colour", turtle.pencolor())

    # Get the pen size
    pen_size = data.get("pen_size", turtle.pensize())

    # Get the number of segments
    number_of_segments = data.get("number_of_segments")

    # Get the type of edge
    edge_type = get_edge_type(vertices)

    # Set the pen size
    turtle.pensize(pen_size)

    # Set the pen colour and fill colour
    turtle.fillcolor(fill_colour)
    turtle.pencolor(pen_colour)

    # Start the fill
    turtle.begin_fill()

    # If the edge is straight, call the draw_straight_edge function
    if edge_type == "straight":
        draw_straight_edge(vertices)

    # Otherwise, call the draw_cubic_bezier_curve function
    else:
        draw_cubic_bezier_curve(vertices, number_of_segments)

    # Stop the fill
    turtle.end_fill()


def main() -> None:
    "Function to test the drawing library."

    # Initialise the turtle module
    init_turtle()

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
    main()
