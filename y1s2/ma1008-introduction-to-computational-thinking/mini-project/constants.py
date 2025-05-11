# The constants to be used in the UI library

# The font family used for the UI
FONT_FAMILY = "Helvetica"

# The font used for most of the UI
# The first item is the font family
# The second item is the font size
# The third item is the font style, like italic, bold or normal
FONT: tuple[str, int, str] = (FONT_FAMILY, 16, "normal")

# The font spacing between lines
FONT_SPACING = 5

# The continue label
CONTINUE_LABEL = "Press any key to continue..."

# The font for the continue label
CONTINUE_LABEL_FONT = (FONT_FAMILY, 10, "normal")

# The default window buffer in pixels
WINDOW_BUFFER_IN_PIXELS = 10

# The default canvas buffer in pixels
CANVAS_BUFFER_IN_PIXELS = 0

# The default buffer from the bottom of the screen
BOTTOM_LEFT_BUFFER_IN_PIXELS = 15

# The name of the program
APP_NAME = "Logographer"
