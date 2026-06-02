# The module containing the CERN logo

import turtle
from decimal import Decimal

import math_utils
from draw_lib import draw_icon

# The width of the canvas
WIDTH = 316.23

# The height of the canvas
HEIGHT = 316.23

# The scaling factor for the logo
SCALE_FACTOR = math_utils.vec_3d_scale(3, 3)


def vec_2d(x: float | int, y: float | int) -> list[list[int | Decimal]]:
    """
    Function to create a 2D vector, with the origin at the centre.
    """
    return math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
        x, y, WIDTH, HEIGHT
    )


# The background of the logo
logo_background = [
    {
        "vertices": [
            vec_2d(0, 0),
            vec_2d(WIDTH, 0),
        ],
        "pen_colour": "#1E59AE",
        "fill_colour": "#1E59AE",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(WIDTH, 0),
            vec_2d(WIDTH, HEIGHT),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(WIDTH, HEIGHT),
            vec_2d(0, HEIGHT),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(0, HEIGHT),
            vec_2d(0, 0),
        ],
        "pen_colour": "#1E59AE",
        "end_fill": True,
    },
]


# The character C in the logo
character_C = [
    {
        "vertices": [
            vec_2d(92.59, 111.92),
            vec_2d(91.91, 113.43),
            vec_2d(91.35, 115.42),
            vec_2d(91.11, 116.67),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(91.11, 116.67),
            vec_2d(90.76, 116.8),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(90.76, 116.8),
            vec_2d(88.23, 114.01),
            vec_2d(84.18, 111.59),
            vec_2d(78.17, 111.59),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(78.17, 111.59),
            vec_2d(70.55, 111.59),
            vec_2d(61.78, 117.75),
            vec_2d(61.78, 130.06),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(61.78, 130.06),
            vec_2d(61.78, 142.03),
            vec_2d(70.72, 148.4),
            vec_2d(78.71, 148.4),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(78.71, 148.4),
            vec_2d(85.89, 148.4),
            vec_2d(89.32, 145.05),
            vec_2d(92.4, 142.44),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(92.4, 142.44),
            vec_2d(92.64, 142.68),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(92.64, 142.68),
            vec_2d(91.77, 147.33),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(91.77, 147.33),
            vec_2d(90.35, 148.4),
            vec_2d(85.45, 151.46),
            vec_2d(78.07, 151.46),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(78.07, 151.46),
            vec_2d(64.71, 151.46),
            vec_2d(55.61, 143.03),
            vec_2d(55.61, 130.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(55.61, 130.2),
            vec_2d(55.61, 117.44),
            vec_2d(65.26, 108.95),
            vec_2d(78.38, 108.95),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(78.38, 108.95),
            vec_2d(83.49, 108.95),
            vec_2d(89.33, 110.53),
            vec_2d(92.59, 111.92),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The character E in the logo
character_E = [
    {
        "vertices": [
            vec_2d(99.31, 109.75),
            vec_2d(99.56, 114.79),
            vec_2d(99.8, 119.95),
            vec_2d(99.8, 125.06),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(99.8, 125.06),
            vec_2d(99.8, 135.27),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(99.8, 135.27),
            vec_2d(99.8, 140.37),
            vec_2d(99.55, 145.54),
            vec_2d(99.31, 150.71),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(99.31, 150.71),
            vec_2d(102.94, 150.52),
            vec_2d(108.49, 150.41),
            vec_2d(112.11, 150.41),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(112.11, 150.41),
            vec_2d(112.64, 150.41),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(112.64, 150.41),
            vec_2d(113.88, 150.41),
            vec_2d(115.46, 150.43),
            vec_2d(117.07, 150.46),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(117.07, 150.46),
            vec_2d(119.88, 150.51),
            vec_2d(122.85, 150.59),
            vec_2d(124.97, 150.7),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.97, 150.7),
            vec_2d(124.89, 150.08),
            vec_2d(124.86, 149.42),
            vec_2d(124.86, 148.52),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.86, 148.52),
            vec_2d(124.86, 147.62),
            vec_2d(124.92, 146.69),
            vec_2d(124.99, 146.24),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.99, 146.24),
            vec_2d(120.94, 146.61),
            vec_2d(109.82, 146.95),
            vec_2d(105.48, 147.01),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(105.48, 147.01),
            vec_2d(105.4, 145.93),
            vec_2d(105.31, 133.09),
            vec_2d(105.41, 131.1),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(105.41, 131.1),
            vec_2d(107.15, 131.1),
            vec_2d(116.32, 131.22),
            vec_2d(120.41, 131.64),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(120.41, 131.64),
            vec_2d(120.3, 131.04),
            vec_2d(120.24, 130.16),
            vec_2d(120.24, 129.57),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(120.24, 129.57),
            vec_2d(120.24, 128.98),
            vec_2d(120.3, 127.91),
            vec_2d(120.41, 127.32),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(120.41, 127.32),
            vec_2d(116.91, 127.61),
            vec_2d(112.42, 127.91),
            vec_2d(105.41, 127.91),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(105.41, 127.91),
            vec_2d(105.41, 126.42),
            vec_2d(105.52, 115.6),
            vec_2d(105.59, 113.04),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(105.59, 113.04),
            vec_2d(113.31, 113.04),
            vec_2d(120.29, 113.52),
            vec_2d(124.2, 113.82),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.2, 113.82),
            vec_2d(124.13, 113.41),
            vec_2d(124.05, 112.58),
            vec_2d(124.05, 111.77),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.05, 111.77),
            vec_2d(124.05, 110.96),
            vec_2d(124.11, 110.3),
            vec_2d(124.2, 109.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(124.2, 109.75),
            vec_2d(122.14, 109.89),
            vec_2d(115.5, 110.04),
            vec_2d(111.94, 110.04),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(111.94, 110.04),
            vec_2d(108.38, 110.04),
            vec_2d(102.87, 109.92),
            vec_2d(99.31, 109.75),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The outer part of the character R in the logo
character_R_outer = [
    {
        "vertices": [
            vec_2d(132.19, 109.75),
            vec_2d(132.43, 114.84),
            vec_2d(132.66, 120.01),
            vec_2d(132.66, 125.12),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(132.66, 125.12),
            vec_2d(132.66, 135.33),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(132.66, 135.33),
            vec_2d(132.66, 140.43),
            vec_2d(132.43, 145.6),
            vec_2d(132.19, 150.7),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(132.19, 150.7),
            vec_2d(133.19, 150.53),
            vec_2d(135.02, 150.51),
            vec_2d(135.4, 150.51),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(135.4, 150.51),
            vec_2d(135.77, 150.51),
            vec_2d(137.59, 150.53),
            vec_2d(138.6, 150.7),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(138.6, 150.7),
            vec_2d(138.36, 145.6),
            vec_2d(138.13, 140.43),
            vec_2d(138.13, 135.33),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(138.13, 135.33),
            vec_2d(138.13, 130.61),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(138.13, 130.61),
            vec_2d(140.99, 130.61),
            vec_2d(140.99, 130.61),
            vec_2d(141.15, 130.61),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(141.15, 130.61),
            vec_2d(146.26, 135.86),
            vec_2d(153.78, 147.13),
            vec_2d(156.12, 150.7),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(156.12, 150.7),
            vec_2d(157.25, 150.53),
            vec_2d(159.3, 150.51),
            vec_2d(159.84, 150.51),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(159.84, 150.51),
            vec_2d(160.38, 150.51),
            vec_2d(162.37, 150.53),
            vec_2d(163.56, 150.7),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(163.56, 150.7),
            vec_2d(160.11, 146.84),
            vec_2d(149.7, 134.15),
            vec_2d(146.79, 130.53),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(146.79, 130.53),
            vec_2d(151.3, 129.94),
            vec_2d(159.18, 127.09),
            vec_2d(159.18, 119.19),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(159.18, 119.19),
            vec_2d(159.18, 111.73),
            vec_2d(153.03, 109.75),
            vec_2d(146.32, 109.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(146.32, 109.75),
            vec_2d(144.06, 109.75),
            vec_2d(141.81, 110.04),
            vec_2d(139.55, 110.04),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(139.55, 110.04),
            vec_2d(137.29, 110.04),
            vec_2d(134.45, 109.92),
            vec_2d(132.19, 109.75),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The inner part of the character R in the logo
character_R_inner = [
    {
        "vertices": [
            vec_2d(138.5, 112.54),
            vec_2d(138.32, 116.87),
            vec_2d(138.14, 120.86),
            vec_2d(138.14, 125.14),
        ],
        "pen_colour": "#1E59AE",
        "fill_colour": "#1E59AE",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(138.14, 125.14),
            vec_2d(138.14, 128.4),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(138.14, 128.4),
            vec_2d(138.73, 128.49),
            vec_2d(141.51, 128.47),
            vec_2d(142.12, 128.45),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(142.12, 128.45),
            vec_2d(147.02, 128.34),
            vec_2d(153.46, 126.79),
            vec_2d(153.46, 120.02),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(153.46, 120.02),
            vec_2d(153.46, 114.12),
            vec_2d(148.29, 112.24),
            vec_2d(144.25, 112.24),
        ],
        "pen_colour": "#1E59AE",
    },
    {
        "vertices": [
            vec_2d(144.25, 112.24),
            vec_2d(141.52, 112.24),
            vec_2d(139.74, 112.42),
            vec_2d(138.5, 112.54),
        ],
        "pen_colour": "#1E59AE",
        "end_fill": True,
    },
]


# The character N in the logo
character_N = [
    {
        "vertices": [
            vec_2d(169.33, 109.32),
            vec_2d(169.42, 113.09),
            vec_2d(169.53, 117.19),
            vec_2d(169.53, 124.67),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(169.53, 124.67),
            vec_2d(169.53, 134.25),
            vec_2d(169.4, 144.43),
            vec_2d(168.91, 150.71),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(168.91, 150.71),
            vec_2d(169.6, 150.58),
            vec_2d(170.46, 150.49),
            vec_2d(171.51, 150.49),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(171.51, 150.49),
            vec_2d(172.55, 150.49),
            vec_2d(173.44, 150.6),
            vec_2d(174.04, 150.71),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(174.04, 150.71),
            vec_2d(173.78, 145.84),
            vec_2d(173.33, 136.84),
            vec_2d(173.33, 130.94),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(173.33, 130.94),
            vec_2d(173.33, 126.5),
            vec_2d(173.35, 121.94),
            vec_2d(173.39, 119.74),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(173.39, 119.74),
            vec_2d(175.55, 122.04),
            vec_2d(200.46, 148.02),
            vec_2d(202.85, 151.24),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(202.85, 151.24),
            vec_2d(204.79, 151.26),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(204.79, 151.26),
            vec_2d(204.7, 147.48),
            vec_2d(204.58, 143.24),
            vec_2d(204.58, 135.76),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(204.58, 135.76),
            vec_2d(204.58, 126.18),
            vec_2d(204.71, 116),
            vec_2d(205.21, 109.73),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(205.21, 109.73),
            vec_2d(204.51, 109.86),
            vec_2d(203.65, 109.94),
            vec_2d(202.6, 109.94),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(202.6, 109.94),
            vec_2d(201.56, 109.94),
            vec_2d(200.67, 109.84),
            vec_2d(200.07, 109.73),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(200.07, 109.73),
            vec_2d(200.33, 114.58),
            vec_2d(200.78, 123.59),
            vec_2d(200.78, 129.49),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(200.78, 129.49),
            vec_2d(200.78, 133.93),
            vec_2d(200.76, 137.81),
            vec_2d(200.72, 140),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(200.72, 140),
            vec_2d(198.56, 137.7),
            vec_2d(173.79, 112.07),
            vec_2d(171.27, 109.34),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(171.27, 109.34),
            vec_2d(169.33, 109.32),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The top circular loop of the logo
top_circular_loop = [
    {
        "vertices": [
            vec_2d(WIDTH, 32.65),
            vec_2d(304.17, 32.56),
            vec_2d(178.78, 31.6),
            vec_2d(138.08, 31.63),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(138.08, 31.63),
            vec_2d(131.39, 31.63),
            vec_2d(126.89, 32.09),
            vec_2d(125.44, 32.2),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(125.44, 32.2),
            vec_2d(72.61, 35.62),
            vec_2d(32.89, 81.94),
            vec_2d(32.71, 132.46),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(32.71, 132.46),
            vec_2d(32.66, 147.15),
            vec_2d(36.57, 163.7),
            vec_2d(42.92, 186.04),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(42.92, 186.04),
            vec_2d(51.31, 215.55),
            vec_2d(51.31, 215.55),
            vec_2d(61.13, 249.42),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(61.13, 249.42),
            vec_2d(66.5, 249.42),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(66.5, 249.42),
            vec_2d(46.69, 182.6),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(46.69, 182.6),
            vec_2d(46.85, 182.49),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(46.85, 182.49),
            vec_2d(61.39, 210.59),
            vec_2d(94.94, 233.17),
            vec_2d(133, 233.17),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(133, 233.17),
            vec_2d(153.54, 233.17),
            vec_2d(172.59, 227.42),
            vec_2d(187.6, 216.84),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(187.6, 216.84),
            vec_2d(187.74, 216.95),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(187.74, 216.95),
            vec_2d(94.37, HEIGHT),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(94.37, HEIGHT),
            vec_2d(101.25, HEIGHT),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(101.25, HEIGHT),
            vec_2d(105.49, 311.72),
            vec_2d(169.08, 244.14),
            vec_2d(189.42, 222.53),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(189.42, 222.53),
            vec_2d(205.55, 205.41),
            vec_2d(213.93, 194.38),
            vec_2d(217.43, 188.65),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(217.43, 188.65),
            vec_2d(221.46, 182.09),
            vec_2d(234.23, 163.15),
            vec_2d(233.75, 135.26),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(233.75, 135.26),
            vec_2d(233.92, 135.25),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(233.92, 135.25),
            vec_2d(273.68, 316.23),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(273.68, HEIGHT),
            vec_2d(279.22, HEIGHT),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(279.22, HEIGHT),
            vec_2d(275.91, 301.52),
            vec_2d(245.34, 165.47),
            vec_2d(239.4, 137.06),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(239.4, 137.06),
            vec_2d(233.73, 109.98),
            vec_2d(227.12, 92.33),
            vec_2d(219.99, 81.52),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(219.99, 81.52),
            vec_2d(216.46, 79.43),
            vec_2d(213.4, 78.14),
            vec_2d(210.88, 77.38),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(210.88, 77.38),
            vec_2d(221.41, 91.75),
            vec_2d(229.08, 112.1),
            vec_2d(229.08, 132.45),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(229.08, 132.45),
            vec_2d(229.08, 185.09),
            vec_2d(186.27, 227.9),
            vec_2d(133.63, 227.9),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(133.63, 227.9),
            vec_2d(81, 227.9),
            vec_2d(38.17, 185.09),
            vec_2d(38.17, 132.45),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(38.17, 132.45),
            vec_2d(38.17, 79.82),
            vec_2d(81.15, 37),
            vec_2d(133.66, 37),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(133.66, 37),
            vec_2d(155.89, 37),
            vec_2d(177.16, 44.7),
            vec_2d(193.5, 57.62),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(193.5, 57.62),
            vec_2d(196.97, 58.16),
            vec_2d(200.39, 58.89),
            vec_2d(203.75, 59.78),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(203.75, 59.78),
            vec_2d(192.12, 48.94),
            vec_2d(177.51, 40.93),
            vec_2d(161.91, 36.41),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(161.91, 36.41),
            vec_2d(WIDTH, 37.36),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(WIDTH, 37.36),
            vec_2d(WIDTH, 32.65),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The left small segment of the bottom circular loop
left_small_segment_bottom_loop = [
    {
        "vertices": [
            vec_2d(82, 166.81),
            vec_2d(82.63, 180.19),
            vec_2d(85.66, 196.81),
            vec_2d(96.12, 214.88),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(96.12, 214.88),
            vec_2d(92.34, 213.5),
            vec_2d(89.5, 211.67),
            vec_2d(87.03, 209.72),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(87.03, 209.72),
            vec_2d(79.96, 195.33),
            vec_2d(76.75, 180.72),
            vec_2d(76.32, 166.75),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(76.32, 166.75),
            vec_2d(78.13, 166.75),
            vec_2d(80.21, 166.81),
            vec_2d(82, 166.81),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The middle small segment of the bottom circular loop
middle_small_segment_bottom_loop = [
    {
        "vertices": [
            vec_2d(111.01, 235.15),
            vec_2d(118.59, 241.71),
            vec_2d(130.58, 249.96),
            vec_2d(145.42, 255.29),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(145.42, 255.29),
            vec_2d(144.18, 256.61),
            vec_2d(142.83, 258.04),
            vec_2d(141.4, 259.56),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(141.4, 259.56),
            vec_2d(126.58, 253.7),
            vec_2d(112.09, 244.6),
            vec_2d(100.83, 232.35),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(100.83, 232.35),
            vec_2d(103.99, 233.42),
            vec_2d(107.48, 234.39),
            vec_2d(111.01, 235.15),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The right small segment of the bottom circular loop
right_small_segment_bottom_loop = [
    {
        "vertices": [
            vec_2d(160.91, 259.46),
            vec_2d(165.77, 260.32),
            vec_2d(171.36, 260.89),
            vec_2d(177.1, 260.89),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(177.1, 260.89),
            vec_2d(206.69, 260.91),
            vec_2d(232.54, 247.59),
            vec_2d(249.61, 227.64),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(249.61, 227.64),
            vec_2d(251.03, 234.11),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(251.03, 234.11),
            vec_2d(233.96, 252.55),
            vec_2d(207.83, 266.37),
            vec_2d(177.4, 266.37),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(177.4, 266.37),
            vec_2d(170.89, 266.37),
            vec_2d(164.09, 265.74),
            vec_2d(156.52, 264.13),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(156.52, 264.13),
            vec_2d(158.06, 262.5),
            vec_2d(159.53, 260.93),
            vec_2d(160.91, 259.46),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The large segment of the bottom circular loop
large_segment_bottom_circular_loop = [
    {
        "vertices": [
            vec_2d(101.67, 95.29),
            vec_2d(120.12, 74.36),
            vec_2d(146.93, 61),
            vec_2d(177.03, 61),
        ],
        "pen_colour": "#FFFFFF",
        "fill_colour": "#FFFFFF",
        "start_fill": True,
    },
    {
        "vertices": [
            vec_2d(177.03, 61),
            vec_2d(208.59, 61),
            vec_2d(236.7, 75.18),
            vec_2d(255.85, 98.67),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(255.85, 98.67),
            vec_2d(266.88, 112.2),
            vec_2d(275.82, 133.61),
            vec_2d(277.12, 151.52),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(277.12, 151.52),
            vec_2d(277.29, 151.52),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(277.29, 151.52),
            vec_2d(286.49, 56.58),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(286.49, 56.58),
            vec_2d(291.67, 56.58),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(291.67, 56.58),
            vec_2d(285.79, 117.95),
            vec_2d(285.79, 117.95),
            vec_2d(282.36, 148.45),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(282.36, 148.45),
            vec_2d(278.08, 186.64),
            vec_2d(272.63, 202.5),
            vec_2d(262.2, 219.18),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(262.2, 219.18),
            vec_2d(260.61, 211.92),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(260.61, 211.92),
            vec_2d(268.73, 197.65),
            vec_2d(271.05, 185.2),
            vec_2d(272.1, 178.65),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(272.1, 178.65),
            vec_2d(275.41, 158.23),
            vec_2d(270.68, 130.36),
            vec_2d(256.45, 108.6),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(256.45, 108.6),
            vec_2d(240.51, 84.23),
            vec_2d(212.01, 66.3),
            vec_2d(177.03, 66.3),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(177.03, 66.3),
            vec_2d(148.29, 66.3),
            vec_2d(123.32, 78.93),
            vec_2d(105.89, 98.64),
        ],
        "pen_colour": "#FFFFFF",
    },
    {
        "vertices": [
            vec_2d(105.89, 98.64),
            vec_2d(101.67, 95.29),
        ],
        "pen_colour": "#FFFFFF",
        "end_fill": True,
    },
]


# The text in the logo
logo_text = [
    character_C,
    character_E,
    character_R_outer,
    character_R_inner,
    character_N,
]


# The icon of the logo
icon = [
    top_circular_loop,
    left_small_segment_bottom_loop,
    middle_small_segment_bottom_loop,
    right_small_segment_bottom_loop,
    large_segment_bottom_circular_loop,
]


# The vertices in the logo
vertices = [logo_background, logo_text, icon]


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
