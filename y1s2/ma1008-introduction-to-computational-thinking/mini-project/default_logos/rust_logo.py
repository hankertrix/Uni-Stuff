# The module containing the Rust Programming Language logo

import turtle
from decimal import Decimal

import math_utils
from draw_lib import draw_icon

# The width of the canvas
WIDTH = 106

# The height of the canvas
HEIGHT = 106

# The scaling factor for the logo
SCALE_FACTOR = math_utils.vec_3d_scale(5, 5)


def vec_2d(x: float | int, y: float | int) -> list[list[int | Decimal]]:
    """
    Function to create a 2D vector, with the origin at the centre.
    """
    return math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
        x, y, WIDTH, HEIGHT
    )


# The outer circle of the logo
outer_circle = math_utils.approximate_arc_as_bezier(
    vec_2d(53, 53),
    360,
    vec_2d(53, 6),
    angle_is_in_degrees=True,
    pen_colour="#000000",
    fill_colour="#000000",
)


# The inner circle of the logo
inner_circle = math_utils.approximate_arc_as_bezier(
    vec_2d(53, 53),
    360,
    vec_2d(53, 14),
    angle_is_in_degrees=True,
    pen_colour="#FFFFFF",
    fill_colour="#FFFFFF",
)


# The outer part of the character R in the logo
character_R_outer = [
    {
        "vertices": [
            vec_2d(18.5, 27.5),
            vec_2d(65.5, 27.5),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(65.5, 27.5),
            vec_2d(77.5, 27.5),
            vec_2d(86.5, 43.5),
            vec_2d(71.5, 51.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(71.5, 51.5),
            vec_2d(72.5, 51.5),
            vec_2d(76.5, 55.5),
            vec_2d(77.5, 60.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(77.5, 60.5),
            vec_2d(78.5, 65.5),
            vec_2d(87.5, 66.5),
            vec_2d(87.5, 58.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(87.5, 58.5),
            vec_2d(87.5, 56.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(87.5, 56.5),
            vec_2d(93.5, 56.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(93.5, 56.5),
            vec_2d(93.5, 75.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(93.5, 75.5),
            vec_2d(68.5, 75.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(68.5, 75.5),
            vec_2d(59.5, 75.5),
            vec_2d(65.5, 56.5),
            vec_2d(54.5, 56.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(54.5, 56.5),
            vec_2d(44.5, 56.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(44.5, 56.5),
            vec_2d(44.5, 64.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(44.5, 64.5),
            vec_2d(53.5, 64.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(53.5, 64.5),
            vec_2d(53.5, 75.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(53.5, 75.5),
            vec_2d(13.5, 75.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(13.5, 75.5),
            vec_2d(13.5, 64.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(13.5, 64.5),
            vec_2d(28.5, 64.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(28.5, 64.5),
            vec_2d(28.5, 38.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(28.5, 38.5),
            vec_2d(18.5, 38.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(18.5, 38.5),
            vec_2d(18.5, 27.5),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The inner part of the character R in the logo
character_R_inner = [
    {
        "vertices": [
            vec_2d(44.5, 38.5),
            vec_2d(57.5, 38.5),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(57.5, 38.5),
            vec_2d(65.5, 38.5),
            vec_2d(65.5, 46.5),
            vec_2d(57.5, 46.5),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(57.5, 46.5),
            vec_2d(44.5, 46.5),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(44.5, 46.5),
            vec_2d(44.5, 38.5),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The mount at the very top of the logo
mount = [
    {
        "vertices": [
            vec_2d(46.01, 8),
            vec_2d(60.01, 8),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(60.01, 8),
            vec_2d(62.51, 8),
            vec_2d(64.01, 11),
            vec_2d(62.01, 13),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(62.01, 13),
            vec_2d(55.01, 20),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(55.01, 20),
            vec_2d(53.51, 21.5),
            vec_2d(52.01, 21),
            vec_2d(51.01, 20),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(51.01, 20),
            vec_2d(44.01, 13),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(44.01, 13),
            vec_2d(42.01, 11),
            vec_2d(43.51, 8),
            vec_2d(46.01, 8),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The circle in the middle of the mount
mount_circle = math_utils.approximate_arc_as_bezier(
    vec_2d(53, 14),
    360,
    vec_2d(53, 11),
    angle_is_in_degrees=True,
    pen_colour="#FFFFFF",
    fill_colour="#FFFFFF",
)


def create_mounts() -> list[list]:
    """
    Function to create all of the mounts in the logo
    from the single mount at the very top of the logo.
    """

    # The original mount to transform,
    # which has the mount as well as the circle inside the mount.
    # The mount is before the mount circle as the mount must
    # be drawn first before the mount circle so the mount circle
    # can be hollowed out of the mount.
    original_mount = [mount, mount_circle]

    # Initialise the angle to 72 degrees
    angle = 72

    # The list of mounts
    list_of_mounts = [original_mount]

    # Iterates while the angle is less than or equal to 360 degrees
    while angle <= 360:

        # Gets the matrix for the rotation transformation
        rotation_matrix = math_utils.vec_3d_rotate(angle)

        # Get the transformed mount
        transformed_mount = math_utils.apply_transformations_to_vertices(
            [rotation_matrix], original_mount  # type: ignore [arg-type]
        )

        # Add the mount to the list of mounts
        list_of_mounts.append(transformed_mount)

        # Increase the angle by 72 degrees
        angle += 72

    # Return the list of mounts
    return list_of_mounts


# The cog at the very top of the logo
cog = [
    {
        "vertices": [
            vec_2d(54.01, 1),
            vec_2d(54.51, 1.5),
            vec_2d(56.01, 4.5),
            vec_2d(57.01, 6),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(57.01, 6),
            vec_2d(58.01, 7.5),
            vec_2d(57.01, 8.5),
            vec_2d(56.01, 8.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(56.01, 8.5),
            vec_2d(50.01, 8.5),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(50.01, 8.5),
            vec_2d(49.01, 8.5),
            vec_2d(48.01, 7.5),
            vec_2d(49.01, 6),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(49.01, 6),
            vec_2d(50.01, 4.5),
            vec_2d(51.51, 1.5),
            vec_2d(52.01, 1),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(52.01, 1),
            vec_2d(52.51, 0.5),
            vec_2d(53.51, 0.5),
            vec_2d(54.01, 1),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


def create_cogs() -> list[list]:
    """
    Function to create all of the cogs in the logo
    from the single mount cog at the very top of the logo.
    """

    # The original cog to transform
    original_cog = cog

    # Initialise the angle to 11.25 degrees
    angle = 11.25

    # Initialise the list of cogs
    list_of_cogs = [original_cog]

    # Iterate while the angle is less or equal to 360 degrees
    while angle <= 360:

        # Get rotation matrix for the transformation
        rotation_matrix = math_utils.vec_3d_rotate(angle)

        # Get the transformed cog
        transformed_cog = math_utils.apply_transformations_to_vertices(
            [rotation_matrix], original_cog  # type: ignore [arg-type]
        )

        # Add the cog to the list of cogs
        list_of_cogs.append(transformed_cog)

        # Increase the angle by 11.25 degrees
        angle += 11.25

    # Return the list of cogs
    return list_of_cogs


# The vertices in the logo
vertices = [
    outer_circle,
    inner_circle,
    character_R_outer,
    character_R_inner,
    create_mounts(),
    create_cogs(),
]


# Scale all of the vertices
scaled_vertices = math_utils.apply_transformations_to_vertices(
    [SCALE_FACTOR], vertices  # type: ignore [arg-type]
)


# The logo
logo = {"data": scaled_vertices, "background_colour": "#FFFFFF"}


def _test() -> None:
    "The function to test out drawing the logo"

    # Hide the cursor
    turtle.hideturtle()

    # Lift the pen up
    turtle.penup()

    # Draw the icon
    draw_icon(logo, draw_instantly=True)

    # Exit the turtle window on click
    turtle.exitonclick()


# Name safeguard
if __name__ == "__main__":
    _test()
