import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np


def change_brightness(image, value):
    # Adjust the brightness of an image.
    output = image.copy().astype(np.int32)
    output += value  # change rgb value by "value"
    output = np.clip(output, 0, 255)  # ensure rgb value is within range

    return output.astype(np.uint8)


def change_contrast(image, value):
    # Adjust the contrast of an image.
    F = 259 * (value + 255) / (255 * (259 - value))  # formula for contrast
    img = image.copy()
    img = img.astype(np.int32)
    img = F * (img - 128) + 128  # change rgb value for contrast
    img = np.clip(img, 0, 255)  # ensure rgb value is within range
    return img.astype(np.uint8)


def grayscale(image):
    # Convert an image to grayscale
    img = image.copy()
    gray_values = (
        0.3 * img[:, :, 0] + 0.59 * img[:, :, 1] + 0.11 * img[:, :, 2]
    )  # formula for grayscale
    img[:, :, 0] = img[:, :, 1] = img[:, :, 2] = gray_values
    return img.astype(np.uint8)


def blur_effect(image):
    k_blur = np.array(
        [
            [0.0625, 0.125, 0.0625],  # 3x3 blur matrix
            [0.125, 0.25, 0.125],
            [0.0625, 0.125, 0.0625],
        ]
    )

    rows, columns, colours = image.shape  # counts rows, columns n colors
    output = image.copy()

    # 3x3 from the picture
    for r in range(1, rows - 1):
        for c in range(1, columns - 1):
            for x in range(colours):
                region = image[r - 1 : r + 2, c - 1 : c + 2, x]

                # give output of matrix multiplication
                output[r, c, x] = np.sum(region * k_blur)

    return output.astype(np.uint8)


def edge_detection(image):
    k_edge = np.array(
        [[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]]  # edge detection matrix
    )

    rows, columns, colours = image.shape  # counts rows, columns n colors
    output = image.copy()

    # 3x3 from the picture
    for r in range(1, rows - 1):
        for c in range(1, columns - 1):
            for x in range(colours):
                region = image[r - 1 : r + 2, c - 1 : c + 2, x]

                # give output of matrix multiplication
                output[r, c, x] = np.sum(region * k_edge)

        # add 128 + ensure values correct
    output[1 : rows - 1, 1 : columns - 1] = np.clip(
        output[1 : rows - 1, 1 : columns - 1] + 128, 0, 255
    )

    return output.astype(np.uint8)


def embossed(image):
    k_embos = np.array([[-1, -1, 0], [-1, 0, 1], [0, 1, 1]])  # emboss matrix

    rows, columns, colours = image.shape  # counts rows, columns n colors
    output = image.copy()

    # 3x3 from the picture
    for r in range(1, rows - 1):
        for c in range(1, columns - 1):
            for x in range(colours):
                region = image[r - 1 : r + 2, c - 1 : c + 2, x]

                # give output of matrix multiplication
                output[r, c, x] = np.sum(region * k_embos)

    # add 128 + ensure values correct
    output[1 : rows - 1, 1 : columns - 1] = np.clip(
        output[1 : rows - 1, 1 : columns - 1] + 128, 0, 255
    )

    return output.astype(np.uint8)


def rectangle_select(img, top_left, bottom_right):
    # generate mask of 0s
    mask = np.zeros((img.shape[0], img.shape[1]))
    mask[
        top_left[0] : bottom_right[0] + 1, top_left[1] : bottom_right[1] + 1
    ] = 1.0
    return mask


def magic_wand_select(image, start, threshold):
    def color_distance(pixel1, pixel2):
        r_mean = (pixel1[0] + pixel2[0]) / 2
        delta_r = pixel1[0] - pixel2[0]
        delta_g = pixel1[1] - pixel2[1]
        delta_b = pixel1[2] - pixel2[2]
        return np.sqrt(
            (2 + r_mean / 256) * delta_r**2
            + 4 * delta_g**2
            + (2 + (255 - r_mean) / 256) * delta_b**2
        )

    x, y = start
    mask = np.zeros((image.shape[0], image.shape[1]))
    stack = [(x, y)]
    original_color = image[y, x]

    while stack:
        cx, cy = stack.pop()
        if (
            mask[cy, cx] == 0
            and color_distance(image[cy, cx], original_color) <= threshold
        ):
            mask[cy, cx] = 1
            for nx, ny in [
                (cx - 1, cy),
                (cx + 1, cy),
                (cx, cy - 1),
                (cx, cy + 1),
            ]:
                if 0 <= nx < image.shape[1] and 0 <= ny < image.shape[0]:
                    stack.append((nx, ny))

    return mask


def compute_edge(mask):
    rsize, csize = len(mask), len(mask[0])
    edge = np.zeros((rsize, csize))
    if np.all((mask == 1)):
        return edge
    for r in range(rsize):
        for c in range(csize):
            if mask[r][c] != 0:
                if (
                    r == 0
                    or c == 0
                    or r == len(mask) - 1
                    or c == len(mask[0]) - 1
                ):
                    edge[r][c] = 1
                    continue

                is_edge = False
                for var in [(-1, 0), (0, -1), (0, 1), (1, 0)]:
                    r_temp = r + var[0]
                    c_temp = c + var[1]
                    if 0 <= r_temp < rsize and 0 <= c_temp < csize:
                        if mask[r_temp][c_temp] == 0:
                            is_edge = True
                            break

                if is_edge:
                    edge[r][c] = 1

    return edge


def save_image(
    filename, image
):  # saves the image as the filename.jpg (Ensures that its a jpg file)
    img = image.astype(np.uint8)
    mpimg.imsave(filename + ".jpg", img)


def load_image(
    filename,
):  # loads the image wanted by the user (has to be png/jpg file)
    img = mpimg.imread(filename)
    if len(img[0][0]) == 4:  # if png file with an alpha channel
        img = np.delete(img, 3, 2)  # remove the alpha channel (transparency)
    if (
        type(img[0][0][0]) == np.float32
    ):  # if stored as float in [0,..,1] instead of integers in [0,..,255]
        img = img * 255
        img = img.astype(np.uint8)
    mask = np.ones(
        (len(img), len(img[0]))
    )  # create a mask full of "1" of the same size as the loaded image
    img = img.astype(np.int32)
    return img, mask


def display_image(image, mask):
    # if using Spyder, please go to "Tools -> Preferences -> IPython console -> Graphics -> Graphics Backend" and select "inline"
    tmp_img = image.copy()
    edge = compute_edge(
        mask
    )  # Finds the edge of the picture and highlights it red
    for r in range(len(image)):
        for c in range(len(image[0])):
            if edge[r][c] == 1:
                tmp_img[r][c][0] = 255
                tmp_img[r][c][1] = 0
                tmp_img[r][c][2] = 0

    plt.imshow(tmp_img)
    plt.axis("off")
    plt.show()
    print("Image size is", str(len(image)), "x", str(len(image[0])))


def menu():

    img = mask = np.array([])

    img_present = np.any(img)  # is there any image?

    while not img_present:
        menu = [
            "What do you want to do?",
            "e - exit the program",
            "l - load a picture",
        ]
        print("\n".join(menu))
        choice = input("Your choice: ")

        if choice == "e":
            break
        elif choice == "l":
            while True:
                filename = input("Filename: ")
                try:
                    img, mask = load_image(
                        filename
                    )  # load mask and img with the pic
                    break
                except Exception:
                    print("The file name you have given doesn't exist.")
            img_present = True  # the image is now in
            display_image(img, mask)
        else:
            print("Invalid option!")

    while img_present:
        menu = [
            "What do you want to do?",
            "e - exit the program",
            "l - load a picture",
            "s - save the current picture",
            "1 - adjust brightness",
            "2 - adjust contrast",
            "3 - apply grayscale",
            "4 - apply blur",
            "5 - edge detection",
            "6 - embossed",
            "7 - rectangle select",
            "8 - magic wand select",
        ]
        print("\n".join(menu))
        choice = input("Your choice: ")

        if choice == "e":
            break
        elif choice == "l":
            while True:
                filename = input("Filename: ")
                try:
                    img, mask = load_image(filename)
                    break
                except Exception:
                    print("The file name you have given doesn't exist.")

            img_present = True  # the image is now in

        elif choice == "s":
            while True:
                file_name = input("Save as: ")
                try:
                    img = save_image(file_name, img)
                    break
                except Exception:
                    print("The file name you have given can't be saved to.")
            break
        elif choice == "1":
            user_input_is_valid = False
            while not user_input_is_valid:
                try:
                    cb_value = int(input("Increase brightness by: "))
                    if -255 <= cb_value <= 255:
                        user_input_is_valid = True
                    else:
                        print("The value you gave is not between -255 and 255.")
                except Exception:
                    print("The value you have given is not an integer.")
            temp_img = change_brightness(img, cb_value)
            img[mask == 1] = temp_img[
                mask == 1
            ]  # merge edited mask + unedited img

        elif choice == "2":
            user_input_is_valid = False
            while not user_input_is_valid:
                try:
                    cc_value = int(input("Change contrast by: "))
                    if -255 <= cc_value <= 255:
                        user_input_is_valid = True
                    else:
                        print("The value you gave is not between -255 and 255.")
                except Exception:
                    print("The value you have given is not an integer.")
            temp_img = change_contrast(img, cc_value)
            img[mask == 1] = temp_img[
                mask == 1
            ]  # merge edited mask + unedited img

        elif choice == "3":
            print("Applying grayscale...")
            temp_img = grayscale(img)
            img[mask == 1] = temp_img[
                mask == 1
            ]  # merge edited mask + unedited img

        elif choice == "4":
            print("Bluring Image...")
            img = blur_effect(img)

        elif choice == "5":
            print("Detecting Edges...")
            img = edge_detection(img)

        elif choice == "6":
            print("Embossing Image")
            img = embossed(img)

        elif choice == "7":
            if img.size == 0:
                print("No image loaded.")
            else:
                img_height, img_width, _ = img.shape
                user_input_is_valid = False
                while not user_input_is_valid:
                    try:
                        x1, y1 = map(
                            int,
                            input(
                                "Enter first pixel position (x1 y1): "
                            ).split(),
                        )
                        if 0 <= x1 < img_width and 0 <= y1 < img_height:
                            user_input_is_valid = True
                        else:
                            print(
                                "The pixel position you gave isn't inside the image."
                            )

                        x2, y2 = map(
                            int,
                            input(
                                "Enter first pixel position (x2 y2): "
                            ).split(),
                        )
                        if 0 <= x2 < img_width and 0 <= y2 < img_height:
                            user_input_is_valid = True
                        else:
                            print(
                                "The pixel position you gave isn't inside the image."
                            )
                    except Exception:
                        print("The value you have given is not an integer.")
                mask = rectangle_select(img, (x1, y1), (x2, y2))

        elif choice == "8":
            if img.size == 0:
                print("No image loaded.")
            else:
                img_height, img_width, _ = img.shape
                user_input_is_valid = False
                while not user_input_is_valid:
                    try:
                        x, y = map(
                            int, input("Enter pixel position (x y): ").split()
                        )
                        threshold = int(input("Enter threshold value: "))
                        if 0 <= x < img_width and 0 <= y < img_height:
                            user_input_is_valid = True
                        else:
                            print(
                                "The pixel position you gave isn't inside the image."
                            )
                    except Exception:
                        print("The value you have given is not an integer.")
                mask = magic_wand_select(img, (x, y), threshold)
        else:
            print("Invalid choice.")

        if img.size != 0:
            display_image(img, mask)


if __name__ == "__main__":
    menu()
