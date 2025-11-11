		GET		lib_gpio.s

; The two on board buttons, the code below uses switch 1
ON_BOARD_SWITCH_1	EQU 0x40025040	; PF4
ON_BOARD_SWITCH_2	EQU 0x40025004	; PF0

		AREA	|.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	Start

Start

		; Set up the on board LED
		BL setup_on_board_led

		; Load the bit for the button
		MOV R4, #0x10

		; Get the address of port F
		LDR R3, =GPIO_PORT_F_BASE

		; Get the GPIO register
		LDR R2, =GPIO_PCTL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the button as GPIO
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the direction register
		LDR R2, =GPIO_DIR_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the button as input
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the alternate function register
		LDR R2, =GPIO_AFSEL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Disable the alternate function
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the pull-up resistor register
		LDR R2, =GPIO_PUR_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Enable the pull up resistor for the button
		ORR R0, R0, R4
		STR R0, [R1]

		; Get the digital enable register
		LDR R2, =GPIO_DEN_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Enable the digital port
		ORR R0, R0, R4
		STR R0, [R1]

		; Load the address for the switch
		LDR R5, =ON_BOARD_SWITCH_1

; Main loop, the buttons only work on release, instead of on press
loop

		; Set the LED to white and turn it on
		LDR R8, =LED_WHITE
		BL set_led

; LED is on, button is not pressed, wait for the press to move on
wait_for_press_to_turn_off

		; Get the value from the switch
		LDR R0, [R5]

		; Check if the button is pressed
		CMP R0, R4

		; If it is not pressed, continue waiting
		;
		; Button is high by default due to the pull up resistors
		; configured above, so if it reads a 1, it's not pressed.
		BEQ wait_for_press_to_turn_off

; LED is on, button is pressed, wait for the release to turn off LED
wait_for_release_to_turn_off

		; Get the value from the switch
		LDR R0, [R5]

		; Check if the button is released
		CMP R0, R4

		; If it is not released, continue waiting
		;
		; Button is high by default due to the pull up resistors
		; configured above, so if it is not 1, it is still being pressed.
		BNE wait_for_release_to_turn_off

		; Set the LED to off
		LDR R8, =LED_OFF
		BL set_led

; LED is off, button is not pressed, wait for the press to move on
wait_for_press_to_turn_on

		; Get the value from the switch
		LDR R0, [R5]

		; Check if the button is pressed
		CMP R0, R4

		; If it is not pressed, continue waiting
		;
		; Button is high by default due to the pull up resistors
		; configured above, so if it reads a 1, it's not pressed.
		BEQ wait_for_press_to_turn_on

; LED is off, button is pressed, wait for the release to turn on LED
wait_for_release_to_turn_on

		; Get the value from the switch
		LDR R0, [R5]

		; Check if the button is released
		CMP R0, R4

		; If it is not released, continue waiting
		;
		; Button is high by default due to the pull up resistors
		; configured above, so if it is not 1, it is still being pressed.
		BNE wait_for_release_to_turn_on

		; Go back to the start of the loop
		B loop

		; Make sure the section is aligned
		ALIGN

		; End of file
		END
