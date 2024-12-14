# The main module to run the program

import utils
from ui.main_menu import display_main_menu
from ui.title_screen import display_title_screen


def main() -> None:
    "The main function to run the entire program"

    # Initialise the state of the program
    state = utils.init_state()

    # Initialise the turtle window
    screen = utils.init_turtle()

    # Push the function for the main menu to the function stack
    utils.push_to_function_stack(
        state,
        utils.call_without_args(
            display_main_menu,
            screen,
            state,
            display_welcome_message=True,
            draw_instantly=False,
            preview=True,
        ),
    )

    # Display the title screen
    display_title_screen(state, screen)

    # Runs the main loop
    screen.mainloop()


# Name safeguard
if __name__ == "__main__":
    main()
