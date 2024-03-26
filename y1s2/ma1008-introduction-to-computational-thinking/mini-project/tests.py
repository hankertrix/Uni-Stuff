# The tests to make sure things work as they should

import math
import tomllib
import unittest
from decimal import Decimal

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
            Decimal(1 / (2 ** Decimal(1 / 2))),
        )

        # Test case for pi/3 radians
        self.assertAlmostEqual(
            math_utils.math_sin(math.pi / 3), Decimal(3 ** Decimal(1 / 2)) / 2
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
            Decimal(1 / (2 ** Decimal(1 / 2))),
        )

        # Test case for pi/3 radians
        self.assertEqual(math_utils.math_cos(math.pi / 3), Decimal(1 / 2))

        # Test case for pi
        self.assertEqual(math_utils.math_cos(math.pi), -1)

    def test_math_tan(self) -> None:
        "Test cases for the math_cos function"

        # Test case for 30 degrees
        self.assertAlmostEqual(
            math_utils.math_tan(math.radians(30)), 1 / (3 ** (Decimal(1 / 2)))
        )

        # Test case for 45 degrees
        self.assertAlmostEqual(
            math_utils.math_tan(math.radians(45)),
            1,
        )

        # Test case for pi/3 radians
        self.assertAlmostEqual(
            math_utils.math_tan(math.pi / 3), Decimal(3 ** Decimal(1 / 2))
        )

        # Test case for pi
        self.assertEqual(math_utils.math_tan(math.pi), 0)

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
            save_lib.convert_obj_to_toml_str([1, 2, 3, 4, 5]), "[1, 2, 3, 4, 5]"
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
                line.strip()
                for line in """
                wow = 1
                5 = "lovely"
                amazing = true
                10 = "magnificent"
                awesome = [3, 5, 7, 9, "string", true, 0.9, [10, 2]]
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
                line.strip()
                for line in """
                wow = 1
                type = 200
                oof = "ouch"
                obj = [9, true, false, 78, -8.5, ["lol"]]

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
                    "list": [5.6, "omg", 420, 6.9, False]
                }
            ),
            {
                "omg": "wow",
                "heh": 0,
                1: 5,
                (1, 4.5): Decimal(-0.6),
                "man": "up",
                "math": True,
                "list": [Decimal(5.6), "omg", 420, Decimal(6.9), False]
            },
        )


# Name safeguard
if __name__ == "__main__":
    unittest.main()
