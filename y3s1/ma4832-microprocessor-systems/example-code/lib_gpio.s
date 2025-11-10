; Setup sequence for GPIO digital ports:
;	1. Enable the clock for the port [RCGCGPIO]
;	2. Set analogue functionality (enable or disable) [GPIOAMSEL]
;	3. Configure the pins as GPIO [GPIOPCTL]
;	4. Set the pin's direction (input or output) [GPIODIR]
;	5. Set the alternate function (enable or disable) [GPIOAFSEL]
;	6. Set pull-up resistors if needed (enable or disable) [GPIOPUR]
;	7. Set the digital ports (enable or disable) [GPIODEN]

		AREA    |.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT  activate_clock
		EXPORT  setup_on_board_led
		EXPORT  set_led
		EXPORT  toggle_led

; The base address for the GPIO ports
GPIO_PORT_A_BASE	EQU 0x40004000
GPIO_PORT_B_BASE	EQU 0x40005000
GPIO_PORT_C_BASE	EQU 0x40006000
GPIO_PORT_D_BASE	EQU 0x40007000
GPIO_PORT_E_BASE	EQU 0x40024000
GPIO_PORT_F_BASE	EQU 0x40025000

; The offsets for the GPIO registers
; Just use ORR (bitwise logical OR) to add them to the base
GPIO_DATA_OFFSET	EQU 0x000003FC
GPIO_DIR_OFFSET		EQU 0x00000400
GPIO_AFSEL_OFFSET	EQU 0x00000420
GPIO_PUR_OFFSET		EQU 0x00000510
GPIO_DEN_OFFSET		EQU 0x0000051C
GPIO_AMSEL_OFFSET	EQU 0x00000528
GPIO_PCTL_OFFSET	EQU 0x0000052C

; The register for the on board LED for all 3 colours
ON_BOARD_LED		EQU 0x40025038

; Values to write to the register for the LED:
LED_OFF				EQU 0x00
LED_RED				EQU 0x02
LED_BLUE			EQU 0x04
LED_GREEN			EQU 0x08
LED_WHITE			EQU 0x0E

; GPIO DATA register ports
; Skip the first 2 bits to write to the GPIO register directly.
;
; Port:		--76 5432 10--
; Binary:	0000 0000 0000
;
; Convert the binary to hexadecimal
; and ORR (bitwise logical OR) it with the base address
; to access the data for the port

; GPIO run mode clock gating control
SYSCTL_RCGCGPIO_R	EQU 0x400FE608

; GPIO run mode clock gating control
; Port:		--FE DCBA
; Binary:	0000 0000
;
; Convert the binary to hexadecimal
; and write to the register to enable the specified port

; All arguments to the functions are in the high registers,
; i.e. registers R8, R9, R10, R11, R12
;
; The return values will be placed in R7, if any


; Call this label after importing to activate the clock
; for the required ports
;
; Pass the bits required in register R8.
;
; To get the correct bits, look below:
;
; GPIO run mode clock gating control
; Port:		--FE DCBA
; Binary:	0000 0000
activate_clock

		; Get the address of the RCGCGPIO register
		LDR R0, =SYSCTL_RCGCGPIO_R

		; Get the previously held value
		LDR R0, [R1]

		; Enable the wanted ports
		; The bits are saved to register R8 before calling
		ORR R0, R0, R8

		; Write to the register
		STR R0, [R1]

		; Wait for the clock to finish
		NOP
		NOP
		NOP

		; Return from the function
		BX LR


; Call this label to setup the on board LED
setup_on_board_led

		; Set bit 5 to enable port F
		MOV R8, #0x20

		; Store the link register in R7
		MOV R7, LR

		; Activate the clock for port F
		BL activate_clock

		; Put the link register back
		MOV LR, R7

		; Load the Port F address
		LDR R3, =GPIO_PORT_F_BASE

		; Binary 0000 1110 for all 3 colours of the LED
		; Red, Blue and Green
		MOV R4, #0x0E

; Disable the analogue functionality
; 1 for enable, 0 for disable

		; Get the address of the AMSEL register
		LDR R2, =GPIO_AMSEL_OFFSET

		; Merge the base and the offset to get the address
		ORR R1, R3, R2

		; Load the existing value
		LDR R0, [R1]

		; Clear the required bits
		BIC R0, R4

		; Store the value to the register
		STR R0, [R1]

; Configure as GPIO
; 0 for GPIO, and 1 for non-GPIO

		; Get the address of the PCTL register
		LDR R2, =GPIO_PCTL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits
		BIC R0, R0, #0x00000FF0		; Bit 1 and 2
		BIC R0, R0, #0x0000F000		; Bit 3
		STR R0, [R1]

; Set the direction (input or output)
; 1 for output, and 0 for input

		; Get the address of the direction register
		LDR R2, =GPIO_DIR_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the required bits for output
		ORR R0, R0, R4
		STR R0, [R1]

; Set alternate function
; 1 for enabled, and 0 for disabled

		; Get the address of the alternate function register
		LDR R2, =GPIO_AFSEL_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits to disable
		BIC R0, R0, R4
		STR R0, [R1]

; Enable the digital port
; 1 for enabled, and 0 for disabled

		; Get the address of the digital port register
		LDR R2, =GPIO_DEN_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the required bits
		ORR R0, R0, R4
		STR R0, [R1]

		; Return from the function
		BX LR


; Call this label after importing to turn the red LED on
;
; Pass the desired bit of the LED in R8:
;	Possible values:
;	- LED_OFF
;	- LED_RED
;	- LED_BLUE
;	- LED_GREEN
;	- LED_WHITE
set_led

		; Get the register for the on board LED
		LDR R1, =ON_BOARD_LED

		; Set the LED
		MOV R0, R8

		; Store the value to the register
		STR R0, [R1]

		; Return from the function
		BX LR


; Call this label after importing to turn the red LED on
;
; Pass the desired bit of the LED in R8:
;	Possible values:
;	- LED_OFF
;	- LED_RED
;	- LED_BLUE
;	- LED_GREEN
;	- LED_WHITE
toggle_led

		; Get the register for the on board LED
		LDR R1, =ON_BOARD_LED

		; Get the previous value
		LDR R0, [R1]

		; Toggle the LED by flipping it using exclusive or
		EOR R0, R0, R8

		; Store the value to the register
		STR R0, [R1]

		; Return from the function
		BX LR


		; Make sure the section is aligned
		ALIGN

		; End of file
		END
