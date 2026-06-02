		GET		lib_gpio.s

; Port D bit 0
PUSH_BUTTON		EQU 0x40027004

		AREA	|.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	Start

Start

		; Setup the on board LED
		BL setup_on_board_led

		; Activate clock for port D
		LDR R8, #0x08
		BL activate_clock

		; Load the bits required for port D
		MOV R4, #0x01

		; Get the base address of port D
		LDR R3, =GPIO_PORT_D_BASE

		; Get the address of the AMSEL register
		LDR R2, =GPIO_AMSEL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the address of the PCTL register
		LDR R2, =GPIO_PCTL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the address of the direction register
		LDR R2, =GPIO_DIR_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits for input
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the address of the alternate function register
		LDR R2, =GPIO_AFSEL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits to disable
		BIC R0, R0, R4
		STR R0, [R1]

		; Get the address of the pull up resistors
		LDR R2, =GPIO_PUR_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the required bits to enable
		ORR R0, R0, R4
		STR R0, [R1]

		; Get the address of the digital port register
		LDR R2, =GPIO_DEN_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the required bits to enable
		ORR R0, R0, R4
		STR R0, [R1]

		; Load the address of the push button
		LDR R6, =PUSH_BUTTON

; Button has not been pressed, waiting for it to be pressed
button_not_pressed

		; Turn off the LED by default
		MOV R8, =LED_OFF
		BL set_led

		; Get the button status
		LDR R2, [R6]

		; Check if the button is pressed using AND
		TST R2, #1

		; If the button is not pressed, check again
		BNE button_not_pressed

		; Otherwise, turn on the LED
		MOV R8, =LED_WHITE
		BL set_led

; Button has been pressed, waiting for it to be released
button_pressed

		; Get the button status
		LDR R2, [R6]

		; Check if the button is pressed using AND
		TST R2, #1

		; If the button is pressed, check again
		BEQ button_pressed

		; Otherwise, loop
		B button_not_pressed

		; Make sure the section is aligned
		ALIGN

		; End of file
		END
