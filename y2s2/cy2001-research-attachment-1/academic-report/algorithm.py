import pandas
import numpy
import scipy.signal as sps
from ahrs.filters.madgwick import Madgwick
from ahrs.common.dcm import DCM
from ahrs import Quaternion

# The sampling frequency of the sensor
SAMPLING_FREQUENCY: int = 100

# The Nyquist frequency,
# which is half of the sampling frequency
NYQUIST_FREQUENCY: float = 0.5 * SAMPLING_FREQUENCY

# The highest frequency we want,
# which is 3 Hz as humans don't move
# their legs that quickly
MAXIMUM_FREQUENCY: int = 3

# The minimum acceleration required
# for a step to be counted.
MINIMUM_Z_ACCELERATION: int = -11

# The maximum acceleration
# in ms^-2 to be considered a step.
# Anything higher than this value is most likely
# due to shaking.
MAXIMUM_ACCELERATION: int = 100

# The window size, which is 10 seconds of data
WINDOW_SIZE: int = SAMPLING_FREQUENCY * 10

# The threshold for the angle difference in radians
# between two orientations to be considered similar
ANGLE_DIFFERENCE_THRESHOLD: float = numpy.deg2rad(45)

# Number of different orientations allowed for a window
# to have the steps in the entire window be counted as steps
MAX_NUMBER_OF_DIFFERENT_ORIENTATIONS: int = 2

def convert_accelerometer_data_to_standard_form(
    acceleration_data: pandas.DataFrame,
    columns: list[str],
) -> pandas.DataFrame:
    """
    Function to vectorise the data and
    convert g to metres per second squared.

    The `columns` argument is the list of column names for
    the acceleration data, and it should have
    a length of 3.
    """
    return acceleration_data.apply(
        lambda x: numpy.array([
            9.81 * x[column] for column in columns
        ]),
        axis=1,
    )

def convert_gyroscope_data_to_standard_form(
    gyroscope_data: pandas.DataFrame,
    columns: list[str],
) -> pandas.DataFrame:
    """
    Function to vectorise the data and
    convert degrees to radians.

    The `columns` argument is the list of column names for
    the acceleration data, and it should have
    a length of 3.
    """
    return gyroscope_data.apply(
        lambda x: numpy.deg2rad([
            x[column] for column in columns
        ]),
        axis=1,
    )

def convert_magnetometer_data_to_standard_form(
    magnetometer_data: pandas.DataFrame,
    columns: list[str],
) -> pandas.DataFrame:
    """
    Function to vectorise the data and
    convert microtelsa into millitesla.

    The `columns` argument is the list of column names for
    the acceleration data, and it should have
    a length of 3.
    """
    return magnetometer_data.apply(
        lambda x: ([
            x[column] / (10 ** 3) for column in columns
        ]),
        axis=1,
    )

def apply_frequency_filter(accelerometer_data: numpy.ndarray) -> numpy.ndarray:
    """
    Function to apply the 4th-order Butterworth low-pass filter
    on the acceleration data.
    """

    # Get the filter numerator and filter denominator
    filter_numerator, filter_denominator = sps.butter(
        4,
        MAXIMUM_FREQUENCY / NYQUIST_FREQUENCY,
        btype='lowpass'
    )

    # Filter the accelerometer data
    filtered_accelerometer_data = sps.filtfilt(
        filter_numerator,
        filter_denominator,
        accelerometer_data
    )

    # Return the filtered data
    return filtered_accelerometer_data

def apply_orientation_filter(
    orientation_filter,
    accelerometer_data: numpy.ndarray,
    gyroscope_data: numpy.ndarray,
    magnetometer_data: numpy.ndarray | None = None,
    sampling_frequency: int = SAMPLING_FREQUENCY,
) -> numpy.ndarray:
    """
    This function takes an AHRS orientation filter and applies it to the data.

    The magnetometer data is optional, but the accelerometer data and
    gyroscope data are required and should be in ms^2 and rads^{-2}, respectively.
    """

    # Get the result of calling the filter function
    result = orientation_filter(
        acc=accelerometer_data,
        gyr=gyroscope_data,
        mag=magnetometer_data,
        frequency=sampling_frequency,
    )

    # Return the quaternions
    return result.Q

def get_rotation_matrices_from_quaternions(
    quaternions: numpy.ndarray,
) -> numpy.ndarray:
    "Returns the direction cosine matrices from quaternions."
    return DCM().from_quaternion(quaternions)

def get_rotated_accelerometer_data(
    accelerometer_data: numpy.ndarray,
    rotation_matrices: numpy.ndarray,
) -> numpy.ndarray:
    "Function to rotate the accelerometer axis to the global reference frame."

    # Initialise the list of the rotated accelerometer data
    rotated_accelerometer_data = []

    # Iterate over the accelerometer data
    for index, (x, y, z) in enumerate(accelerometer_data):

        # The rotation matrix from the quaternion is to rotate the cardinal
        # coordinates to the accelerometer coordinate system.
        rotation_matrix = -rotation_matrices[index]
        rotated_accelerometer_data.append([
            rotation_matrix @ [x, 0, 0],
            rotation_matrix @ [0, y, 0],
            rotation_matrix @ [0, 0, z],
        ])

    # Return the list of rotated accelerometer data
    return rotated_accelerometer_data

def get_projection(
    vector_to_project_on: numpy.ndarray[float],
    vectors: numpy.ndarray[numpy.ndarray[float]],
) -> numpy.ndarray[float]:
    "Function to get the projection of vectors on a given target vector."

    # The list of projected vectors
    projected_vectors = []

    # Iterate over the vectors and take the dot product to obtain the projection
    for (x, y, z) in vectors:
        x_projection = numpy.dot(x, vector_to_project_on)
        y_projection = numpy.dot(y, vector_to_project_on)
        z_projection = numpy.dot(z, vector_to_project_on)
        projected_vectors.append(x_projection + y_projection + z_projection)

    return numpy.array(projected_vectors)

def find_troughs(
    accelerometer_data: numpy.ndarray,
    sampling_frequency: int = SAMPLING_FREQUENCY,
    maximum_frequency: int = MAXIMUM_FREQUENCY,
) -> numpy.ndarray:
    "This function returns an array of the indices of found troughs."

    # Get the list of troughs
    troughs, _ = sps.find_peaks(
        -accelerometer_data,

        # Minimal distance between troughs is the minimum wavelength
        distance=int(sampling_frequency / maximum_frequency),

        # The height here is negative due to the accelerometer
        # data given being negative
        height=-MINIMUM_Z_ACCELERATION,
    )

    # Return the troughs in the data
    return troughs

def quaternion_to_euler(quaternion: numpy.ndarray) -> numpy.ndarray:
    "Function to get the Euler angles from a quaternion."

    w, x, y, z = quaternion

    # Euler angle phi
    phi = numpy.atan2(
        2 * (w * x + y * z),
        1 - 2 * (x ** 2 + y ** 2),
    )

    # Euler angle theta
    theta = numpy.asin(
        2 * (w * y - z * x)
    )

    # Euler angle psi
    psi = numpy.atan2(
        2 * (w * z + x * y),
        1 - 2 * (y ** 2 + z ** 2),
    )

    # Return the Euler angles
    return (phi, theta, psi)

def quaternion_orientations_are_similar(
    quaternion_1: numpy.ndarray,
    quaternion_2: numpy.ndarray,
    threshold_angle: float = ANGLE_DIFFERENCE_THRESHOLD,
) -> bool:
    """
    This function takes two numpy arrays representing quaternions
    in the form [w, x, y, z] and a threshold angle in radians.
    If the angle between the two quaternions is less
    than the threshold angle in all directions,
    then the function returns true, otherwise, it returns false.
    """

    q_1, q_2 = Quaternion(quaternion_1), Quaternion(quaternion_2)

    # Multiply the conjugate of the first quaternion
    # with the second to get the 3D difference in orientation
    w, x, y, z = Quaternion(q_1.conjugate) * q_2

    # Obtain the Euler angles from the orientation difference
    return numpy.all([
        angle < threshold_angle for angle in quaternion_to_euler([w, x, y, z])
    ])

def exceed_raw_peak_threshold(
    raw_accelerometer_data: numpy.ndarray,
    height: float = MAXIMUM_ACCELERATION,
) -> bool:
    "Function to check if there are any raw peaks above a given height."

    # Iterate over every axis in the accelerometer data
    for axis in raw_accelerometer_data:

        # Get the raw peaks
        raw_peaks, _ = sps.find_peaks(axis, height=height)

        # If the number of raw peaks is more than 0, then return true
        if len(raw_peaks) > 0:
            return True

    # Return false otherwise
    return False

def exceeded_number_of_different_orientations(
    troughs: numpy.ndarray,
    orientation_quaternions: numpy.ndarray,
    maximum_value: int = MAX_NUMBER_OF_DIFFERENT_ORIENTATIONS,
    angle_difference_threshold: float = ANGLE_DIFFERENCE_THRESHOLD,
) -> bool:
    """
    Function to check if the number of different orientations exceeds
    the threshold maximum value given in the function.

    The troughs should be a list of indices of the troughs in the data set,
    which are found using the Scipy `find_peaks` function.

    The orientation quaternions should be a numpy array of the form [w, x, y, z]
    representing the orientations for the entire data set.

    The angle difference is the maximum difference in Euler angles
    phi, theta, and psi, between two quaternions, for them to
    be considered similar.

    This angle difference should be in radians and not degrees,
    AHRS uses radians instead of degrees.
    """

    # If there are no troughs, return false.
    #
    # Technically, it should not matter if this function returns
    # true or false when there are no troughs in the first place,
    # as the algorithm will end up returning an empty array either way.
    if len(troughs) < 1:
        return False

    # Otherwise, get the first trough to set the initial orientation
    first_trough = troughs[0]

    # Initialise the list of different orientations.
    #
    # Each distinct orientation is represented by a list of orientations,
    # each one being a quaternion that is considered similar to the
    # mean of the quaternions that were in the list before it.
    #
    # The mean orientation in the orientation list is more robust and
    # representative of the orientation than just picking the first
    # orientation, or a random orientation from the orientation list.
    different_orientations = [[orientation_quaternions[first_trough]]]

    # Initialise the variable to indicate whether
    # the orientation has been added.
    has_been_added = False

    # Iterate over the troughs in the data
    for index, trough in enumerate(troughs[1:]):

        # Get the current orientation
        current_orientation = orientation_quaternions[trough]

        # Iterate over the list of different orientations
        for orientation_list in different_orientations:

            # Obtain the mean orientation for the list
            mean_orientation = numpy.mean(orientation_list, axis=0)

            # Add the current orientation to the list if it's similar to the mean
            if quaternion_orientations_are_similar(
                mean_orientation,
                current_orientation,
                angle_difference_threshold,
            ):
                has_been_added = True
                orientation_list.append(current_orientation)

        # When the orientation has not been added to the list,
        # it is a different orientation, so add it as a separate
        # entry in the list of different orientations
        if not has_been_added:
            different_orientations.append([current_orientation])

    # Get the number of different orientations
    number_of_different_orientations = len(different_orientations)

    # If the number of troughs is somehow less than or equal to
    # the number of different orientations, or if the number of
    # different orientations exceed the threshold value,
    # return true
    if (
        len(troughs) <= number_of_different_orientations or
        number_of_different_orientations > maximum_value
    ):
        return True

    # Otherwise, return false
    return False

def filter_troughs(
    accelerometer_data: numpy.ndarray,
    raw_accelerometer_data: numpy.ndarray,
    orientation_quaternions: numpy.ndarray,
    troughs: numpy.ndarray,
    max_acceleration: float = MAXIMUM_ACCELERATION,
    max_number_of_orientations: float = MAX_NUMBER_OF_DIFFERENT_ORIENTATIONS,
    angle_difference_threshold: float = ANGLE_DIFFERENCE_THRESHOLD,
) -> list[int]:
    """
    Function to filter the troughs in the data to only
    count those that are possible steps.

    The accelerometer data and the raw accelerometer data
    passed to the function should be a list of 3 lists,
    the first containing the x acceleration, the second
    containing the y acceleration and the last containing
    the z acceleration.

    The list of quaternions should be a numpy array in the form [w, x, y, z].

    The list of troughs contains the indices for the troughs' position in the data.
    """

    # Call the function to get whether any raw peaks have
    # exceeded the threshold and return an empty list if exceeded
    if exceed_raw_peak_threshold(raw_accelerometer_data, max_acceleration):
        return []

    # Call the function to get whether the number of different orientations
    # have exceeded the threshold and return an empty list if exceeded
    if exceeded_number_of_different_orientations(
        troughs,
        orientation_quaternions,
        max_number_of_orientations,
        angle_difference_threshold,
    ):
        return []

    # Otherwise, return the list of troughs
    return troughs

def get_step_count(
    accelerometer_data: numpy.ndarray,
    raw_accelerometer_data: numpy.ndarray,
    orientation_quaternions: numpy.ndarray,
    window_size: int = WINDOW_SIZE,
    sampling_frequency: int = SAMPLING_FREQUENCY,
    maximum_frequency: int = MAXIMUM_FREQUENCY,
    max_acceleration: float = MAXIMUM_ACCELERATION,
    max_number_of_orientations: float = MAX_NUMBER_OF_DIFFERENT_ORIENTATIONS,
    angle_difference_threshold: float = ANGLE_DIFFERENCE_THRESHOLD,
) -> tuple[int, list[int]]:
    """
    The function to get a step count.

    The accelerometer data and the raw accelerometer data
    passed to the function should be a list of 3 lists,
    the first containing the x acceleration, the second
    containing the y acceleration and the last containing
    the z acceleration.

    The orientation quaternions should be a list of quaternions
    with each quaternion being a numpy array of the form [w, x, y, z].
    """

    # Initialise the start index and end index
    start_index = 0
    end_index = start_index + window_size

    # Get the acceleration data in the z direction
    _, _, z_acceleration = accelerometer_data

    # Get the length of the acceleration data
    accelerometer_data_len = len(z_acceleration)

    # Initialise the step count
    step_count = 0

    # Initialise the list of troughs
    list_of_troughs = []

    # While the start index is not past the end of the accelerometer data
    while start_index < accelerometer_data_len:

        # Find the troughs in the z acceleration
        z_troughs = find_troughs(
            z_acceleration[start_index:end_index],
            sampling_frequency,
            maximum_frequency
        )

        # Filter the troughs
        filtered_troughs = numpy.array(filter_troughs(
            [axis[start_index:end_index] for axis in accelerometer_data],
            [axis[start_index:end_index] for axis in raw_accelerometer_data],
            orientation_quaternions[start_index:end_index],
            z_troughs,
            max_acceleration,
            max_number_of_orientations,
            angle_difference_threshold,
        )) + start_index

        # Add the filtered troughs to the list
        list_of_troughs.extend(filtered_troughs)

        # Increase the step count by the number of filtered troughs
        step_count += len(filtered_troughs)

        # Set the start index and end index to continue the loop
        start_index = end_index

        # Set the end index to the start index + the window size
        end_index = start_index + window_size

    # Return the step count and the list of troughs for plotting
    return step_count, list_of_troughs

def get_step_count_from_witmotion_sensor_data(
    sensor_data_filename: str,
    window_size: int = WINDOW_SIZE,
    sampling_frequency: int = SAMPLING_FREQUENCY,
    maximum_frequency: int = MAXIMUM_FREQUENCY,
    max_acceleration: float = MAXIMUM_ACCELERATION,
    max_number_of_orientations: float = MAX_NUMBER_OF_DIFFERENT_ORIENTATIONS,
    angle_difference_threshold: float = ANGLE_DIFFERENCE_THRESHOLD,
) -> tuple[int, list[int], numpy.ndarray, numpy.ndarray]:
    """
    Function to get the step count from the WitMotion sensor data.

    It handles all of the processing to generate the step count
    and does not need anything other than the file name of the
    sensor data file.
    """

    # Read the file
    raw_sensor_data = pandas.read_csv(sensor_data_filename, sep="\t")

    # Get the raw accelerometer data in the required form
    raw_accelerometer_data = convert_accelerometer_data_to_standard_form(
        raw_sensor_data,
        ["AccX(g)", "AccY(g)", "AccZ(g)"],
    )

    # Get the raw gyroscope data in the required form
    raw_gyroscope_data = convert_gyroscope_data_to_standard_form(
        raw_sensor_data,
        ["AsX(°/s)", "AsY(°/s)", "AsZ(°/s)"],
    )

    # Get the raw magnetometer data in the required form
    raw_magnetometer_data = convert_magnetometer_data_to_standard_form(
        raw_sensor_data,
        ["HX(uT)", "HY(uT)", "HZ(uT)"],
    )

    # Filter the accelerometer data using a low-pass filter
    accelerometer_data = apply_frequency_filter(raw_accelerometer_data)

    # Get the orientation quaternions for the filtered accelerometer data
    orientation_quaternions = apply_orientation_filter(
        Madgwick,
        accelerometer_data,
        raw_gyroscope_data,
        raw_magnetometer_data,
    )

    # Get the orientation quaternions for the raw accelerometer data
    raw_orientation_quaternions = apply_orientation_filter(
        Madgwick,
        raw_accelerometer_data,
        raw_gyroscope_data,
        raw_magnetometer_data,
    )

    # Get the rotation matrices
    rotation_matrices = get_rotation_matrices_from_quaternions(
        orientation_quaternions
    )
    raw_rotation_matrices = get_rotation_matrices_from_quaternions(
        raw_orientation_quaternions
    )

    # Rotate the accelerometer data, both filtered and raw,
    # to the global reference frame
    rotated_accelerometer_data = get_rotated_accelerometer_data(
        accelerometer_data,
        rotation_matrices,
    )
    raw_rotated_accelerometer_data = get_rotated_accelerometer_data(
        raw_accelerometer_data,
        raw_rotation_matrices,
    )

    # Get the projection of the rotated accelerometer data,
    # both filtered and raw, on the cardinal direction vectors.
    accelerometer_projection = [
        get_projection(cardinal_vector, rotated_accelerometer_data)
        for cardinal_vector in [(1, 0, 0), (0, 1, 0), (0, 0, 1)]
    ]
    raw_accelerometer_projection = [
        get_projection(cardinal_vector, raw_rotated_accelerometer_data)
        for cardinal_vector in [(1, 0, 0), (0, 1, 0), (0, 0, 1)]
    ]

    # Call the function to get the step count
    step_count, troughs = get_step_count(
        accelerometer_projection,
        raw_accelerometer_projection,
        orientation_quaternions,
        window_size,
        sampling_frequency,
        maximum_frequency,
        max_acceleration,
        max_number_of_orientations,
        angle_difference_threshold,
    )

    # Return the step count, along with a bunch of supplementary data
    return (
        step_count,
        troughs,
        accelerometer_projection,
        raw_accelerometer_projection,
    )
