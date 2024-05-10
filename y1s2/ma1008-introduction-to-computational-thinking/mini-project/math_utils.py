# The module containing the math utilities for the mini project

import math
from decimal import Decimal
from typing import Any, Callable

# Pi as a decimal
math_pi = Decimal(math.pi)


def math_sin(angle_in_radians: float | int | Decimal) -> Decimal:
    "Wrapper function for the math.sin function to be more accurate"

    # Get the result of the math.sin function
    result = math.sin(angle_in_radians)

    # Return the result as a decimal rounded to 10 decimal places
    return Decimal(round(result, 10))


def math_cos(angle_in_radians: float | int | Decimal) -> Decimal:
    "Wrapper function for the math.cos function to be more accurate"

    # Get the result of the math.cos function
    result = math.cos(angle_in_radians)

    # Return the result as a decimal rounded to 10 decimal places
    return Decimal(round(result, 10))


def math_tan(angle_in_radians: float | int | Decimal) -> Decimal:
    "Wrapper function for the math.tan function to be more accurate"

    # Get the result of the math.tan function
    result = math.tan(angle_in_radians)

    # Return the result as a decimal rounded to 10 decimal places
    return Decimal(round(result, 10))


def sqrt(number: float | int | Decimal) -> Decimal:
    "Function to take the square root of a number"
    return Decimal(number) ** Decimal(1 / 2)


def init_matrix(
    rows: int, columns: int, init_value: float | int | Decimal = 0
) -> list[list[int | Decimal]]:
    """
    A function to initialise a matrix.

    The matrix is a list of list of decimals or integers,
    and each list in this matrix represents a row of the matrix.

    The init_value takes any value and
    initialises the entire matrix with that value.
    """

    # If the number of rows or columns less than 1, raise an error
    if (invalid_rows := rows < 1) or columns < 1:
        raise ValueError(
            "A matrix cannot have zero or negative number of "
            f"{'rows' if invalid_rows else 'columns'}"
        )

    # Initialise the matrix
    matrix: list[list[int | Decimal]] = []

    # Iterates over the number of rows in the matrix
    for row in range(rows):

        # Append a list that is the number of columns long
        matrix.append([Decimal(init_value)] * columns)

    # Return the matrix
    return matrix


def vec_2d(
    x: float | int | Decimal, y: float | int | Decimal
) -> list[list[int | Decimal]]:
    "Function to initialise a 2D vector"
    return [[Decimal(x)], [Decimal(y)]]


def vec_3d(
    x: float | int | Decimal, y: float | int | Decimal, z: float | int | Decimal
) -> list[list[int | Decimal]]:
    "Function to initialise a 3D vector"
    return [[Decimal(x)], [Decimal(y)], [Decimal(z)]]


def vec(*values: float | int | Decimal) -> list[list[int | Decimal]]:
    """
    Function to create a vector of n dimensions,
    which is based on the number of arguments
    given to the function.
    """
    return [[Decimal(value)] for value in values]


def matrix_shape(matrix: list[list[int | Decimal]]) -> tuple[int, int]:
    "Function to get the number of rows and columns of a matrix"

    # Get the number of rows for the matrix
    num_of_rows = len(matrix)

    # If the number of rows is less than 1, then return (0, 0)
    if num_of_rows < 1:
        return (0, 0)

    # Otherwise, get the number of items in the first list
    # to get the number of columns
    num_of_columns = len(matrix[0])

    # Return the number of rows and columns of a matrix
    return (num_of_rows, num_of_columns)


def convert_2d_to_3d(
    vector: list[list[int | Decimal]], z_coordinate: float | int | Decimal = 1
) -> list[list[int | Decimal]]:
    "Function to convert a 2D vector to a 3D vector"

    # Get the shape of the vector
    num_of_rows, num_of_columns = matrix_shape(vector)

    # If the vector isn't a 2D or 3D vector, raise an error
    if num_of_rows not in (2, 3) or num_of_columns != 1:
        raise ValueError(
            "The vector given is not a 2D or 3D vector, "
            f"it is an {num_of_rows} x {num_of_columns} matrix"
        )

    # If the vector is already a 3D vector, just return the vector
    if num_of_rows == 3:
        return vector

    # Otherwise, copy the vector
    vector_in_3d = vector[:]

    # Add the z coordinate to the vector
    vector_in_3d.append([Decimal(z_coordinate)])

    # Return the 3D vector
    return vector_in_3d


def convert_3d_to_2d(
    vector: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    "Function to convert a 3D vector to a 2D vector"

    # Get the shape of the vector
    num_of_rows, num_of_columns = matrix_shape(vector)

    # If the vector isn't a 3D or 2D vector, raise an error
    if num_of_rows not in (3, 2) or num_of_columns != 1:
        raise ValueError(
            "The vector given is not a 3D or 2D vector, "
            f"it is an {num_of_rows} x {num_of_columns} matrix"
        )

    # If the vector is already a 2D vector, just return the vector
    if num_of_rows == 2:
        return vector

    # Copies the vector
    vector_in_2d = vector[:]

    # Remove the z coordinate from the vector
    vector_in_2d.pop()

    # Return the 2D vector
    return vector_in_2d


def convert_vertices(
    data: list[list[dict]] | list[dict] | dict, to_3d: bool = True
) -> Any:
    "Function to convert all the vertices inside the data dictionary"

    # Initialise the conversion function variable
    conversion_function: Callable

    # If converting the vertices to 3D is wanted,
    # set the conversion function to the convert_2d_to_3d function
    if to_3d:
        conversion_function = convert_2d_to_3d

    # Otherwise, set the conversion function to the convert_3d_to_2d function
    else:
        conversion_function = convert_3d_to_2d

    # If the data given is a list or a tuple
    if isinstance(data, (list, tuple)):

        # Call the function on all the items in the list and return the result
        return [convert_vertices(item, to_3d) for item in data]

    # Otherwise, if the data given not a dictionary,
    # raise an error
    elif not isinstance(data, dict):
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

    # Otherwise, return the data dictionary with all the vertices converted
    # to the correct dimension
    return {
        **data,
        "vertices": [conversion_function(vertex) for vertex in vertices],
    }


def is_valid_matrix(matrix: list[list[int | Decimal]]) -> bool:
    "Function to determine if a matrix is valid"

    # Get the number of rows and columns of the matrix
    num_of_rows, num_of_columns = matrix_shape(matrix)

    # If there's a zero in the number of rows or columns of the matrix,
    # immediately return False
    if 0 in (num_of_rows, num_of_columns):
        return False

    # Otherwise, iterates over all of the rows of the matrix
    for row in matrix:

        # If the length of the row is not the same as the number of columns,
        # immediately return False
        if len(row) != num_of_columns:
            return False

    # Return True otherwise
    return True


def is_matrix_addable(*matrices: list[list[int | Decimal]]) -> bool:
    "Function to check if the matrices given can be added"

    # If any matrix given isn't valid, then immediately return False
    if any(not is_valid_matrix(matrix) for matrix in matrices):
        return False

    # If the number of matrices given is less than 2,
    # then immediately return True
    if len(matrices) < 2:
        return True

    # Get the shape of the first matrix
    shape = matrix_shape(matrices[0])

    # Return if the shapes of all the matrices given
    # are the same as the first one given
    return all(matrix_shape(matrix) == shape for matrix in matrices)


def add_matrices(
    *matrices: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    "Function to add matrices together"

    # Raise an error if the matrices given cannot be added
    if not is_matrix_addable(*matrices):
        raise ValueError("The matrices given are not addable")

    # Initialise the current matrix to the first matrix
    current_matrix = matrices[0]

    # Iterate from the second matrix onwards
    for next_matrix in matrices[1:]:

        # Initialise the matrix that stores the matrix sum
        sum_matrix: list[list[int | Decimal]] = []

        # Iterate over the rows of the matrix
        for i, row in enumerate(next_matrix):

            # Add the sum of the row to the sum_matrix variable
            sum_matrix.append(
                [
                    current_matrix[i][j] + column_value
                    for j, column_value in enumerate(row)
                ]
            )

        # Set the current matrix to the sum matrix
        current_matrix = sum_matrix

    # Rename the current matrix to the result matrix
    result_matrix = current_matrix

    # Return the result matrix
    return result_matrix


def scalar_product_matrix(
    k: float | int | Decimal, matrix: list[list[int | Decimal]]
) -> list[list[int | Decimal]]:
    "Function to multiply a scalar with a matrix"

    # If the matrix given isn't valid, raise an error
    if not is_valid_matrix(matrix):
        raise ValueError("The matrix given is not valid.")

    # Initialise the result matrix
    result_matrix: list[list[int | Decimal]] = []

    # Iterate over the rows of matrix
    for row in matrix:

        # Add the result of the scalar product to the result matrix
        result_matrix.append([Decimal(k) * number for number in row])

    # Return the result matrix
    return result_matrix


def subtract_matrix(
    matrix: list[list[int | Decimal]],
    matrix_to_subtract: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    """
    Subtract the second given matrix from the first one.
    Essentially, it's just matrix - matrix_to_subtract.

    It's a convenience function so that there's less things to type.
    """
    return add_matrices(matrix, scalar_product_matrix(-1, matrix_to_subtract))


def matrix_transpose(
    matrix: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    "Function to get the transpose of a matrix"

    # If the matrix isn't valid, raise an error
    if not is_valid_matrix(matrix):
        raise ValueError("The matrix given is not valid.")

    # Initialise the matrix transpose
    transpose: list[list[int | Decimal]] = []

    # Get the number of rows and columns in the matrix
    num_of_rows, num_of_columns = matrix_shape(matrix)

    # Iterate over the number of columns
    for j in range(num_of_columns):

        # Add the column as a row to the matrix transpose
        transpose.append([row[j] for row in matrix])

    # Return the matrix transpose
    return transpose


def is_matrix_multipliable(
    *matrices: list[list[int | Decimal]],
) -> bool:
    "Function to check if the matrices given are multipliable with each other"

    # If any matrix given isn't valid, then immediately return False
    if any(not is_valid_matrix(matrix) for matrix in matrices):
        return False

    # Gets the number of matrices given
    num_of_matrices = len(matrices)

    # If the number of matrices given is somehow 1 or less,
    # immediately return True
    if num_of_matrices < 2:
        return True

    # Initialise the variable to store the current matrix shape
    # Set it to the shape of the first matrix given
    current_matrix_shape = matrix_shape(matrices[0])

    # Iterates over the given matrices after the first matrix
    for _, next_matrix in enumerate(matrices[1:]):

        # Get the shape of the current matrix
        current_matrix_rows, current_matrix_columns = current_matrix_shape

        # Get the shape of the next matrix
        next_matrix_rows, next_matrix_columns = matrix_shape(next_matrix)

        # If the current matrix columns are not equal to the next matrix rows,
        # the matrices are not multipliable, so return False immediately
        if current_matrix_columns != next_matrix_rows:
            return False

        # Otherwise, the matrices are multipliable,
        # so set the current matrix shape to the shape of the new matrix
        current_matrix_shape = (current_matrix_rows, next_matrix_columns)

    # Return True if the loop completes as all matrices given are multipliable
    return True


def multiply_matrices(
    *matrices: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    "Function to multiply matrices together."

    # If the matrices given are not multipliable, then raise an error
    if not is_matrix_multipliable(*matrices):
        raise ValueError("The matrices given are not multipliable")

    # Initialise the current matrix to the first matrix
    current_matrix = matrices[0]

    # Iterate from the second matrix onwards
    for next_matrix in matrices[1:]:

        # Get the number of rows and columns in the next matrix
        next_matrix_rows, next_matrix_columns = matrix_shape(next_matrix)

        # Initialise the matrix to hold the result of the multiplication
        multiplied_matrix: list[list[int | Decimal]] = []

        # Iterates over the rows in the current matrix
        for i, current_matrix_row in enumerate(current_matrix):

            # The row of the multiplied matrix
            multiplied_matrix_row: list[int | Decimal] = []

            # Iterates over the columns in the next matrix
            for j in range(next_matrix_columns):

                # Add the matrix product for the element
                # to the row of the multiplied matrix
                multiplied_matrix_row.append(
                    sum(
                        current_matrix_row[k] * next_matrix[k][j]
                        for k in range(next_matrix_rows)
                    )
                )

            # Add the row to the multiplied matrix
            multiplied_matrix.append(multiplied_matrix_row)

        # Set the current matrix to the multiplied matrix
        current_matrix = multiplied_matrix

    # Rename the current matrix to the result matrix
    result_matrix = current_matrix

    # Return the result matrix
    return result_matrix


def vec_dot_product(
    vector_1: list[list[int | Decimal]], vector_2: list[list[int | Decimal]]
) -> int | Decimal:
    "Function to get the dot product of the vectors given"

    # Get the number of rows and columns of the first vector
    vector_1_shape = matrix_shape(vector_1)

    # Get the number of columns of the first vector
    _, vector_1_num_of_columns = vector_1_shape

    # If the number of columns of the first vector is not 1,
    # or the number of rows and columns of the two vectors
    # are not the same, then raise an error
    if vector_1_num_of_columns != 1 or vector_1_shape != matrix_shape(vector_2):
        raise ValueError(
            "The dot product cannot be calculated for the given vectors"
        )

    # Take the transpose of the first vector
    vector_1_transpose = matrix_transpose(vector_1)

    # Multiply the transpose of the first vector with the second vector
    dot_product_matrix = multiply_matrices(vector_1_transpose, vector_2)

    # Pull out the dot product result
    dot_product = dot_product_matrix[0][0]

    # Return the dot product
    return dot_product


def vec_norm(vector: list[list[int | Decimal]]) -> Decimal:
    "Function to get the norm, or the length of a vector"
    return sqrt(vec_dot_product(vector, vector))


def vec_2d_transform_top_left_origin_to_centre_origin(
    x_coord: float | int | Decimal,
    y_coord: float | int | Decimal,
    width: float | int | Decimal,
    height: float | int | Decimal,
) -> list[list[int | Decimal]]:
    """
    Function to transform the coordinates from having the
    top left corner as the origin to having the centre be the origin.

    It returns a 2D vector.
    """

    # Get half of the width and the height
    half_width = Decimal(width) / 2
    half_height = Decimal(height) / 2

    # Subtract half the width from the x coordinate
    new_x_coord = Decimal(x_coord) - half_width

    # Subtract half the height from the y coordinate
    new_y_coord = Decimal(y_coord) - half_height

    # Invert the y coordinate, as the the y coordinate above
    # the origin is positive, while the y coordinate below
    # the origin is negative
    new_y_coord = new_y_coord * -1

    # Return the vector 2D of the new coordinates
    return vec_2d(new_x_coord, new_y_coord)


def vec_3d_translate(
    x_translation: float | int | Decimal = 0,
    y_translation: float | int | Decimal = 0,
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to translate a given 3D vector.

    For example:
        (3, 5, 9) translated by (x, y) will give
        (3 + x, 5 + y, 9).

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the translation
    translation_matrix: list[list[int | Decimal]] = [
        [1, 0, Decimal(x_translation)],
        [0, 1, Decimal(y_translation)],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return translation_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(translation_matrix, vec_3d)


def vec_3d_rotate(
    angle: float | int | Decimal,
    in_degrees: bool = True,
    anti_clockwise: bool = True,
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to rotate a vector anti-clockwise about the
    origin in the x-y plane by an angle.

    For example:
        (3, 5, 9) rotated angle t anti-clockwise about the
        origin in the x-y plane will give
        (3cos(t) - 5sin(t), 3sin(t) + 5cos(t), 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # If the angle is in degrees, convert it to radians
    angle = math.radians(angle) if in_degrees else angle

    # Initialise the rotation matrix
    rotation_matrix: list[list[int | Decimal]]

    # If the angle is anti-clockwise
    if anti_clockwise:

        # The matrix to perform the anti-clockwise rotation
        rotation_matrix = [
            [math_cos(angle), -math_sin(angle), 0],
            [math_sin(angle), math_cos(angle), 0],
            [0, 0, 1],
        ]

    # Otherwise
    else:

        # The matrix to perform the clockwise rotation
        rotation_matrix = [
            [math_cos(angle), math_sin(angle), 0],
            [-math_sin(angle), math_cos(angle), 0],
            [0, 0, 1],
        ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return rotation_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(rotation_matrix, vec_3d)


def vec_3d_rotate_90_degrees(
    anti_clockwise: bool = True,
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to rotate a vector anti-clockwise about the
    origin in the x-y plane by 90 degrees.

    For example:
        (3, 5, 9) rotated 90 degrees anti-clockwise about the
        origin in the x-y plane will give
        (-5, 3, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # Initialise the rotation matrix as the correct type
    rotation_matrix: list[list[int | Decimal]]

    # If the angle is anti-clockwise
    if anti_clockwise:

        # The matrix to perform the anti-clockwise rotation
        rotation_matrix = [
            [0, -1, 0],
            [1, 0, 0],
            [0, 0, 1],
        ]

    # Otherwise
    else:

        # The matrix to perform the clockwise rotation
        rotation_matrix = [
            [0, 1, 0],
            [-1, 0, 0],
            [0, 0, 1],
        ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return rotation_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(rotation_matrix, vec_3d)


def vec_3d_scale(
    scaling_factor_x: float | int | Decimal = 1,
    scaling_factor_y: float | int | Decimal = 1,
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to scale a vector by the given scaling factor.

    For example:
        (3, 5, 9) scaled by s in the x-direction and t in the y-direction
        will give (3s, 5t, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the scaling
    scaling_matrix: list[list[int | Decimal]] = [
        [Decimal(scaling_factor_x), 0, 0],
        [0, Decimal(scaling_factor_y), 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return scaling_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(scaling_matrix, vec_3d)


def vec_3d_shear(
    shearing_factor_x: float | int | Decimal = 0,
    shearing_factor_y: float | int | Decimal = 0,
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to shear a vector by the given shearing factors.

    For example:
        (3, 5, 9) sheared by s in the x-direction
        and sheared by t in the y-direction will give
        (3 + 5s, 5 + 3t, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the shearing
    shearing_matrix: list[list[int | Decimal]] = [
        [1, Decimal(shearing_factor_x), 0],
        [Decimal(shearing_factor_y), 1, 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return shearing_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(shearing_matrix, vec_3d)


def vec_3d_reflect_about_x(
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to reflect a vector about the x-axis

    For example:
        (3, 5, 9) reflected about the x-axis will give
        (3, -5, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the reflection
    reflection_matrix: list[list[int | Decimal]] = [
        [1, 0, 0],
        [0, -1, 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return reflection_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(reflection_matrix, vec_3d)


def vec_3d_reflect_about_y(
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to reflect a vector about the y-axis

    For example:
        (3, 5, 9) reflected about the y-axis will give
        (-3, 5, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the reflection
    reflection_matrix: list[list[int | Decimal]] = [
        [-1, 0, 0],
        [0, 1, 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return reflection_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(reflection_matrix, vec_3d)


def vec_3d_reflect_about_line_y_equal_x(
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to reflect a vector about the line y = x

    For example:
        (3, 5, 9) reflected about the line y = x will give
        (5, 3, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the reflection
    reflection_matrix: list[list[int | Decimal]] = [
        [0, 1, 0],
        [1, 0, 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return reflection_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(reflection_matrix, vec_3d)


def vec_3d_reflect_about_line_y_equal_minus_x(
    perform_multiplication: bool = False,
    vec_3d: list[list[int | Decimal]] | None = None,
) -> list[list[int | Decimal]]:
    """
    The function to reflect a vector about the line y = -x

    For example:
        (3, 5, 9) reflected about the line y = -x will give
        (-5, -3, 9)

    By default, this function will just return the matrix that
    will translate the given vector by the desired amount.
    Only if multiplication is desired will the multiplication be done.
    """

    # The matrix to perform the reflection
    reflection_matrix: list[list[int | Decimal]] = [
        [0, -1, 0],
        [-1, 0, 0],
        [0, 0, 1],
    ]

    # If multiplication is not wanted, or the vector given is None
    if not perform_multiplication or vec_3d is None:
        return reflection_matrix

    # If the vector given isn't a 3D vector, raise an error
    if (shape := matrix_shape(vec_3d)) != (3, 1):
        raise ValueError(
            "Vector given is not a 3D vector, "
            f"it is a {shape[0]} x {shape[1]} matrix."
        )

    # Otherwise, perform the matrix multiplication and return the result
    return multiply_matrices(reflection_matrix, vec_3d)


def apply_transformations_to_vertices(
    list_of_transformations: list[list[list[int | Decimal]]],
    data: list[list[dict]] | list[dict] | dict,
) -> Any:
    """
    Function to apply the various transformations to all the vertices given.

    The list of transformations should have the first transformation
    to be applied in the first position of the list, and the second
    transformation to be applied in the second position of the list,
    and so on.


    The data dictionary should contain vertices in 2D, not 3D.
    """

    # If the data given is a list or a tuple
    if isinstance(data, (list, tuple)):

        # Call the function on all the items in the list and return the result
        return [
            apply_transformations_to_vertices(list_of_transformations, item)
            for item in data
        ]

    # Otherwise, if the data given not a dictionary,
    # raise an error
    elif not isinstance(data, dict):
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

    # Otherwise, return the data dictionary with the transformation applied
    # to the vertices.
    # The vertices are converted from 2D to 3D to be matrix multiplied,
    # then are converted back from 3D to 2D to make the dictionary drawable.
    # The list of transformations is in the order of the transformations
    # to be applied, so the list needs to be reversed as the transformation
    # matrices are applied right to left, with the matrix representing the
    # first transformation being on the right, beside the vertex matrix, and
    # the matrix second representing the second transformation being on the
    # right, beside the matrix for the first transformation, and so on.
    return {
        **data,
        "vertices": [
            convert_3d_to_2d(
                multiply_matrices(
                    *list_of_transformations[::-1], convert_2d_to_3d(vertex)
                )
            )
            for vertex in vertices
        ],
    }


def get_tangent_vector(
    vector: list[list[int | Decimal]],
) -> list[list[int | Decimal]]:
    "Function to get the tangent vector of the given vector"

    # Convert the given vector to 3D
    converted_vector = convert_2d_to_3d(vector)

    # Rotate the vector by 90 degrees anti-clockwise
    rotated_vector = vec_3d_rotate_90_degrees(True, True, converted_vector)

    # Convert the rotated vector back to 2D
    tangent_vector = convert_3d_to_2d(rotated_vector)

    # Return the tangent vector
    return tangent_vector


def approximate_arc_less_than_90_degrees_as_bezier(
    centre_of_circle: list[list[int | Decimal]],
    angle: Decimal,
    start_angle: Decimal,
    radius: Decimal,
) -> list[list[list[int | Decimal]]]:
    """
    Function to approximate a circular arc of less than 90 degrees as a bezier.

    This function shouldn't be used directly, but called from the
    approximate_arc_as_bezier function.

    The angle and the start angle are in radians,
    and are measured anti-clockwise from the x-axis,
    so the x-axis has an angle of 0 radians.
    This is like the standard mathematical definition for the angle in a
    circular arc.

    The approximate_arc_as_bezier function should have converted
    both the angle and the start angle to radians.
    """

    # Get the first point of the bezier
    point_1 = add_matrices(
        centre_of_circle,
        scalar_product_matrix(
            radius, vec_2d(math_cos(start_angle), math_sin(start_angle))
        ),
    )

    # Get the last point of the bezier
    point_4 = add_matrices(
        centre_of_circle,
        scalar_product_matrix(
            radius,
            vec_2d(
                math_cos(start_angle + angle), math_sin(start_angle + angle)
            ),
        ),
    )

    # The constant to multiply with the vector
    k = (Decimal(4) / 3) * (math_tan(angle / 4))

    # Calculate point 2
    point_2 = add_matrices(
        point_1,
        scalar_product_matrix(
            k, get_tangent_vector(subtract_matrix(point_1, centre_of_circle))
        ),
    )

    # Calculate point 3
    point_3 = subtract_matrix(
        point_4,
        scalar_product_matrix(
            k, get_tangent_vector(subtract_matrix(point_4, centre_of_circle))
        ),
    )

    # Return the list of points
    return [point_1, point_2, point_3, point_4]


def add_start_and_end_fill_properties(
    list_of_beziers: list[dict], properties: Any
) -> list[dict]:
    """
    Function to add the start and end fill properties
    to the list of beziers based on whether the properties
    given include the property called "fill_colour".

    This function MODIFIES the list of beziers,
    but also returns the list of beziers.
    """

    # If the properties passed contain the fill colour
    if properties.get("fill_colour") is not None:

        # Add the start fill property to the first bezier in the list
        list_of_beziers[0]["start_fill"] = True

        # Add the end fill property to the last bezier in the list
        list_of_beziers[-1]["end_fill"] = True

    # Return the list of beziers
    return list_of_beziers


def approximate_arc_as_bezier(
    centre_of_circle: list[list[int | Decimal]],
    angle: float | int | Decimal,
    start_point: list[list[int | Decimal]] | None = None,
    start_angle: float | int | Decimal | None = None,
    radius: float | int | Decimal | None = None,
    angle_is_in_degrees: bool = False,
    **properties: Any,
) -> list[dict]:
    """
    Function to approximate a circular arc as a bezier.

    The angle is the angle it the circle can either by in degrees or radians,
    but it is by default in radians.

    The start point is optional only if the start angle and the radius is given.

    The angle and the start angle are measured anti-clockwise from the x-axis,
    so the x-axis has an angle of 0 radians.
    This is like the standard mathematical definition for the angle in a
    circular arc.

    If both the start angle and the radius are not given,
    a value error is raised.
    """

    # If the start angle and the radius are both not given,
    # when the start point isn't given, raise an error
    if start_point is None and (start_angle is None or radius is None):
        raise ValueError(
            "Insufficient information given. "
            "The function requires both a start angle "
            "and a radius to draw an arc"
        )

    # If the angle is in degrees, convert it to radians
    if angle_is_in_degrees:
        angle = math.radians(angle)

    # Change the angle to be within 0 to 2 pi
    angle = Decimal(angle) % (2 * math_pi)

    # If the angle is 0, then change it to 2 pi
    if round(angle) == 0:
        angle = 2 * math_pi

    # If the start point is given
    if start_point is not None:

        # Calculate the vector from the start point to the centre of the circle
        radius_vector = subtract_matrix(start_point, centre_of_circle)

        # Calculate the radius of the circle
        radius = vec_norm(radius_vector)

        # Calculate the start angle
        start_angle = Decimal(math.acos(radius_vector[0][0] / radius))

    # Otherwise, if the start angle isn't None
    elif start_angle is not None:

        # Convert the start angle to radians if it is in degrees
        if angle_is_in_degrees:
            start_angle = math.radians(start_angle)

    # If the radius or the start angle is None somehow, then raise an error.
    # This shouldn't ever happen
    if radius is None or start_angle is None:
        raise ValueError(
            "The radius or the start angle is somehow None, "
            "there is something very wrong here."
        )

    # Convert the start angle and the radius to a decimal
    start_angle = Decimal(start_angle)
    radius = Decimal(radius)

    # Divide the angle by pi / 2 (90 degrees)
    # as only one quarter circle is approximated correctly by a bezier
    number_of_quarter_circles, remainder = divmod(angle, math_pi / 2)

    # The list to store the beziers
    list_of_beziers: list[dict] = []

    # Iterate over the number of quarter circles
    for num in range(int(number_of_quarter_circles)):

        # Create the list of vertices for the quarter circle
        vertices = approximate_arc_less_than_90_degrees_as_bezier(
            centre_of_circle,
            math_pi / 2,
            start_angle + (num * (math_pi / 2)),
            radius,
        )

        # Create a dictionary with the vertices and the properties given
        bezier_dict = {"vertices": vertices, **properties}

        # Add the dictionary to the list of points
        list_of_beziers.append(bezier_dict)

    # If the remainder is 0, then return the list of beziers immediately
    if round(remainder) == 0:
        return add_start_and_end_fill_properties(list_of_beziers, properties)

    # Create the vertices for the last portion of the arc
    vertices = approximate_arc_less_than_90_degrees_as_bezier(
        centre_of_circle,
        remainder,
        start_angle + number_of_quarter_circles * (math_pi / 2),
        radius,
    )

    # Create the dictionary for the last portion of the arc
    last_bezier_dict = {"vertices": vertices, **properties}

    # Add the bezier dictionary to the list of beziers
    list_of_beziers.append(last_bezier_dict)

    # Return the list of beziers
    # with the start and end fill properties added
    return add_start_and_end_fill_properties(list_of_beziers, properties)
