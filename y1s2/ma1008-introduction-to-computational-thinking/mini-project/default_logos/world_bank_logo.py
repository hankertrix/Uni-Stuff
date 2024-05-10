# The module containing the World Bank logo

import turtle
from decimal import Decimal

import math_utils
from draw_lib import draw_icon

# The width of the canvas
WIDTH = 320

# The height of the canvas
HEIGHT = 246.86

# The scaling factor for the logo
SCALE_FACTOR = math_utils.vec_3d_scale(3, 3)


def vec_2d(x: float | int, y: float | int) -> list[list[int | Decimal]]:
    """
    Function to create a 2D vector, with the origin at the centre.
    """
    return math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
        x, y, WIDTH, HEIGHT
    )


# The character T in the logo
character_T = [
    {
        "vertices": [
            vec_2d(28.37, 214.42),
            vec_2d(28.37, 218.62),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(28.37, 218.62),
            vec_2d(21.24, 218.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(21.24, 218.62),
            vec_2d(21.24, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(21.24, 235.94),
            vec_2d(15.69, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(15.69, 235.94),
            vec_2d(15.69, 218.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(15.69, 218.62),
            vec_2d(8.54, 218.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(8.54, 218.62),
            vec_2d(8.54, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(8.54, 214.42),
            vec_2d(28.37, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The character h in the logo
character_H = [
    {
        "vertices": [
            vec_2d(50.52, 214.42),
            vec_2d(50.52, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(50.52, 235.94),
            vec_2d(44.97, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(44.97, 235.94),
            vec_2d(44.97, 226.82),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(44.97, 226.82),
            vec_2d(36.78, 226.82),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(36.78, 226.82),
            vec_2d(36.78, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(36.78, 235.94),
            vec_2d(31.23, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(31.23, 235.94),
            vec_2d(31.23, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(31.23, 214.42),
            vec_2d(36.78, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(36.78, 214.42),
            vec_2d(36.78, 222.62),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(36.78, 222.62),
            vec_2d(44.97, 222.62),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(44.97, 222.62),
            vec_2d(44.97, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(44.97, 214.42),
            vec_2d(50.52, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The character E in the logo
character_E = [
    {
        "vertices": [
            vec_2d(70.94, 214.42),
            vec_2d(70.94, 218.62),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(70.94, 218.62),
            vec_2d(61.51, 218.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(61.51, 218.62),
            vec_2d(61.51, 222.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(61.51, 222.62),
            vec_2d(70.38, 222.62),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(70.38, 222.62),
            vec_2d(70.38, 226.82),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(70.38, 226.82),
            vec_2d(61.51, 226.82),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(61.51, 226.82),
            vec_2d(61.51, 231.75),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(61.51, 231.75),
            vec_2d(71.26, 231.75),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(71.26, 231.75),
            vec_2d(71.26, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(71.26, 235.94),
            vec_2d(55.96, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(55.96, 235.94),
            vec_2d(55.96, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(55.96, 214.42),
            vec_2d(70.94, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The character W in the logo
character_W = [
    {
        "vertices": [
            vec_2d(115.34, 214.42),
            vec_2d(110.26, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(110.26, 235.94),
            vec_2d(103.86, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(103.86, 235.94),
            vec_2d(99.96, 219.58),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(99.96, 219.58),
            vec_2d(96.09, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(96.09, 235.94),
            vec_2d(89.69, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(89.69, 235.94),
            vec_2d(84.58, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(84.58, 214.42),
            vec_2d(89.9, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(89.9, 214.42),
            vec_2d(93.61, 230.06),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(93.61, 230.06),
            vec_2d(97.3, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(97.3, 214.42),
            vec_2d(102.65, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(102.65, 214.42),
            vec_2d(106.34, 230.06),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(106.34, 230.06),
            vec_2d(110.06, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(110.06, 214.42),
            vec_2d(115.34, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The outer part of the character O in the logo
character_O_outer = [
    {
        "vertices": [
            vec_2d(128.81, 214.03),
            vec_2d(132.27, 214.03),
            vec_2d(134.98, 215.02),
            vec_2d(136.94, 217),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(136.94, 217),
            vec_2d(138.9, 218.98),
            vec_2d(139.88, 221.72),
            vec_2d(139.88, 225.2),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(139.88, 225.2),
            vec_2d(139.88, 228.68),
            vec_2d(138.9, 231.41),
            vec_2d(136.94, 233.39),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(136.94, 233.39),
            vec_2d(134.98, 235.37),
            vec_2d(132.27, 236.36),
            vec_2d(128.81, 236.36),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(128.81, 236.36),
            vec_2d(125.36, 236.36),
            vec_2d(122.65, 235.37),
            vec_2d(120.68, 233.39),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(120.68, 233.39),
            vec_2d(118.72, 231.41),
            vec_2d(117.74, 228.68),
            vec_2d(117.74, 225.2),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(117.74, 225.2),
            vec_2d(117.74, 221.72),
            vec_2d(118.72, 218.98),
            vec_2d(120.68, 217),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(120.68, 217),
            vec_2d(122.65, 215.02),
            vec_2d(125.36, 214.03),
            vec_2d(128.81, 214.03),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The inner part of the O character in the logo
character_O_inner = [
    {
        "vertices": [
            vec_2d(128.81, 218.05),
            vec_2d(130.52, 218.05),
            vec_2d(131.83, 218.68),
            vec_2d(132.76, 219.93),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(132.76, 219.93),
            vec_2d(133.7, 221.18),
            vec_2d(134.16, 222.94),
            vec_2d(134.16, 225.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(134.16, 225.2),
            vec_2d(134.16, 227.46),
            vec_2d(133.7, 229.22),
            vec_2d(132.76, 230.47),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(132.76, 230.47),
            vec_2d(131.83, 231.71),
            vec_2d(130.52, 232.34),
            vec_2d(128.81, 232.34),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(128.81, 232.34),
            vec_2d(127.12, 232.34),
            vec_2d(125.81, 231.71),
            vec_2d(124.88, 230.47),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.88, 230.47),
            vec_2d(123.95, 229.22),
            vec_2d(123.48, 227.46),
            vec_2d(123.48, 225.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(123.48, 225.2),
            vec_2d(123.48, 222.94),
            vec_2d(123.95, 221.18),
            vec_2d(124.88, 219.93),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.88, 219.93),
            vec_2d(125.81, 218.68),
            vec_2d(127.12, 218.05),
            vec_2d(128.81, 218.05),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The outer part of the character R in the logo
character_R_outer = [
    {
        "vertices": [
            vec_2d(158.77, 215.85),
            vec_2d(160.09, 216.8),
            vec_2d(160.76, 218.3),
            vec_2d(160.76, 220.36),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(160.76, 220.36),
            vec_2d(160.76, 221.78),
            vec_2d(160.41, 222.95),
            vec_2d(159.72, 223.86),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(159.72, 223.86),
            vec_2d(159.04, 224.78),
            vec_2d(158, 225.45),
            vec_2d(156.62, 225.88),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(156.62, 225.88),
            vec_2d(157.38, 226.05),
            vec_2d(158.06, 226.45),
            vec_2d(158.65, 227.06),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(158.65, 227.06),
            vec_2d(159.26, 227.67),
            vec_2d(159.87, 228.59),
            vec_2d(160.48, 229.83),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(160.48, 229.83),
            vec_2d(163.5, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(163.5, 235.94),
            vec_2d(157.59, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(157.59, 235.94),
            vec_2d(154.96, 230.6),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(154.96, 230.6),
            vec_2d(154.43, 229.52),
            vec_2d(153.9, 228.78),
            vec_2d(153.35, 228.39),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(153.35, 228.39),
            vec_2d(152.81, 228),
            vec_2d(152.09, 227.8),
            vec_2d(151.19, 227.8),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(151.19, 227.8),
            vec_2d(149.61, 227.8),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(149.61, 227.8),
            vec_2d(149.61, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(149.61, 235.94),
            vec_2d(144.06, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(144.06, 235.94),
            vec_2d(144.06, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(144.06, 214.42),
            vec_2d(152.54, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(152.54, 214.42),
            vec_2d(155.38, 214.42),
            vec_2d(157.45, 214.9),
            vec_2d(158.77, 215.85),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The inner part of the R character
character_R_inner = [
    {
        "vertices": [
            vec_2d(154.44, 219.08),
            vec_2d(154.95, 219.5),
            vec_2d(155.21, 220.2),
            vec_2d(155.21, 221.18),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(155.21, 221.18),
            vec_2d(155.21, 222.17),
            vec_2d(154.95, 222.88),
            vec_2d(154.44, 223.32),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(154.44, 223.32),
            vec_2d(153.94, 223.75),
            vec_2d(153.11, 223.96),
            vec_2d(151.95, 223.96),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(151.95, 223.96),
            vec_2d(149.61, 223.96),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(149.61, 223.96),
            vec_2d(149.61, 218.44),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(149.61, 218.44),
            vec_2d(151.95, 218.44),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(151.95, 218.44),
            vec_2d(153.11, 218.44),
            vec_2d(153.94, 218.66),
            vec_2d(154.44, 219.08),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The character L in the logo
character_L = [
    {
        "vertices": [
            vec_2d(172.33, 214.42),
            vec_2d(172.33, 231.75),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(172.33, 231.75),
            vec_2d(182.08, 231.75),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(182.08, 231.75),
            vec_2d(182.08, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(182.08, 235.94),
            vec_2d(166.78, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(166.78, 235.94),
            vec_2d(166.78, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(166.78, 214.42),
            vec_2d(172.33, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The outer part of the character D in the logo
character_D_outer = [
    {
        "vertices": [
            vec_2d(198.72, 215.13),
            vec_2d(200.33, 215.59),
            vec_2d(201.7, 216.38),
            vec_2d(202.85, 217.49),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(202.85, 217.49),
            vec_2d(203.86, 218.46),
            vec_2d(204.61, 219.58),
            vec_2d(205.1, 220.85),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(205.1, 220.85),
            vec_2d(205.59, 222.12),
            vec_2d(205.83, 223.56),
            vec_2d(205.83, 225.16),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(205.83, 225.16),
            vec_2d(205.83, 226.78),
            vec_2d(205.59, 228.24),
            vec_2d(205.1, 229.51),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(205.1, 229.51),
            vec_2d(204.61, 230.78),
            vec_2d(203.86, 231.9),
            vec_2d(202.85, 232.87),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(202.85, 232.87),
            vec_2d(201.69, 233.99),
            vec_2d(200.31, 234.78),
            vec_2d(198.7, 235.25),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(198.7, 235.25),
            vec_2d(197.08, 235.71),
            vec_2d(194.66, 235.94),
            vec_2d(191.43, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(191.43, 235.94),
            vec_2d(185.58, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(185.58, 235.94),
            vec_2d(185.58, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(185.58, 214.42),
            vec_2d(191.43, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(191.43, 214.42),
            vec_2d(194.7, 214.42),
            vec_2d(197.13, 214.66),
            vec_2d(198.72, 215.13),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The inner part of the character D in the logo
character_D_inner = [
    {
        "vertices": [
            vec_2d(198.32, 220.29),
            vec_2d(199.51, 221.4),
            vec_2d(200.11, 223.03),
            vec_2d(200.11, 225.16),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(200.11, 225.16),
            vec_2d(200.11, 227.3),
            vec_2d(199.51, 228.94),
            vec_2d(198.31, 230.06),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(198.31, 230.06),
            vec_2d(197.11, 231.19),
            vec_2d(195.39, 231.75),
            vec_2d(193.12, 231.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(193.12, 231.75),
            vec_2d(191.13, 231.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(191.13, 231.75),
            vec_2d(191.13, 218.62),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(191.13, 218.62),
            vec_2d(193.12, 218.62),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(193.12, 218.62),
            vec_2d(195.39, 218.62),
            vec_2d(197.13, 219.17),
            vec_2d(198.32, 220.29),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The outer part of the character B in the logo
character_B_outer = [
    {
        "vertices": [
            vec_2d(235.16, 215.78),
            vec_2d(236.51, 216.68),
            vec_2d(237.18, 218.13),
            vec_2d(237.18, 220.12),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(237.18, 220.12),
            vec_2d(237.18, 221.16),
            vec_2d(236.94, 222.06),
            vec_2d(236.45, 222.8),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(236.45, 222.8),
            vec_2d(235.96, 223.53),
            vec_2d(235.25, 224.07),
            vec_2d(234.31, 224.43),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(234.31, 224.43),
            vec_2d(235.51, 224.77),
            vec_2d(236.43, 225.41),
            vec_2d(237.08, 226.34),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(237.08, 226.34),
            vec_2d(237.73, 227.28),
            vec_2d(238.06, 228.42),
            vec_2d(238.06, 229.77),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(238.06, 229.77),
            vec_2d(238.06, 231.85),
            vec_2d(237.36, 233.4),
            vec_2d(235.96, 234.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(235.96, 234.42),
            vec_2d(234.55, 235.43),
            vec_2d(232.42, 235.94),
            vec_2d(229.56, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(229.56, 235.94),
            vec_2d(220.35, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(220.35, 235.94),
            vec_2d(220.35, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(220.35, 214.42),
            vec_2d(228.68, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(228.68, 214.42),
            vec_2d(231.67, 214.42),
            vec_2d(233.83, 214.87),
            vec_2d(235.16, 215.78),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The inner part of the character B in the logo
character_B_inner = [
    {
        "vertices": [
            vec_2d(230.96, 218.79),
            vec_2d(231.41, 219.17),
            vec_2d(231.63, 219.74),
            vec_2d(231.63, 220.48),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(231.63, 220.48),
            vec_2d(231.63, 221.23),
            vec_2d(231.41, 221.79),
            vec_2d(230.96, 222.18),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(230.96, 222.18),
            vec_2d(230.5, 222.56),
            vec_2d(229.84, 222.75),
            vec_2d(228.97, 222.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(228.97, 222.75),
            vec_2d(225.9, 222.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(225.9, 222.75),
            vec_2d(225.9, 218.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(225.9, 218.2),
            vec_2d(228.97, 218.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(228.97, 218.2),
            vec_2d(229.84, 218.2),
            vec_2d(230.5, 218.4),
            vec_2d(230.96, 218.79),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
    {
        "vertices": [
            vec_2d(231.68, 227.24),
            vec_2d(232.23, 227.7),
            vec_2d(232.51, 228.39),
            vec_2d(232.51, 229.33),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(232.51, 229.33),
            vec_2d(232.51, 230.28),
            vec_2d(232.23, 230.99),
            vec_2d(231.66, 231.46),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(231.66, 231.46),
            vec_2d(231.1, 231.93),
            vec_2d(230.27, 232.17),
            vec_2d(229.15, 232.17),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(229.15, 232.17),
            vec_2d(225.9, 232.17),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(225.9, 232.17),
            vec_2d(225.9, 226.53),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(225.9, 226.53),
            vec_2d(229.15, 226.53),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(229.15, 226.53),
            vec_2d(230.28, 226.53),
            vec_2d(231.12, 226.77),
            vec_2d(231.68, 227.24),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The outer part of the character A in the logo
character_A_outer = [
    {
        "vertices": [
            vec_2d(254.85, 214.42),
            vec_2d(262.83, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(262.83, 235.94),
            vec_2d(257.25, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(257.25, 235.94),
            vec_2d(255.89, 232.02),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(255.89, 232.02),
            vec_2d(247.21, 232.02),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(247.21, 232.02),
            vec_2d(245.85, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(245.85, 235.94),
            vec_2d(240.27, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(240.27, 235.94),
            vec_2d(248.24, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(248.24, 214.42),
            vec_2d(254.85, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The inner part of the character A in the logo
character_A_inner = [
    {
        "vertices": [
            vec_2d(251.55, 219.47),
            vec_2d(254.49, 228.03),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(254.49, 228.03),
            vec_2d(248.6, 228.03),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(248.6, 228.03),
            vec_2d(251.55, 219.47),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The character N in the logo
character_N = [
    {
        "vertices": [
            vec_2d(284.95, 214.42),
            vec_2d(284.95, 235.94),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(284.95, 235.94),
            vec_2d(278.75, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(278.75, 235.94),
            vec_2d(270.93, 221.18),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(270.93, 221.18),
            vec_2d(270.93, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(270.93, 235.94),
            vec_2d(265.66, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(265.66, 235.94),
            vec_2d(265.66, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(265.66, 214.42),
            vec_2d(271.86, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(271.86, 214.42),
            vec_2d(279.69, 229.18),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(279.69, 229.18),
            vec_2d(279.69, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(279.69, 214.42),
            vec_2d(284.95, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The character K in the logo
character_K = [
    {
        "vertices": [
            vec_2d(310.39, 214.42),
            vec_2d(300.03, 224.61),
        ],
        "pen_colour": "#4D4D4D",
        "fill_colour": "#4D4D4D",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(300.03, 224.61),
            vec_2d(311.46, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(311.46, 235.94),
            vec_2d(304.51, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(304.51, 235.94),
            vec_2d(295.95, 227.47),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(295.95, 227.47),
            vec_2d(295.95, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(295.95, 235.94),
            vec_2d(290.4, 235.94),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(290.4, 235.94),
            vec_2d(290.4, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(290.4, 214.42),
            vec_2d(295.95, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(295.95, 214.42),
            vec_2d(295.95, 222.28),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(295.95, 222.28),
            vec_2d(303.95, 214.42),
        ],
        "pen_colour": "#4D4D4D",
    },
    {
        "vertices": [
            vec_2d(303.95, 214.42),
            vec_2d(310.39, 214.42),
        ],
        "pen_colour": "#4D4D4D",
        "end_fill": True,
    },
]


# The outer circle in the globe icon
globe_icon_circle_outer = [
    {
        "vertices": [
            vec_2d(158.44, 11),
            vec_2d(184.13, 11),
            vec_2d(208.9, 21.17),
            vec_2d(227.3, 39.29),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(227.3, 39.29),
            vec_2d(245.71, 57.4),
            vec_2d(256.23, 81.96),
            vec_2d(256.57, 107.57),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(256.57, 107.57),
            vec_2d(256.9, 133.19),
            vec_2d(247.02, 157.75),
            vec_2d(229.09, 175.86),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(229.09, 175.86),
            vec_2d(211.17, 193.97),
            vec_2d(186.66, 204.15),
            vec_2d(160.97, 204.15),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(160.97, 204.15),
            vec_2d(135.28, 204.15),
            vec_2d(110.51, 193.97),
            vec_2d(92.11, 175.86),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(92.11, 175.86),
            vec_2d(73.71, 157.75),
            vec_2d(63.18, 133.19),
            vec_2d(62.84, 107.57),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(62.84, 107.57),
            vec_2d(62.51, 81.96),
            vec_2d(72.39, 57.4),
            vec_2d(90.32, 39.29),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(90.32, 39.29),
            vec_2d(108.25, 21.17),
            vec_2d(132.75, 11),
            vec_2d(158.44, 11),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The inner circle in the globe icon
globe_icon_circle_inner = [
    {
        "vertices": [
            vec_2d(159.11, 18),
            vec_2d(182.81, 18),
            vec_2d(205.65, 27.38),
            vec_2d(222.63, 44.09),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(222.63, 44.09),
            vec_2d(239.6, 60.79),
            vec_2d(249.31, 83.45),
            vec_2d(249.62, 107.07),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(249.62, 107.07),
            vec_2d(249.93, 130.7),
            vec_2d(240.82, 153.35),
            vec_2d(224.28, 170.06),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(224.28, 170.06),
            vec_2d(207.75, 186.76),
            vec_2d(185.15, 196.15),
            vec_2d(161.45, 196.15),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(161.45, 196.15),
            vec_2d(137.76, 196.15),
            vec_2d(114.91, 186.76),
            vec_2d(97.94, 170.06),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(97.94, 170.06),
            vec_2d(80.96, 153.35),
            vec_2d(71.25, 130.7),
            vec_2d(70.94, 107.07),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(70.94, 107.07),
            vec_2d(70.63, 83.45),
            vec_2d(79.75, 60.79),
            vec_2d(96.28, 44.09),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(96.28, 44.09),
            vec_2d(112.82, 27.38),
            vec_2d(135.42, 18),
            vec_2d(159.11, 18),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The topmost and leftmost globe segment
globe_segment_topmost_leftmost = [
    {
        "vertices": [
            vec_2d(135.09, 31.55),
            vec_2d(131.68, 38.36),
            vec_2d(127.1, 47.73),
            vec_2d(122.59, 55.83),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(122.59, 55.83),
            vec_2d(117.46, 53.79),
            vec_2d(111.78, 50.77),
            vec_2d(106.74, 47.7),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(106.74, 47.7),
            vec_2d(112.7, 42.31),
            vec_2d(120.19, 35.62),
            vec_2d(130.91, 31.82),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(130.91, 31.82),
            vec_2d(135.09, 31.55),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The top and leftmost globe segment
globe_segment_top_leftmost = [
    {
        "vertices": [
            vec_2d(119.29, 64.77),
            vec_2d(115.33, 76.52),
            vec_2d(111.96, 88.57),
            vec_2d(110.81, 101.72),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(110.81, 101.72),
            vec_2d(81.99, 102.25),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(81.99, 102.25),
            vec_2d(80.94, 83.91),
            vec_2d(89.29, 67.64),
            vec_2d(100.55, 54.52),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(100.55, 54.52),
            vec_2d(108.21, 59.35),
            vec_2d(113.97, 62.28),
            vec_2d(119.29, 64.77),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottom and leftmost globe segment
globe_segment_bottom_leftmost = [
    {
        "vertices": [
            vec_2d(110.31, 112.86),
            vec_2d(111.46, 126.01),
            vec_2d(114.83, 138.05),
            vec_2d(118.79, 149.8),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(118.79, 149.8),
            vec_2d(113.47, 152.29),
            vec_2d(107.71, 155.23),
            vec_2d(100.05, 160.06),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(100.05, 160.06),
            vec_2d(88.79, 146.94),
            vec_2d(80.44, 130.66),
            vec_2d(81.49, 112.33),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(81.49, 112.33),
            vec_2d(110.31, 112.86),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottommost and leftmost globe segment
globe_segment_bottommost_leftmost = [
    {
        "vertices": [
            vec_2d(122.09, 158.75),
            vec_2d(126.6, 166.84),
            vec_2d(131.18, 176.21),
            vec_2d(134.59, 183.03),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(134.59, 183.03),
            vec_2d(130.41, 182.76),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(130.41, 182.76),
            vec_2d(119.69, 178.96),
            vec_2d(112.2, 172.27),
            vec_2d(106.24, 166.87),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(106.24, 166.87),
            vec_2d(111.28, 163.81),
            vec_2d(116.96, 160.79),
            vec_2d(122.09, 158.75),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The topmost left segment of the globe
globe_segment_topmost_left = [
    {
        "vertices": [
            vec_2d(155.74, 27.83),
            vec_2d(155.62, 64.83),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(155.62, 64.83),
            vec_2d(149.01, 64.31),
            vec_2d(142.23, 62.82),
            vec_2d(131.37, 59.45),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(131.37, 59.45),
            vec_2d(137.06, 46.97),
            vec_2d(141.73, 37.89),
            vec_2d(151.37, 27.95),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(151.37, 27.95),
            vec_2d(155.74, 27.83),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The top left globe segment
globe_segment_top_left = [
    {
        "vertices": [
            vec_2d(155.87, 74.2),
            vec_2d(155.87, 101.95),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(155.87, 101.95),
            vec_2d(143.09, 101.44),
            vec_2d(132.18, 101.56),
            vec_2d(121.37, 101.7),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(121.37, 101.7),
            vec_2d(121.75, 90.73),
            vec_2d(123.9, 79.63),
            vec_2d(128.62, 68.33),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(128.62, 68.33),
            vec_2d(136.62, 70.92),
            vec_2d(145.23, 73.35),
            vec_2d(155.87, 74.2),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottom left globe segment
globe_segment_bottom_left = [
    {
        "vertices": [
            vec_2d(155.37, 112.62),
            vec_2d(155.37, 140.37),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(155.37, 140.37),
            vec_2d(144.73, 141.22),
            vec_2d(136.12, 143.65),
            vec_2d(128.12, 146.25),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(128.12, 146.25),
            vec_2d(123.4, 134.95),
            vec_2d(121.25, 123.84),
            vec_2d(120.87, 112.87),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(120.87, 112.87),
            vec_2d(131.68, 113.02),
            vec_2d(142.59, 113.13),
            vec_2d(155.37, 112.62),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottommost left globe segment
globe_segment_bottommost_left = [
    {
        "vertices": [
            vec_2d(155.12, 149.75),
            vec_2d(155.24, 186.75),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(155.24, 186.75),
            vec_2d(150.87, 186.62),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(150.87, 186.62),
            vec_2d(141.23, 176.69),
            vec_2d(136.56, 167.61),
            vec_2d(130.87, 155.12),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(130.87, 155.12),
            vec_2d(141.73, 151.75),
            vec_2d(148.51, 150.27),
            vec_2d(155.12, 149.75),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The topmost right globe segment
globe_segment_topmost_right = [
    {
        "vertices": [
            vec_2d(169.9, 27.45),
            vec_2d(179.54, 37.39),
            vec_2d(184.21, 46.47),
            vec_2d(189.9, 58.95),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(189.9, 58.95),
            vec_2d(179.03, 62.32),
            vec_2d(172.26, 63.81),
            vec_2d(165.65, 64.33),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.65, 64.33),
            vec_2d(165.53, 27.33),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.53, 27.33),
            vec_2d(169.9, 27.45),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The top right globe segment
globe_segment_top_right = [
    {
        "vertices": [
            vec_2d(192.65, 67.83),
            vec_2d(197.36, 79.13),
            vec_2d(199.52, 90.23),
            vec_2d(199.9, 101.2),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(199.9, 101.2),
            vec_2d(189.09, 101.06),
            vec_2d(178.18, 100.94),
            vec_2d(165.4, 101.45),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.4, 101.45),
            vec_2d(165.4, 73.7),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.4, 73.7),
            vec_2d(176.03, 72.85),
            vec_2d(184.65, 70.42),
            vec_2d(192.65, 67.83),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottom right globe segment
globe_segment_bottom_right = [
    {
        "vertices": [
            vec_2d(200.4, 112.37),
            vec_2d(200.02, 123.34),
            vec_2d(197.86, 134.45),
            vec_2d(193.15, 145.75),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(193.15, 145.75),
            vec_2d(185.15, 143.15),
            vec_2d(176.53, 140.72),
            vec_2d(165.9, 139.87),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.9, 139.87),
            vec_2d(165.9, 112.12),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(165.9, 112.12),
            vec_2d(178.68, 112.63),
            vec_2d(189.59, 112.52),
            vec_2d(200.4, 112.37),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottommost right globe segment
globe_segment_bottommost_right = [
    {
        "vertices": [
            vec_2d(190.4, 154.62),
            vec_2d(184.71, 167.11),
            vec_2d(180.04, 176.19),
            vec_2d(170.4, 186.12),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(170.4, 186.12),
            vec_2d(166.03, 186.25),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(166.03, 186.25),
            vec_2d(166.15, 149.25),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(166.15, 149.25),
            vec_2d(172.76, 149.77),
            vec_2d(179.53, 151.25),
            vec_2d(190.4, 154.62),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The topmost right globe segment
globe_segment_topmost_rightmost = [
    {
        "vertices": [
            vec_2d(190.36, 31.32),
            vec_2d(201.08, 35.12),
            vec_2d(208.56, 41.81),
            vec_2d(214.53, 47.2),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(214.53, 47.2),
            vec_2d(209.48, 50.27),
            vec_2d(203.81, 53.29),
            vec_2d(198.67, 55.33),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(198.67, 55.33),
            vec_2d(194.17, 47.23),
            vec_2d(189.59, 37.86),
            vec_2d(186.17, 31.05),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(186.17, 31.05),
            vec_2d(190.36, 31.32),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The top rightmost globe segment
globe_segment_top_rightmost = [
    {
        "vertices": [
            vec_2d(220.71, 54.02),
            vec_2d(231.98, 67.14),
            vec_2d(240.33, 83.41),
            vec_2d(239.28, 101.75),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(239.28, 101.75),
            vec_2d(210.46, 101.22),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(210.46, 101.22),
            vec_2d(209.31, 88.07),
            vec_2d(205.94, 76.02),
            vec_2d(201.98, 64.27),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(201.98, 64.27),
            vec_2d(207.3, 61.78),
            vec_2d(213.06, 58.85),
            vec_2d(220.71, 54.02),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottom rightmost globe segment
globe_segment_bottom_rightmost = [
    {
        "vertices": [
            vec_2d(239.78, 111.83),
            vec_2d(240.83, 130.16),
            vec_2d(232.48, 146.44),
            vec_2d(221.21, 159.56),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(221.21, 159.56),
            vec_2d(213.56, 154.73),
            vec_2d(207.8, 151.79),
            vec_2d(202.48, 149.3),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(202.48, 149.3),
            vec_2d(206.44, 137.55),
            vec_2d(209.81, 125.51),
            vec_2d(210.96, 112.36),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(210.96, 112.36),
            vec_2d(239.78, 111.83),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The bottommost rightmost globe segment
globe_segment_bottommost_rightmost = [
    {
        "vertices": [
            vec_2d(215.03, 166.37),
            vec_2d(209.06, 171.77),
            vec_2d(201.58, 178.46),
            vec_2d(190.86, 182.26),
        ],
        "pen_colour": "#000000",
        "fill_colour": "#000000",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(190.86, 182.26),
            vec_2d(186.67, 182.53),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(186.67, 182.53),
            vec_2d(190.09, 175.71),
            vec_2d(194.67, 166.34),
            vec_2d(199.17, 158.25),
        ],
        "pen_colour": "#000000",
    },
    {
        "vertices": [
            vec_2d(199.17, 158.25),
            vec_2d(204.31, 160.29),
            vec_2d(209.98, 163.31),
            vec_2d(215.03, 166.37),
        ],
        "pen_colour": "#000000",
        "end_fill": True,
    },
]


# The text in the logo
logo_text = [
    character_T,
    character_H,
    character_E,
    character_W,
    character_O_outer,
    character_O_inner,
    character_R_outer,
    character_R_inner,
    character_L,
    character_D_outer,
    character_D_inner,
    character_B_outer,
    character_B_inner,
    character_A_outer,
    character_A_inner,
    character_N,
    character_K,
]


# The icon in the logo
icon = [
    globe_icon_circle_outer,
    globe_icon_circle_inner,
    globe_segment_topmost_leftmost,
    globe_segment_top_leftmost,
    globe_segment_bottom_leftmost,
    globe_segment_bottommost_leftmost,
    globe_segment_topmost_left,
    globe_segment_top_left,
    globe_segment_bottom_left,
    globe_segment_bottommost_left,
    globe_segment_topmost_right,
    globe_segment_top_right,
    globe_segment_bottom_right,
    globe_segment_bottommost_right,
    globe_segment_topmost_rightmost,
    globe_segment_top_rightmost,
    globe_segment_bottom_rightmost,
    globe_segment_bottommost_rightmost,
]


# Scale all of the vertices
scaled_vertices = math_utils.apply_transformations_to_vertices(
    [SCALE_FACTOR], [icon, logo_text]  # type: ignore [arg-type]
)

# The full logo
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
