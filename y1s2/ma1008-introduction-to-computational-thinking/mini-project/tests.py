# The tests to make sure things work as they should.
# This file is not part of the program,
# it is to test out the functions to make sure they work correctly.
#
# If this file was submitted accidentally, please ignore this file,
# mainly because it contains the prohibited class construct and
# it literally is not used in the program,
# so this file only unfairly penalises me.

import math
import tomllib
import unittest
from decimal import Decimal

import draw_lib
import math_utils
import save_lib


class TestMathUtils(unittest.TestCase):
    "Class to test all of the math utility functions"

    def test_math_sin(self) -> None:
        "Test cases for the math_sin function"

        # Test case for 90 degrees
        self.assertEqual(math_utils.math_sin(math.radians(90)), 1)

        # Test case for 45 degrees
        self.assertAlmostEqual(
            math_utils.math_sin(math.radians(45)),
            Decimal(1 / (math_utils.sqrt(2))),
        )

        # Test case for pi/3 radians
        self.assertAlmostEqual(
            math_utils.math_sin(math.pi / 3), math_utils.sqrt(3) / 2
        )

        # Test case for pi
        self.assertEqual(math_utils.math_sin(math.pi), 0)

    def test_math_cos(self) -> None:
        "Test cases for the math_cos function"

        # Test case for 90 degrees
        self.assertEqual(math_utils.math_cos(math.radians(90)), 0)

        # Test case for 45 degrees
        self.assertAlmostEqual(
            math_utils.math_cos(math.radians(45)),
            Decimal(1 / (math_utils.sqrt(2))),
        )

        # Test case for pi/3 radians
        self.assertEqual(math_utils.math_cos(math.pi / 3), Decimal(1 / 2))

        # Test case for pi
        self.assertEqual(math_utils.math_cos(math.pi), -1)

    def test_math_tan(self) -> None:
        "Test cases for the math_cos function"

        # Test case for 30 degrees
        self.assertAlmostEqual(
            math_utils.math_tan(math.radians(30)), 1 / (math_utils.sqrt(3))
        )

        # Test case for 45 degrees
        self.assertAlmostEqual(
            math_utils.math_tan(math.radians(45)),
            1,
        )

        # Test case for pi/3 radians
        self.assertAlmostEqual(
            math_utils.math_tan(math.pi / 3), math_utils.sqrt(3)
        )

        # Test case for pi
        self.assertEqual(math_utils.math_tan(math.pi), 0)

    def test_sqrt(self) -> None:
        "Test cases for the sqrt function"

        # Test for the square root of 9
        self.assertEqual(math_utils.sqrt(9), 3)

        # Test for the square root of 25
        self.assertEqual(math_utils.sqrt(25), 5)

        # Test for the square root of 2
        self.assertAlmostEqual(math_utils.sqrt(2), Decimal(2 ** (1 / 2)))

        # Test for the square root of 3
        self.assertAlmostEqual(math_utils.sqrt(3), Decimal(3 ** (1 / 2)))

    def test_init_matrix(self) -> None:
        "Test cases for the init_matrix function"

        # Test for 5 x 6 matrix
        self.assertEqual(
            math_utils.init_matrix(5, 6),
            [
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0],
            ],
        )

        # Test for 1 x 3 column matrix
        self.assertEqual(math_utils.init_matrix(1, 3), [[0, 0, 0]])

        # Test for 2 x 1 row matrix
        self.assertEqual(math_utils.init_matrix(2, 1), [[0], [0]])

        # Test for 0 x 3 matrix (should error out)
        with self.assertRaises(ValueError):
            math_utils.init_matrix(0, 3)

        # Test for 9 x 0 matrix (should error out)
        with self.assertRaises(ValueError):
            math_utils.init_matrix(9, 0)

    def test_vec_2d(self) -> None:
        "Test cases for the vec_2d function"

        # Test for (0, 0)
        self.assertEqual(math_utils.vec_2d(0, 0), [[0], [0]])

        # Test for (9, 199)
        self.assertEqual(math_utils.vec_2d(9, 199), [[9], [199]])

        # Test for (-2, -7)
        self.assertEqual(math_utils.vec_2d(-2, -7), [[-2], [-7]])

    def test_vec_3d(self) -> None:
        "Test cases for the vec_3d function"

        # Test for (0, 0, 0)
        self.assertEqual(math_utils.vec_3d(0, 0, 0), [[0], [0], [0]])

        # Test for (9, 199, 99)
        self.assertEqual(math_utils.vec_3d(9, 199, 99), [[9], [199], [99]])

        # Test for (-2, -7, -1)
        self.assertEqual(math_utils.vec_3d(-2, -7, -1), [[-2], [-7], [-1]])

    def test_vec(self) -> None:
        "Test cases for the vec function"

        # Test for (1, 2, 3, 4, 5, 6)
        self.assertEqual(
            math_utils.vec(1, 2, 3, 4, 5, 6), [[1], [2], [3], [4], [5], [6]]
        )

        # Test for (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        self.assertEqual(
            math_utils.vec(0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
            [[0], [0], [0], [0], [0], [0], [0], [0], [0], [0]],
        )

        # Test for (3, 2, 1)
        self.assertEqual(math_utils.vec(3, 2, 1), [[3], [2], [1]])

        # Test for (2, 2)
        self.assertEqual(math_utils.vec(2, 2), [[2], [2]])

    def test_matrix_shape(self) -> None:
        "Test cases for the matrix_shape function"

        # Test for 9 x 9 matrix
        self.assertEqual(
            math_utils.matrix_shape(math_utils.init_matrix(9, 9)), (9, 9)
        )

        # Test for 1 x 3 column matrix
        self.assertEqual(
            math_utils.matrix_shape(math_utils.init_matrix(1, 3)), (1, 3)
        )

        # Test for a 2 x 1 row matrix
        self.assertEqual(
            math_utils.matrix_shape(math_utils.init_matrix(2, 1)), (2, 1)
        )

        # Test for a 2 x 0 row matrix
        self.assertEqual(math_utils.matrix_shape([[], []]), (2, 0))

    def test_convert_2d_to_3d(self) -> None:
        "Test cases for the convert_2d_to_3d function"

        # Test for (0, 0)
        self.assertEqual(
            math_utils.convert_2d_to_3d(math_utils.vec_2d(0, 0)),
            [[0], [0], [1]],
        )

        # Test for (9, 199)
        self.assertEqual(
            math_utils.convert_2d_to_3d(math_utils.vec_2d(9, 199)),
            [[9], [199], [1]],
        )

        # Test for (-2, -7)
        self.assertEqual(
            math_utils.convert_2d_to_3d(math_utils.vec_2d(-2, -7)),
            [[-2], [-7], [1]],
        )

        # Test for (9, -10, 15)
        self.assertEqual(
            math_utils.convert_2d_to_3d(math_utils.vec_3d(9, -10, 15)),
            [[9], [-10], [15]],
        )

        # Test for (1, 4, 7, 10)
        with self.assertRaises(ValueError):
            math_utils.convert_2d_to_3d(math_utils.vec(1, 4, 7, 10))

        # Test for (100)
        with self.assertRaises(ValueError):
            math_utils.convert_2d_to_3d(math_utils.vec(100))

    def test_convert_3d_to_2d(self) -> None:
        "Test cases for the convert_3d_to_2d function"

        # Test for (0, 0, 0)
        self.assertEqual(
            math_utils.convert_3d_to_2d(math_utils.vec_3d(0, 0, 0)), [[0], [0]]
        )

        # Test for (9, 199, 99)
        self.assertEqual(
            math_utils.convert_3d_to_2d(math_utils.vec_3d(9, 199, 99)),
            [[9], [199]],
        )

        # Test for (-2, -7, -1)
        self.assertEqual(
            math_utils.convert_3d_to_2d(math_utils.vec_3d(-2, -7, -1)),
            [[-2], [-7]],
        )

        # Test for (-10, 99)
        self.assertEqual(
            math_utils.convert_3d_to_2d(math_utils.vec_2d(-10, 99)),
            [[-10], [99]],
        )

        # Test for (6, 33, 8, 10, 57)
        with self.assertRaises(ValueError):
            math_utils.convert_3d_to_2d(math_utils.vec(6, 33, 8, 10, 57))

        # Test for (69)
        with self.assertRaises(ValueError):
            math_utils.convert_3d_to_2d(math_utils.vec(69))

    def test_convert_vertices(self) -> None:
        "Test cases for the convert_vertices function"

        # Test for a bezier curve
        self.assertEqual(
            math_utils.convert_vertices(
                {
                    "vertices": [
                        math_utils.vec_2d(2, 4),
                        math_utils.vec_2d(5, 8),
                        math_utils.vec_2d(6, 4),
                        math_utils.vec_2d(5, 4),
                    ]
                }
            ),
            {
                "vertices": [
                    math_utils.vec_3d(2, 4, 1),
                    math_utils.vec_3d(5, 8, 1),
                    math_utils.vec_3d(6, 4, 1),
                    math_utils.vec_3d(5, 4, 1),
                ]
            },
        )

        # Test for a straight edge
        self.assertEqual(
            math_utils.convert_vertices(
                {
                    "vertices": [
                        math_utils.vec_3d(6, 9, 69),
                        math_utils.vec_3d(4, 5, 98),
                    ]
                },
                to_3d=False,
            ),
            {"vertices": [math_utils.vec_2d(6, 9), math_utils.vec_2d(4, 5)]},
        )

        # Test for a list of a points
        self.assertEqual(
            math_utils.convert_vertices(
                [
                    {
                        "vertices": [
                            math_utils.vec_2d(7, 19),
                            math_utils.vec_2d(5, 6),
                            math_utils.vec_2d(7, 43),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_3d(5, 87, 23),
                            math_utils.vec_3d(73, 13, 34),
                            math_utils.vec_3d(45, 2, 81),
                            math_utils.vec_3d(2, 75, 92),
                        ]
                    },
                ]
            ),
            [
                {
                    "vertices": [
                        math_utils.vec_3d(7, 19, 1),
                        math_utils.vec_3d(5, 6, 1),
                        math_utils.vec_3d(7, 43, 1),
                    ]
                },
                {
                    "vertices": [
                        math_utils.vec_3d(5, 87, 23),
                        math_utils.vec_3d(73, 13, 34),
                        math_utils.vec_3d(45, 2, 81),
                        math_utils.vec_3d(2, 75, 92),
                    ]
                },
            ],
        )

    def test_is_valid_matrix(self) -> None:
        "Test cases for the is_valid_matrix function"

        # Test for a normal 3 x 3 matrix
        self.assertTrue(
            math_utils.is_valid_matrix(math_utils.init_matrix(3, 3))
        )

        # Test for a matrix with empty columns
        self.assertFalse(math_utils.is_valid_matrix([[], [], []]))

        # Test for a matrix that is empty
        self.assertFalse(math_utils.is_valid_matrix([]))

        # Test for a matrix with differing number of columns
        self.assertFalse(math_utils.is_valid_matrix([[1], [3], [5, 9]]))

    def test_is_matrix_addable(self) -> None:
        "Test cases for the is_matrix_addable function"

        # Test for adding a 2 x 2 matrix to a 2 x 2 matrix
        self.assertTrue(
            math_utils.is_matrix_addable(
                math_utils.init_matrix(2, 2), math_utils.init_matrix(2, 2)
            )
        )

        # Test for adding a 1 x 3 matrix to a 3 x 1 matrix
        self.assertFalse(
            math_utils.is_matrix_addable(
                math_utils.init_matrix(1, 3), math_utils.vec_3d(3, 6, 9)
            )
        )

        # Test for adding a 2 x 2 matrix to a 1 x 2 matrix
        self.assertFalse(
            math_utils.is_matrix_addable(
                math_utils.init_matrix(2, 2), math_utils.vec_2d(6, 9)
            )
        )

    def test_add_matrices(self) -> None:
        "Test cases for the add_matrices function"

        # Test for adding two 3D vectors
        self.assertEqual(
            math_utils.add_matrices(
                math_utils.vec_3d(3, 6, 9), math_utils.vec_3d(10, 29, 40)
            ),
            [[13], [35], [49]],
        )

        # Test for adding two 2D vectors
        self.assertEqual(
            math_utils.add_matrices(
                math_utils.vec_2d(6, 9), math_utils.vec_2d(100, 300)
            ),
            [[106], [309]],
        )

        # Test for adding two 5 x 5 matrices
        self.assertEqual(
            math_utils.add_matrices(
                math_utils.init_matrix(5, 5, 50),
                math_utils.init_matrix(5, 5, 300),
            ),
            [
                [350, 350, 350, 350, 350],
                [350, 350, 350, 350, 350],
                [350, 350, 350, 350, 350],
                [350, 350, 350, 350, 350],
                [350, 350, 350, 350, 350],
            ],
        )

        # Test for adding five 3 x 3 matrices
        self.assertEqual(
            math_utils.add_matrices(
                math_utils.init_matrix(3, 3, 10),
                math_utils.init_matrix(3, 3, 200),
                math_utils.init_matrix(3, 3, 50),
                math_utils.init_matrix(3, 3, 20),
                math_utils.init_matrix(3, 3, 40),
                math_utils.init_matrix(3, 3, 30),
            ),
            [
                [350, 350, 350],
                [350, 350, 350],
                [350, 350, 350],
            ],
        )

        # Test for adding a 2 x 2 matrix to a 3 x 3 matrix
        with self.assertRaises(ValueError):
            math_utils.add_matrices(
                math_utils.init_matrix(2, 2), math_utils.init_matrix(3, 3)
            )

    def test_scalar_product_matrix(self) -> None:
        "Test cases for the scalar_product_matrix function"

        # Test for 5 multiplied with a 3 x 3 matrix
        self.assertEqual(
            math_utils.scalar_product_matrix(
                5, math_utils.init_matrix(3, 3, 3)
            ),
            [[15, 15, 15], [15, 15, 15], [15, 15, 15]],
        )

        # Test for 69 multiplied with a 6 x 9 matrix
        self.assertEqual(
            math_utils.scalar_product_matrix(
                69, math_utils.init_matrix(6, 9, 69)
            ),
            [
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
                [4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761, 4761],
            ],
        )

        # Test for a 10 multiplied with a 2 x 2 matrix
        self.assertEqual(
            math_utils.scalar_product_matrix(10, [[3, 6], [9, 12]]),
            [[30, 60], [90, 120]],
        )

    def test_subtract_matrix(self) -> None:
        "Test cases for the subtract_matrix function"

        # Test for a 3x3 minus a 3x3
        self.assertEqual(
            math_utils.subtract_matrix(
                math_utils.init_matrix(3, 3, 3),
                math_utils.init_matrix(3, 3, 3),
            ),
            [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
        )

        # Test for a 2x2 minus a 2x2
        self.assertEqual(
            math_utils.subtract_matrix([[1, 2], [3, 4]], [[5, 6], [7, 8]]),
            [[-4, -4], [-4, -4]],
        )

        # Test for a 10x10 minus a 10x10
        self.assertEqual(
            math_utils.subtract_matrix(
                math_utils.init_matrix(10, 10, 100),
                math_utils.init_matrix(10, 10, 20),
            ),
            [
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
                [80, 80, 80, 80, 80, 80, 80, 80, 80, 80],
            ],
        )

        # Test for a 10x10 minus a 1x1
        with self.assertRaises(ValueError):
            math_utils.subtract_matrix(
                math_utils.init_matrix(10, 10), math_utils.init_matrix(1, 1)
            )

    def test_matrix_transpose(self) -> None:
        "Test cases for the matrix_transpose function"

        # Test for the transpose of a 3 x 3 matrix
        self.assertEqual(
            math_utils.matrix_transpose([[1, 2, 3], [4, 5, 6], [7, 8, 9]]),
            [[1, 4, 7], [2, 5, 8], [3, 6, 9]],
        )

        # Test for the transpose of a 3 x 1 matrix
        self.assertEqual(
            math_utils.matrix_transpose(math_utils.vec_3d(10, 33, 99)),
            [[10, 33, 99]],
        )

        # Test for the transpose of a 1 x 2 matrix
        self.assertEqual(math_utils.matrix_transpose([[1, 2]]), [[1], [2]])

    def test_is_matrix_multipliable(self) -> None:
        "Test cases for the is_matrix_multipliable function"

        # Test for a 3 x 3 matrix multiplied with a 3 x 1 matrix
        self.assertTrue(
            math_utils.is_matrix_multipliable(
                math_utils.init_matrix(3, 3), math_utils.init_matrix(3, 1)
            ),
            "3x3 x 3x1 matrix failed.",
        )

        # Test for a 9 x 5 matrix multiplied with a 7 x 6 matrix
        self.assertFalse(
            math_utils.is_matrix_multipliable(
                math_utils.init_matrix(9, 5), math_utils.init_matrix(7, 6)
            )
        )

        # Test for a 3 x 3 matrix multiplied with a 3 x 1 matrix,
        # multiplied with a 1 x 4 matrix, multiplied with a 4 x 9 matrix
        self.assertTrue(
            math_utils.is_matrix_multipliable(
                math_utils.init_matrix(3, 3),
                math_utils.init_matrix(3, 1),
                math_utils.init_matrix(1, 4),
                math_utils.init_matrix(4, 9),
            ),
            "3x3 x 3x1 x 1x4 x 4x9 matrix failed.",
        )

        # Test for a 3 x 3 matrix multiplied with a 3 x 1 matrix
        # multiplied with a 1 x 4 matrix, multiplied with a 4 x 9 matrix,
        # multiplied with a 10 x 1 matrix
        self.assertFalse(
            math_utils.is_matrix_multipliable(
                math_utils.init_matrix(3, 3),
                math_utils.init_matrix(3, 1),
                math_utils.init_matrix(1, 4),
                math_utils.init_matrix(4, 9),
                math_utils.init_matrix(10, 1),
            ),
            "3x3 x 3x1 x 1x4 x 4x9 x 10x1 matrix failed.",
        )

        # Test for a single matrix, should return True
        self.assertTrue(
            math_utils.is_matrix_multipliable(math_utils.init_matrix(1, 1)),
            "1x1 matrix failed.",
        )

    def test_multiply_matrices(self) -> None:
        "Test cases for the multiply_matrices function"

        # Test for matrix multiplication of a 3x3 matrix and a 3x1 matrix
        self.assertEqual(
            math_utils.multiply_matrices(
                [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
                math_utils.vec_3d(10, 15, 20),
            ),
            [[100], [235], [370]],
        )

        # Test for matrix multiplication of a 3x3 matrix and a 3x4 matrix,
        # and a 4x6 matrix, and a 6x1 matrix
        self.assertEqual(
            math_utils.multiply_matrices(
                [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
                [[9, 10, 11, 12], [20, 21, 22, 23], [6, 9, 6, 9]],
                [
                    [4, 5, 6, 7, 8, 9],
                    [10, 11, 12, 13, 14, 15],
                    [20, 30, 40, 50, 60, 70],
                    [33, 44, 55, 66, 77, 88],
                ],
                math_utils.vec(6, 7, 8, 9, 10, 11),
            ),
            [[534068], [1370999], [2207930]],
        )

        # Test for matrix multiplication of a 3x1 matrix and a 1x3 matrix
        self.assertEqual(
            math_utils.multiply_matrices(
                math_utils.vec_3d(1, 2, 3),
                math_utils.matrix_transpose(math_utils.vec_3d(3, 2, 1)),
            ),
            [[3, 2, 1], [6, 4, 2], [9, 6, 3]],
        )

        # Test for matrix multiplication of a 3x1 matrix and a 2x1 matrix
        with self.assertRaises(ValueError):
            math_utils.multiply_matrices(
                math_utils.vec_3d(6, 9, 10), math_utils.vec_2d(20, 19)
            )

    def test_vec_dot_product(self) -> None:
        "Test cases for the vec_dot_product function"

        # Test for 2D vectors
        self.assertEqual(
            math_utils.vec_dot_product(
                math_utils.vec_2d(10, 5), math_utils.vec_2d(6, 7)
            ),
            95,
        )

        # Test for 3D vectors
        self.assertEqual(
            math_utils.vec_dot_product(
                math_utils.vec_3d(6, 2, 9), math_utils.vec_3d(22, 0.5, 22)
            ),
            331,
        )

        # Test for 6D vectors
        self.assertEqual(
            math_utils.vec_dot_product(
                math_utils.vec(5, 30, 40, 20, 88, 106),
                math_utils.vec(56, 90, 35, 27, 40, 18),
            ),
            10348,
        )

        # Test for matrices with the same number of rows and columns
        with self.assertRaises(ValueError):
            math_utils.vec_dot_product(
                math_utils.init_matrix(3, 4), math_utils.init_matrix(3, 4)
            )

        # Test for matrices with different number of rows and columns
        with self.assertRaises(ValueError):
            math_utils.vec_dot_product(
                math_utils.init_matrix(6, 9), math_utils.init_matrix(10, 20)
            )

        # Test for vectors of different dimensions
        with self.assertRaises(ValueError):
            math_utils.vec_dot_product(
                math_utils.vec_3d(9, 3, 7), math_utils.vec_2d(10, 99)
            )

    def test_vec_norm(self) -> None:
        "Test cases for the test_vec_norm function"

        # Test for (2, 0)
        self.assertEqual(math_utils.vec_norm(math_utils.vec_2d(2, 0)), 2)

        # Test for (2, 2)
        self.assertEqual(
            math_utils.vec_norm(math_utils.vec_2d(2, 2)), math_utils.sqrt(8)
        )

        # Test for (1, 0, 2)
        self.assertEqual(
            math_utils.vec_norm(math_utils.vec_3d(1, 0, 2)), math_utils.sqrt(5)
        )

        # Test for (9, 9, 9)
        self.assertEqual(
            math_utils.vec_norm(math_utils.vec_3d(9, 9, 9)),
            math_utils.sqrt(243),
        )

    def test_vec_2d_transform_top_left_origin_to_centre_origin(self) -> None:
        """
        Test cases for the vec_2d_transform_top_left_origin_to_centre_origin
        function.
        """

        # Test case for a square of 200 x 200
        self.assertEqual(
            math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
                50, 50, 200, 200
            ),
            [[-50], [50]],
        )

        # Test case for a rectangle of 200 x 400
        self.assertEqual(
            math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
                50, 30, 200, 400
            ),
            [[-50], [170]],
        )

        # Test case for a rectangle of 500 x 250
        self.assertEqual(
            math_utils.vec_2d_transform_top_left_origin_to_centre_origin(
                20, 100, 500, 250
            ),
            [[-230], [25]],
        )

    def test_vec_3d_translate(self) -> None:
        "Test cases for the vec_3d_translate function"

        # Test for a translation of 2 units in the positive x-direction
        self.assertEqual(
            math_utils.vec_3d_translate(2), [[1, 0, 2], [0, 1, 0], [0, 0, 1]]
        )

        # Test for a translation of 10 units in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_translate(y_translation=-10),
            [[1, 0, 0], [0, 1, -10], [0, 0, 1]],
        )

        # Test for a translation of 5 units in
        # both the positive x and y directions
        self.assertEqual(
            math_utils.vec_3d_translate(5, 5),
            [[1, 0, 5], [0, 1, 5], [0, 0, 1]],
        )

        # Test to actually translate a point 2 units in the positive x-direction
        # and 7 units in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_translate(
                2, -7, True, math_utils.vec_3d(5, 9, 1)
            ),
            [[7], [2], [1]],
        )

        # Test to actually translate a point 6 units in the positive x-direction
        # and 13 units in the negative y-direction
        with self.assertRaises(ValueError):
            math_utils.vec_3d_translate(
                6, 13, True, math_utils.vec(4, 8, 3, 9, 20)
            )

    def test_vec_3d_rotate(self) -> None:
        "Test cases for the vec_3d_rotate function"

        # Test for a rotation of 45 degrees anti-clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(45),
            [
                [
                    math_utils.math_cos(math.radians(45)),
                    -math_utils.math_sin(math.radians(45)),
                    0,
                ],
                [
                    math_utils.math_sin(math.radians(45)),
                    math_utils.math_cos(math.radians(45)),
                    0,
                ],
                [0, 0, 1],
            ],
        )

        # Test for a rotation of 33 degrees clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(33, anti_clockwise=False),
            [
                [
                    math_utils.math_cos(math.radians(33)),
                    math_utils.math_sin(math.radians(33)),
                    0,
                ],
                [
                    -math_utils.math_sin(math.radians(33)),
                    math_utils.math_cos(math.radians(33)),
                    0,
                ],
                [0, 0, 1],
            ],
        )

        # Test for a rotation of -pi/4 radians anti-clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(math.pi / 4, in_degrees=False),
            [
                [
                    math_utils.math_cos(math.pi / 4),
                    -math_utils.math_sin(math.pi / 4),
                    0,
                ],
                [
                    math_utils.math_sin(math.pi / 4),
                    math_utils.math_cos(math.pi / 4),
                    0,
                ],
                [0, 0, 1],
            ],
        )

        # Test for a rotation of pi/3 radians clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(
                math.pi / 3, in_degrees=False, anti_clockwise=False
            ),
            [
                [
                    math_utils.math_cos(math.pi / 3),
                    math_utils.math_sin(math.pi / 3),
                    0,
                ],
                [
                    -math_utils.math_sin(math.pi / 3),
                    math_utils.math_cos(math.pi / 3),
                    0,
                ],
                [0, 0, 1],
            ],
        )

        # Test to actually rotate pi/5 radians anti-clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(
                math.pi / 5,
                in_degrees=False,
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(5, 4, 1),
            ),
            [
                [Decimal("1.693943962799999813917395386")],
                [Decimal("6.174994239099999893127801443")],
                [1],
            ],
        )

        # Test to actually rotate 90 degrees clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate(
                90,
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(6, 9, 1),
            ),
            [[-9], [6], [1]],
        )

    def test_vec_3d_rotate_90_degrees(self) -> None:
        "Test cases for the vec_3d_rotate_90_degrees function"

        # Test case for anti-clockwise rotation
        self.assertEqual(
            math_utils.vec_3d_rotate_90_degrees(),
            [[0, -1, 0], [1, 0, 0], [0, 0, 1]],
        )

        # Test case for clockwise rotation
        self.assertEqual(
            math_utils.vec_3d_rotate_90_degrees(anti_clockwise=False),
            [[0, 1, 0], [-1, 0, 0], [0, 0, 1]],
        )

        # Test case for actually rotating a vector anti-clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate_90_degrees(
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(69, 420, 1),
            ),
            [[-420], [69], [1]],
        )

        # Test case for actually rotating a vector clockwise
        self.assertEqual(
            math_utils.vec_3d_rotate_90_degrees(
                anti_clockwise=False,
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(75, 23, 1),
            ),
            [[23], [-75], [1]],
        )

    def test_vec_3d_scale(self) -> None:
        "Test cases for the vec_3d_scale function"

        # Test case for a scaling of 2 in the positive x-direction
        self.assertEqual(
            math_utils.vec_3d_scale(2), [[2, 0, 0], [0, 1, 0], [0, 0, 1]]
        )

        # Test case for a scaling of 5 in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_scale(scaling_factor_y=-5),
            [[1, 0, 0], [0, -5, 0], [0, 0, 1]],
        )

        # Test case for a scaling of 8 in the negative x-direction
        # and a scaling of 20 in the positive y-direction
        self.assertEqual(
            math_utils.vec_3d_scale(-8, 20), [[-8, 0, 0], [0, 20, 0], [0, 0, 1]]
        )

        # Test case to actually scale a vector by 4 in the positive x-direction
        # and 9 in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_scale(
                4,
                -9,
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(7, 3, 1),
            ),
            [[28], [-27], [1]],
        )

    def test_vec_3d_shear(self) -> None:
        "Test cases for the vec_3d_shear function"

        # Test case for a shear of 6 in the positive x-direction
        self.assertEqual(
            math_utils.vec_3d_shear(6), [[1, 6, 0], [0, 1, 0], [0, 0, 1]]
        )

        # Test case for a shear of 78 in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_shear(shearing_factor_y=-78),
            [[1, 0, 0], [-78, 1, 0], [0, 0, 1]],
        )

        # Test case for a shear of 63 in the negative x-direction
        # and a shear of 32 in the positive y-direction
        self.assertEqual(
            math_utils.vec_3d_shear(-63, 32),
            [[1, -63, 0], [32, 1, 0], [0, 0, 1]],
        )

        # Test case to actually shear a vector by 4 in the positive x-direction
        # and 7 in the negative y-direction
        self.assertEqual(
            math_utils.vec_3d_shear(
                4,
                -7,
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(81, 43, 1),
            ),
            [[253], [-524], [1]],
        )

    def test_vec_3d_reflect_about_x(self) -> None:
        "Test cases for the vec_3d_reflect_about_x function"

        # Test case to reflect about the x-axis
        self.assertEqual(
            math_utils.vec_3d_reflect_about_x(),
            [[1, 0, 0], [0, -1, 0], [0, 0, 1]],
        )

        # Test case to actually reflect a vector about the x-axis
        self.assertEqual(
            math_utils.vec_3d_reflect_about_x(
                perform_multiplication=True, vec_3d=math_utils.vec_3d(55, 92, 1)
            ),
            [[55], [-92], [1]],
        )

    def test_vec_3d_reflect_about_y(self) -> None:
        "Test cases for the vec_3d_reflect_about_y function"

        # Test case to reflect about the y-axis
        self.assertEqual(
            math_utils.vec_3d_reflect_about_y(),
            [[-1, 0, 0], [0, 1, 0], [0, 0, 1]],
        )

        # Test case to actually reflect a vector about the y-axis
        self.assertEqual(
            math_utils.vec_3d_reflect_about_y(
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(19, -25, 1),
            ),
            [[-19], [-25], [1]],
        )

    def test_vec_3d_reflect_about_line_y_equal_x(self) -> None:
        "Test cases for the vec_3d_reflect_about_line_y_equal_x function"

        # Test case to reflect about the line y = x
        self.assertEqual(
            math_utils.vec_3d_reflect_about_line_y_equal_x(),
            [[0, 1, 0], [1, 0, 0], [0, 0, 1]],
        )

        # Test case to actually reflect a vector about the line y = x
        self.assertEqual(
            math_utils.vec_3d_reflect_about_line_y_equal_x(
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(-88, 51, 1),
            ),
            [[51], [-88], [1]],
        )

    def test_vec_3d_reflect_about_line_y_equal_minus_x(self) -> None:
        "Test cases for the vec_3d_reflect_about_line_y_equal_minus_x function"

        # Test case to reflect about the line y = x
        self.assertEqual(
            math_utils.vec_3d_reflect_about_line_y_equal_minus_x(),
            [[0, -1, 0], [-1, 0, 0], [0, 0, 1]],
        )

        # Test case to actually reflect a vector about the line y = x
        self.assertEqual(
            math_utils.vec_3d_reflect_about_line_y_equal_minus_x(
                perform_multiplication=True,
                vec_3d=math_utils.vec_3d(-56, -22, 1),
            ),
            [[22], [56], [1]],
        )

    def test_apply_transformations_to_vertices(self) -> None:
        "Test cases for the apply_transformations_to_vertices function"

        # Test case for an empty list of transformations
        self.assertEqual(
            math_utils.apply_transformations_to_vertices(
                [],
                {
                    "vertices": [
                        math_utils.vec_2d(51, 89),
                        math_utils.vec_2d(7, -12),
                    ]
                },
            ),
            {"vertices": [[[51], [89]], [[7], [-12]]]},
        )

        # Test case for one transformation and two vertices
        self.assertEqual(
            math_utils.apply_transformations_to_vertices(
                [math_utils.vec_3d_reflect_about_x()],
                {
                    "vertices": [
                        math_utils.vec_2d(45, 31),
                        math_utils.vec_2d(3, -4),
                    ]
                },
            ),
            {"vertices": [[[45], [-31]], [[3], [4]]]},
        )

        # Test case for 2 transformations and 4 vertices
        self.assertEqual(
            math_utils.apply_transformations_to_vertices(
                [
                    math_utils.vec_3d_rotate_90_degrees(),
                    math_utils.vec_3d_scale(-5, 20),
                ],
                {
                    "vertices": [
                        math_utils.vec_2d(-84, 31),
                        math_utils.vec_2d(56, 1),
                        math_utils.vec_2d(-9, 48),
                        math_utils.vec_2d(5, -38),
                    ]
                },
            ),
            {
                "vertices": [
                    [[155], [-1680]],
                    [[5], [1120]],
                    [[240], [-180]],
                    [[-190], [100]],
                ]
            },
        )

        # Test case for multiple transformations and a list of dictionaries
        self.assertEqual(
            math_utils.apply_transformations_to_vertices(
                [
                    math_utils.vec_3d_translate(5, 8),
                    math_utils.vec_3d_reflect_about_y(),
                    math_utils.vec_3d_scale(7, 2),
                ],
                [
                    {
                        "vertices": [
                            math_utils.vec_2d(78, 3),
                            math_utils.vec_2d(23, 54),
                            math_utils.vec_2d(5, 1),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(3, 13),
                            math_utils.vec_2d(8, 41),
                            math_utils.vec_2d(7, 85),
                        ]
                    },
                ],
            ),
            [
                {
                    "vertices": [
                        [[-581], [22]],
                        [[-196], [124]],
                        [[-70], [18]],
                    ]
                },
                {
                    "vertices": [
                        [[-56], [42]],
                        [[-91], [98]],
                        [[-84], [186]],
                    ]
                },
            ],
        )

    def test_get_tangent_vector(self) -> None:
        "Test cases for the get_tangent_vector function"

        # Test case for (2, 9)
        self.assertEqual(
            math_utils.get_tangent_vector(math_utils.vec_2d(2, 9)), [[-9], [2]]
        )

        # Test case for (-7, 4)
        self.assertEqual(
            math_utils.get_tangent_vector(math_utils.vec_2d(-7, 4)),
            [[-4], [-7]],
        )

        # Test case for (2, -8)
        self.assertEqual(
            math_utils.get_tangent_vector(math_utils.vec_2d(2, -8)), [[8], [2]]
        )

    def test_approximate_arc_less_than_90_degrees_as_bezier(self) -> None:
        "Test cases for the approximate_arc_less_than_90_degrees_as_bezier"

        # Test case for circle of centre (2, 2), an angle pi / 3,
        # start angle of 0 and a radius of 5
        self.assertEqual(
            math_utils.approximate_arc_less_than_90_degrees_as_bezier(
                math_utils.vec_2d(2, 2),
                math_utils.math_pi / 3,
                Decimal(0),
                Decimal(5),
            ),
            [
                [[Decimal("7")], [Decimal("2")]],
                [
                    [Decimal("7.000000000000000000000000000")],
                    [Decimal("3.786327949333333201901533963")],
                ],
                [
                    [Decimal("6.047005383640625894165805599")],
                    [Decimal("5.436963044333333587114035860")],
                ],
                [[Decimal("4.5")], [Decimal("6.330127019000000188064802842")]],
            ],
        )

        # Test case for circle of centre (6, 10), an angle pi / 4,
        # start angle of pi / 2, an a radius of 100
        self.assertEqual(
            math_utils.approximate_arc_less_than_90_degrees_as_bezier(
                math_utils.vec_2d(6, 10),
                math_utils.math_pi / 4,
                math_utils.math_pi / 2,
                Decimal(100),
            ),
            [
                [[Decimal("6")], [Decimal("110")]],
                [
                    [Decimal("-20.52164898666666825732818324")],
                    [Decimal("110.0000000000000000000000000")],
                ],
                [
                    [Decimal("-45.95704027292189299716690394")],
                    [Decimal("99.46431596707811382371139380")],
                ],
                [
                    [Decimal("-64.71067812000000341043914887")],
                    [Decimal("80.71067812000000341043914887")],
                ],
            ],
        )

    def test_approximate_arc_as_bezier(self) -> None:
        "Test cases for the approximate_arc_as_bezier function"

        # Test case for a circle of centre (100, 5), an angle of pi / 5,
        # start angle of pi, radius of 300
        self.assertEqual(
            math_utils.approximate_arc_as_bezier(
                math_utils.vec_2d(100, 5),
                math_utils.math_pi / 5,
                start_angle=math_utils.math_pi,
                radius=300,
            ),
            [
                {
                    "vertices": [
                        [[Decimal("-200")], [Decimal("5")]],
                        [
                            [Decimal("-200.0000000000000000000000000")],
                            [Decimal("-58.35377612000000491221385345")],
                        ],
                        [
                            [Decimal("-179.9435136008519083519076103")],
                            [Decimal("-120.0812941495071059325461326")],
                        ],
                        [
                            [Decimal("-142.7050983199999900641330441")],
                            [Decimal("-171.3355756900000015363616512")],
                        ],
                    ]
                }
            ],
        )

        # Test case for a circle of centre (4, 6), an angle of pi / 3,
        # start angle of pi / 4, radius of 15
        self.assertEqual(
            math_utils.approximate_arc_as_bezier(
                math_utils.vec_2d(4, 6),
                math_utils.math_pi / 3,
                start_angle=math_utils.math_pi / 4,
                radius=15,
            ),
            [
                {
                    "vertices": [
                        [
                            [Decimal("14.60660171800000051156587233")],
                            [Decimal("16.60660171800000051156587233")],
                        ],
                        [
                            [Decimal("10.81722789873793055000993900")],
                            [Decimal("20.39597553726207047312180566")],
                        ],
                        [
                            [Decimal("5.294095225007753615452742781")],
                            [Decimal("21.87589447674568350843245422")],
                        ],
                        [
                            [Decimal("0.117714323500000328515113779")],
                            [Decimal("20.48888739450000018305075855")],
                        ],
                    ]
                }
            ],
        )

        # Test case for a circle of centre (3, 1), an angle of pi / 4,
        # start point of (6, 9)
        self.assertEqual(
            math_utils.approximate_arc_as_bezier(
                math_utils.vec_2d(3, 1),
                math_utils.math_pi / 4,
                math_utils.vec_2d(6, 9),
            ),
            [
                {
                    "vertices": [
                        [
                            [Decimal("6.000000000099181212546588185")],
                            [Decimal("9.000000000264483865840880530")],
                        ],
                        [
                            [Decimal("3.878268081095702269435648804")],
                            [Decimal("9.795649469890788406613051947")],
                        ],
                        [
                            [Decimal("1.527366257301462552393964922")],
                            [Decimal("9.715856485704911337132180109")],
                        ],
                        [
                            [Decimal("-0.535533905922621523663195874")],
                            [Decimal("8.778174593371527909579080980")],
                        ],
                    ]
                }
            ],
        )

        # Test case for a circle of centre (10, 200), an angle of pi / 2,
        # start point of (20, 255)
        self.assertEqual(
            math_utils.approximate_arc_as_bezier(
                math_utils.vec_2d(10, 200),
                math_utils.math_pi / 2,
                math_utils.vec_2d(20, 255),
            ),
            [
                {
                    "vertices": [
                        [
                            [Decimal("20.00000000000094031123021987")],
                            [Decimal("255.0000000000051740391419780")],
                        ],
                        [
                            [Decimal("-10.37566124266858482950943583")],
                            [Decimal("260.5228474986723601946629801")],
                        ],
                        [
                            [Decimal("-39.47715250133798788362097586")],
                            [Decimal("240.3756612426704654519698756")],
                        ],
                        [
                            [Decimal("-45.00000000000517403914197795")],
                            [Decimal("210.0000000000009403112302199")],
                        ],
                    ]
                }
            ],
        )


class TestSaveLibrary(unittest.TestCase):
    "Class to test the functions in the save library"

    def test_convert_value_to_toml_str(self) -> None:
        "Test cases for the convert_value_to_toml_str function"

        # Test a string
        self.assertEqual(save_lib.convert_obj_to_toml_str("wow"), '"wow"')

        # Test a number
        self.assertEqual(save_lib.convert_obj_to_toml_str(1), "1")

        # Test a decimal
        self.assertEqual(save_lib.convert_obj_to_toml_str(Decimal(10)), "10")

        # Test a boolean True
        self.assertEqual(save_lib.convert_obj_to_toml_str(True), "true")

        # Test a boolean False
        self.assertEqual(save_lib.convert_obj_to_toml_str(False), "false")

        # Test a list
        self.assertEqual(
            save_lib.convert_obj_to_toml_str([1, 2, 3, 4, 5]),
            "[\n    1,\n    2,\n    3,\n    4,\n    5\n]",
        )

        # Test a dictionary
        self.assertEqual(
            save_lib.convert_obj_to_toml_str({1: 1, 2: 2, 3: 3, 4: 4, 5: 5}),
            "{ 1 = 1, 2 = 2, 3 = 3, 4 = 4, 5 = 5 }",
        )

    def test_convert_dict_to_toml_str(self) -> None:
        "Test cases for the convert_dict_to_toml_str function"

        # The dictionary with no dictionaries inside
        dict_with_no_dict_inside = {
            "wow": 1,
            5: "lovely",
            "awesome": [3, 5, 7, 9, "string", True, 0.9, (10, 2)],
            "amazing": True,
            10: "magnificent",
        }

        # Convert the dictionary with no dictionaries inside to a TOML string
        dict_with_no_dict_inside_toml_str = save_lib.convert_dict_to_toml_str(
            dict_with_no_dict_inside
        )

        # Test for a dictionary with no dictionaries inside
        self.assertEqual(
            dict_with_no_dict_inside_toml_str,
            "\n".join(
                line[16:]
                for line in """
                wow = 1
                5 = "lovely"
                amazing = true
                10 = "magnificent"
                awesome = [
                    3,
                    5,
                    7,
                    9,
                    "string",
                    true,
                    0.9,
                    [
                        10,
                        2
                    ]
                ]
                """.split(
                    "\n"
                )
            ).strip(),
        )

        # Test to parse the above dictionary with TOML lib
        self.assertEqual(
            tomllib.loads(dict_with_no_dict_inside_toml_str),
            {
                "wow": 1,
                "5": "lovely",
                "amazing": True,
                "10": "magnificent",
                "awesome": [3, 5, 7, 9, "string", True, 0.9, [10, 2]],
            },
        )

        # The dictionary with dictionaries inside
        dict_with_dict_inside = {
            "wow": 1,
            "nested_dict": {
                "omg": 10,
                "damn": 20,
                50: 0.9,
                20: True,
                6: False,
                69: "Hell yeah!",
            },
            "type": 200,
            "oof": "ouch",
            "obj": [9, True, False, 78, -8.5, ["lol"]],
        }

        # Convert the dictionary with dictionaries inside to a TOML string
        dict_with_dict_inside_toml_str = save_lib.convert_dict_to_toml_str(
            dict_with_dict_inside
        )

        # Test for a dictionary with dictionaries inside
        self.assertEqual(
            dict_with_dict_inside_toml_str,
            "\n".join(
                line[16:]
                for line in """
                wow = 1
                type = 200
                oof = "ouch"
                obj = [
                    9,
                    true,
                    false,
                    78,
                    -8.5,
                    ["lol"]
                ]

                [nested_dict]
                omg = 10
                damn = 20
                50 = 0.9
                20 = true
                6 = false
                69 = "Hell yeah!"
                """.split(
                    "\n"
                )
            ).strip(),
        )

        # Test to parse the above dictionary with TOML lib
        self.assertEqual(
            tomllib.loads(dict_with_dict_inside_toml_str),
            {
                "wow": 1,
                "type": 200,
                "oof": "ouch",
                "obj": [9, True, False, 78, -8.5, ["lol"]],
                "nested_dict": {
                    "omg": 10,
                    "damn": 20,
                    "50": 0.9,
                    "20": True,
                    "6": False,
                    "69": "Hell yeah!",
                },
            },
        )

        # The dictionary with a list of dictionaries inside
        dict_with_list_of_dict_inside = {
            "attr": "cool",
            "lame": 0,
            "def": 9.9,
            10: 64,
            "nested": {
                "man": "child",
                "old": "granny",
                0: 1,
                9: 5,
                -48: 69,
                "float": -5.6,
            },
            8.4: "meh",
            0: True,
            "fart": False,
            "list": [
                {"name": "hi", "index": 0, "type": "hex"},
                {"name": "oh", "index": 99, "type": "lol"},
                {"name": "wo", "index": 345, "type": "omg"},
                {"name": "hacks", "index": 239, "type": "amazing"},
                {"name": "sneeze", "index": 934, "type": "o.o"},
                {"name": "hooks", "index": 874, "type": "he"},
                {"name": "wood", "index": 34758, "type": "hexadecimal"},
            ],
        }

        # Convert the dictionary with a list of dictionaries inside
        # to a TOML string
        dict_with_list_of_dict_inside_toml_str = (
            save_lib.convert_dict_to_toml_str(dict_with_list_of_dict_inside)
        )

        # Test for a dictionary with a list of dictionaries inside
        self.assertEqual(
            dict_with_list_of_dict_inside_toml_str,
            "\n".join(
                line.strip()
                for line in """
                attr = "cool"
                lame = 0
                def = 9.9
                10 = 64
                "8.4" = "meh"
                0 = true
                fart = false

                [[list]]
                name = "hi"
                index = 0
                type = "hex"

                [[list]]
                name = "oh"
                index = 99
                type = "lol"

                [[list]]
                name = "wo"
                index = 345
                type = "omg"

                [[list]]
                name = "hacks"
                index = 239
                type = "amazing"

                [[list]]
                name = "sneeze"
                index = 934
                type = "o.o"

                [[list]]
                name = "hooks"
                index = 874
                type = "he"

                [[list]]
                name = "wood"
                index = 34758
                type = "hexadecimal"

                [nested]
                man = "child"
                old = "granny"
                0 = 1
                9 = 5
                -48 = 69
                float = -5.6
                """.split(
                    "\n"
                )
            ).strip(),
        )

        # Test to parse the above dictionary with TOML lib
        self.assertEqual(
            tomllib.loads(dict_with_list_of_dict_inside_toml_str),
            {
                "attr": "cool",
                "lame": 0,
                "def": 9.9,
                "10": 64,
                "8.4": "meh",
                "0": True,
                "fart": False,
                "list": [
                    {"name": "hi", "index": 0, "type": "hex"},
                    {"name": "oh", "index": 99, "type": "lol"},
                    {"name": "wo", "index": 345, "type": "omg"},
                    {"name": "hacks", "index": 239, "type": "amazing"},
                    {"name": "sneeze", "index": 934, "type": "o.o"},
                    {"name": "hooks", "index": 874, "type": "he"},
                    {"name": "wood", "index": 34758, "type": "hexadecimal"},
                ],
                "nested": {
                    "man": "child",
                    "old": "granny",
                    "0": 1,
                    "9": 5,
                    "-48": 69,
                    "float": -5.6,
                },
            },
        )

    def test_convert_all_floats_to_decimal(self) -> None:
        "Test cases for the convert_all_floats_to_decimal function"

        # Test case for a float
        self.assertEqual(
            save_lib.convert_all_floats_to_decimal(6.9), Decimal(6.9)
        )

        # Test case for an integer
        self.assertEqual(save_lib.convert_all_floats_to_decimal(10), 10)

        # Test case for a string
        self.assertEqual(save_lib.convert_all_floats_to_decimal("wow"), "wow")

        # Test case for a boolean
        self.assertEqual(save_lib.convert_all_floats_to_decimal(False), False)

        # Test case for a tuple
        self.assertEqual(
            save_lib.convert_all_floats_to_decimal((1, 9.5, "lol", True)),
            (1, Decimal(9.5), "lol", True),
        )

        # Test case for a list
        self.assertEqual(
            save_lib.convert_all_floats_to_decimal(["omg", 68.7, 100, True]),
            ["omg", Decimal(68.7), 100, True],
        )

        # Test case for a dictionary
        self.assertEqual(
            save_lib.convert_all_floats_to_decimal(
                {
                    "omg": "wow",
                    "heh": 0,
                    1: 5,
                    (1, 4.5): -0.6,
                    "man": "up",
                    "math": True,
                    "list": [5.6, "omg", 420, 6.9, False],
                }
            ),
            {
                "omg": "wow",
                "heh": 0,
                1: 5,
                (1, 4.5): Decimal(-0.6),
                "man": "up",
                "math": True,
                "list": [Decimal(5.6), "omg", 420, Decimal(6.9), False],
            },
        )

    def test_is_toml_file(self) -> None:
        "Test cases for th is_toml_file function"

        # Test for a file that ends with ".toml"
        self.assertEqual(save_lib.is_toml_file("config.toml"), True)

        # Test for a file that ends with ".TOML"
        self.assertEqual(save_lib.is_toml_file("CONFIG.TOML"), True)

        # Test for a file with trailing whitespaces but ends with ".toml"
        self.assertEqual(save_lib.is_toml_file("config.toml "), True)

        # Test for a file with TOML in mixed case, like ".ToMl"
        self.assertEqual(save_lib.is_toml_file("config.ToMl"), True)

        # Test for a file with TOML in mixed case, like ".tOmL"
        self.assertEqual(save_lib.is_toml_file("config.tOmL"), True)

        # Test for a file that ends in ".py"
        self.assertEqual(save_lib.is_toml_file("main.py"), False)

        # Test for a file that ends in ".ods"
        self.assertEqual(save_lib.is_toml_file("spreadsheet.ods"), False)

        # Test for a file that doesn't have a file extension
        self.assertEqual(save_lib.is_toml_file("run"), False)

    def test_is_valid_logo_data(self) -> None:
        "Test cases for the is_valid_logo_data function"

        # Test for an empty list
        self.assertEqual(save_lib.is_valid_logo_data([]), False)

        # Test for an empty dictionary
        self.assertEqual(save_lib.is_valid_logo_data({}), False)

        # Test for a dictionary with no vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": []}), False)

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": True}), False)

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(
            save_lib.is_valid_logo_data({"vertices": "wow"}), False
        )

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": {}}), False)

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": None}), False)

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": 1}), False)

        # Test for a dictionary with some other data type for the vertices
        self.assertEqual(save_lib.is_valid_logo_data({"vertices": 2.0}), False)

        # Test for a dictionary with only 1 vertex
        self.assertEqual(
            save_lib.is_valid_logo_data({"vertices": math_utils.vec_2d(2, 3)}),
            False,
        )

        # Test for a dictionary with only 1 vertex in a list
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {"vertices": [math_utils.vec_2d(2, 3)]}
            ),
            False,
        )

        # Test for a dictionary with only 1 vertex in a tuple
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {"vertices": (math_utils.vec_2d(2, 3),)}
            ),
            False,
        )

        # Test for a dictionary with 2 vertices in a list
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                    ]
                }
            ),
            True,
        )

        # Test for a dictionary with 2 vertices in a tuple
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": (
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                    )
                }
            ),
            True,
        )

        # Test for a dictionary with 3 vertices in a list
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(11, 12),
                    ]
                }
            ),
            False,
        )

        # Test for a dictionary with 3 vertices in a tuple
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": (
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(11, 12),
                    )
                }
            ),
            False,
        )

        # Test for a dictionary with 4 vertices in a list
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(45, 10),
                        math_utils.vec_2d(45, 20),
                    ]
                }
            ),
            True,
        )

        # Test for a dictionary with 4 vertices in a tuple
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": (
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(45, 10),
                        math_utils.vec_2d(45, 20),
                    )
                }
            ),
            True,
        )

        # Test for a dictionary with 5 vertices in a list
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(45, 10),
                        math_utils.vec_2d(45, 20),
                        math_utils.vec_2d(56, 78),
                    ]
                }
            ),
            False,
        )

        # Test for a dictionary with 5 vertices in a tuple
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": (
                        math_utils.vec_2d(2, 3),
                        math_utils.vec_2d(9, 10),
                        math_utils.vec_2d(45, 10),
                        math_utils.vec_2d(45, 20),
                        math_utils.vec_2d(56, 78),
                    )
                }
            ),
            False,
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data({"vertices": [["wow"], [False]]}), False
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        [2, 3],
                    ]
                }
            ),
            False,
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        [set(), {}],
                    ]
                }
            ),
            False,
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        [[save_lib.is_valid_logo_data], ["function"]],
                    ]
                }
            ),
            False,
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        [[[]], [tuple()]],
                    ]
                }
            ),
            False,
        )

        # Test with some other weird data type in the list of vertices
        self.assertEqual(
            save_lib.is_valid_logo_data(
                {
                    "vertices": [
                        [[{}], [set()]],
                    ]
                }
            ),
            False,
        )

        # Test with a list of valid dictionaries
        self.assertEqual(
            save_lib.is_valid_logo_data(
                [
                    {
                        "vertices": [
                            math_utils.vec_2d(10, 24),
                            math_utils.vec_2d(3, 24),
                            math_utils.vec_2d(20, 24),
                            math_utils.vec_2d(9, 24),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(9, 1),
                            math_utils.vec_2d(2, 3),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(20, 3),
                            math_utils.vec_2d(4, 21),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(4, 20),
                            math_utils.vec_2d(4, 21),
                            math_utils.vec_2d(7, 20),
                            math_utils.vec_2d(9, 4),
                        ]
                    },
                ]
            ),
            True,
        )

    def test_is_valid_logo_dict(self) -> None:
        "Test cases for the is_valid_logo_dict function"

        # Test for an empty dictionary
        self.assertEqual(save_lib.is_valid_logo_dict({}), False)

        # Test for a dictionary without the data "key"
        self.assertEqual(save_lib.is_valid_logo_dict({"huh": "what"}), False)

        # Test for a dictionary without the data "key"
        self.assertEqual(
            save_lib.is_valid_logo_dict({"background_colour": "blue"}), False
        )

        # Test for a dictionary with invalid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {"data": True, "background_colour": "blue"}
            ),
            False,
        )

        # Test for a dictionary with invalid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {"data": [], "background_colour": "blue"}
            ),
            False,
        )

        # Test for a dictionary with invalid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {"data": "oooo", "background_colour": "blue"}
            ),
            False,
        )

        # Test for a dictionary with invalid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {"data": [{}], "background_colour": "blue"}
            ),
            False,
        )

        # Test for a dictionary with invalid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {"data": [{"vertices": []}], "background_colour": "blue"}
            ),
            False,
        )

        # Test for a dictionary with valid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {
                    "data": [
                        {
                            "vertices": [
                                math_utils.vec_2d(4, 5),
                                math_utils.vec_2d(4, 2),
                            ]
                        }
                    ],
                    "background_colour": "blue",
                }
            ),
            True,
        )

        # Test for a dictionary with valid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {
                    "data": [
                        {
                            "vertices": [
                                math_utils.vec_2d(4, 5),
                                math_utils.vec_2d(4, 2),
                                math_utils.vec_2d(2, 10),
                                math_utils.vec_2d(34, 2),
                            ]
                        }
                    ],
                    "background_colour": "blue",
                }
            ),
            True,
        )

        # Test for a dictionary with valid data
        self.assertEqual(
            save_lib.is_valid_logo_dict(
                {
                    "data": [
                        {
                            "vertices": [
                                math_utils.vec_2d(4, 5),
                                math_utils.vec_2d(4, 2),
                                math_utils.vec_2d(2, 10),
                                math_utils.vec_2d(34, 2),
                            ]
                        },
                        {
                            "vertices": [
                                math_utils.vec_2d(98, 21),
                                math_utils.vec_2d(5, 10),
                            ]
                        },
                    ],
                    "background_colour": "blue",
                }
            ),
            True,
        )


class TestDrawLibrary(unittest.TestCase):
    "Class to test the functions in the drawing library"

    def test_get_min_and_max_coordinates_from_vertices(self) -> None:
        "Test cases for the get_min_and_max_coordinates_from_vertices function"

        # Test with an empty list of vertices
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_vertices([]),
            (0, 0, 0, 0),
        )

        # Test with one vertex in the list
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_vertices(
                [
                    math_utils.vec_2d(6, 9),
                ]
            ),
            (6, 6, 9, 9),
        )

        # Test with a list of vertices
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_vertices(
                [
                    math_utils.vec_2d(10, 5),
                    math_utils.vec_2d(3, 2),
                    math_utils.vec_2d(-1, 0),
                    math_utils.vec_2d(-6, -100),
                ]
            ),
            (-6, 10, -100, 5),
        )

        # Test with a list of vertices with floats
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_vertices(
                [
                    math_utils.vec_2d(57, 3),
                    math_utils.vec_2d(7, 82),
                    math_utils.vec_2d(4, 56),
                    math_utils.vec_2d(81, 20),
                    math_utils.vec_2d(22.5, 66.9),
                    math_utils.vec_2d(5.2, 3.6),
                ]
            ),
            (4, 81, 3, 82),
        )

    def test_get_min_and_max_coords_from_list_of_min_max_coords(
        self,
    ) -> None:
        """
        Test cases for the
        get_min_and_max_coords_from_list_of_min_max_coords
        function
        """

        # Test with an empty list of minimum and maximum coordinates
        self.assertEqual(
            draw_lib.get_min_and_max_coords_from_list_of_min_max_coords([]),
            (0, 0, 0, 0),
        )

        # Test with a list of minimum and maximum coordinates
        self.assertEqual(
            draw_lib.get_min_and_max_coords_from_list_of_min_max_coords(
                [
                    (-10, 100, 3, 200),
                    (-4, 300, 25, 50),
                    (20, 99, 33, 54),
                    (-50, 78, 89, 120),
                ]
            ),
            (-50, 300, 3, 200),
        )

        # Test with a bigger list of minimum and maximum coordinates
        self.assertEqual(
            draw_lib.get_min_and_max_coords_from_list_of_min_max_coords(
                [
                    (300, 350, 200, 460),
                    (-31, 54, 38, 100),
                    (57, 432, 90, 123),
                    (78, 102, 74, 152),
                    (-100, 300, 32, 54),
                    (76, 243, 12, 90),
                ]
            ),
            (-100, 432, 12, 460),
        )

        # Test with a list of list of minimum and maximum coordinates
        self.assertEqual(
            draw_lib.get_min_and_max_coords_from_list_of_min_max_coords(
                [
                    [
                        (9, 54, 78, 148),
                        (-2, 43, 10, 38),
                        (-10, 9, 3, 61),
                        (0.5, 3.69, 20, 178.8),
                        (20, 34, 57, 109),
                    ],
                    [
                        (13, 42, 15, 100),
                        (30, 99.92, 43, 66.9),
                        (-4, 78, 12, 58),
                        (-90, 48, 34, 42.23),
                        (48, 56, 2, 73),
                    ],
                    [
                        (43, 98, 72, 102),
                        (-94, 24, 52, 78.9),
                        (30, 33.39, 13, 48),
                        (10, 76.6, 12, 57),
                        (19, 53, 83, 120),
                    ],
                ]
            ),
            (-94, 99.92, 2, 178.8),
        )

    def test_get_min_and_max_coordinates_from_data(self) -> None:
        "Test cases for the get_min_and_max_coordinates_from_data function"

        # Test case for an object with no points
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_data({"vertices": []}),
            (0, 0, 0, 0),
        )

        # Test case for an object with one point
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_data(
                {"vertices": [math_utils.vec_2d(5, 7)]}
            ),
            (5, 5, 7, 7),
        )

        # Test case for an object with 2 points
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_data(
                {
                    "vertices": [
                        math_utils.vec_2d(4, 89),
                        math_utils.vec_2d(-14, 43),
                    ]
                }
            ),
            (-14, 4, 43, 89),
        )

        # Test case for an object with 4 points
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_data(
                {
                    "vertices": [
                        math_utils.vec_2d(7, 123),
                        math_utils.vec_2d(5, 3),
                        math_utils.vec_2d(-2, 13),
                        math_utils.vec_2d(-31, 34),
                    ]
                }
            ),
            (-31, 7, 3, 123),
        )

        # Test case for a list of objects
        self.assertEqual(
            draw_lib.get_min_and_max_coordinates_from_data(
                [
                    {
                        "vertices": [
                            math_utils.vec_2d(56, 78),
                            math_utils.vec_2d(74, 12),
                            math_utils.vec_2d(13, 48),
                            math_utils.vec_2d(98, 21),
                            math_utils.vec_2d(45, 19),
                            math_utils.vec_2d(34, -9),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(-92, 33),
                            math_utils.vec_2d(84, 20),
                            math_utils.vec_2d(-4, 12),
                            math_utils.vec_2d(-1, 43),
                            math_utils.vec_2d(59, 132),
                            math_utils.vec_2d(44, 28),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(439, 21),
                            math_utils.vec_2d(97, 4),
                            math_utils.vec_2d(78, 32),
                            math_utils.vec_2d(57, 40),
                            math_utils.vec_2d(90, 81),
                            math_utils.vec_2d(64, 87),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(83, 18),
                            math_utils.vec_2d(22, 109),
                            math_utils.vec_2d(45, 135),
                            math_utils.vec_2d(3, 17),
                            math_utils.vec_2d(99, 77),
                            math_utils.vec_2d(69, 96),
                        ]
                    },
                ]
            ),
            [
                (13, 98, -9, 78),
                (-92, 84, 12, 132),
                (57, 439, 4, 87),
                (3, 99, 17, 135),
            ],
        )

    def test_get_min_screen_size(self) -> None:
        "Test cases for the get_min_screen_size function"

        # Test case for an object with no vertices
        self.assertEqual(draw_lib.get_min_screen_size({"vertices": []}), (0, 0))

        # Test case for an object with 1 vertex
        self.assertEqual(
            draw_lib.get_min_screen_size(
                {"vertices": [math_utils.vec_2d(5, 4)]}
            ),
            (10, 8),
        )

        # Test case for an object with 2 vertices
        self.assertEqual(
            draw_lib.get_min_screen_size(
                {
                    "vertices": [
                        math_utils.vec_2d(5, 7),
                        math_utils.vec_2d(57, 43),
                    ]
                }
            ),
            (114, 86),
        )

        # Test case for an object with 4 vertices
        self.assertEqual(
            draw_lib.get_min_screen_size(
                {
                    "vertices": [
                        math_utils.vec_2d(3, 1),
                        math_utils.vec_2d(34, 78),
                        math_utils.vec_2d(-9, 43),
                        math_utils.vec_2d(-10, 20),
                    ]
                }
            ),
            (68, 156),
        )

        # Test case for a list of objects
        self.assertEqual(
            draw_lib.get_min_screen_size(
                [
                    {
                        "vertices": [
                            math_utils.vec_2d(45, 12),
                            math_utils.vec_2d(-6, 28),
                            math_utils.vec_2d(34, 90),
                            math_utils.vec_2d(-15, 315),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(43, 4),
                            math_utils.vec_2d(12, 93),
                            math_utils.vec_2d(45, 124),
                            math_utils.vec_2d(52, 78),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(89, 32),
                            math_utils.vec_2d(458, 563),
                            math_utils.vec_2d(15, 90),
                            math_utils.vec_2d(31, 87),
                        ]
                    },
                    {
                        "vertices": [
                            math_utils.vec_2d(45, 123),
                            math_utils.vec_2d(348, 145),
                            math_utils.vec_2d(-10, 43),
                            math_utils.vec_2d(-98.3, 59),
                        ]
                    },
                ]
            ),
            (916, 1126),
        )


# Name safeguard
if __name__ == "__main__":
    unittest.main()
