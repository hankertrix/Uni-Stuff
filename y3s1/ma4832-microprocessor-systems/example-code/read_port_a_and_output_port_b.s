; GPIO_PORT A address

GPIO_PORTA_DATA_R		EQU 0x400043FC
GPIO_PORTA_DIR_R		EQU 0x40004400
GPIO_PORTA_AFSEL_R		EQU 0x40004420
GPIO_PORTA_PUR_R		EQU 0x40004510
GPIO_PORTA_DEN_R		EQU 0x4000451C
GPIO_PORTA_AMSEL_R		EQU 0x40004528
GPIO_PORTA_PCTL_R		EQU 0x4000452C
PA_4567					EQU 0x400043C0		; PortA bit 4-7

; GPIO_PORTB address

GPIO_PORTB_DATA_R		EQU 0x400053FC
GPIO_PORTB_DIR_R		EQU 0x40005400
GPIO_PORTB_AFSEL_R		EQU 0x40005420
GPIO_PORTB_PUR_R		EQU 0x40005510
GPIO_PORTB_DEN_R		EQU 0x4000551C
GPIO_PORTB_AMSEL_R		EQU 0x40005528
GPIO_PORTB_PCTL_R		EQU 0x4000552C
PB_0123					EQU 0x4000503C		; Port B bit 0-3

; GPIO_PORTD address

GPIO_PORTD_DATA_R		EQU 0x400073FC
GPIO_PORTD_DIR_R		EQU 0x40007400
GPIO_PORTD_AFSEL_R		EQU 0x40007420
GPIO_PORTD_PUR_R		EQU 0x40007510
GPIO_PORTD_DEN_R		EQU 0x4000751C
GPIO_PORTD_AMSEL_R		EQU 0x40007528
GPIO_PORTD_PCTL_R		EQU 0x4000752C
PD						EQU 0x40007024		; Enable Port D bit 0 and 3

SYSCTL_RCGCGPIO_R		EQU 0x400FE608		; GPIO run mode clock gating control

		AREA	|.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	Start

Start


; initialize Port A
; enable digital I/O, ensure alt. functions off.

; activate clock for Port A, B and D
		LDR R1, =SYSCTL_RCGCGPIO_R			; R1 = address of SYSCTL_RCGCGPIO_R
		LDR R0, [R1]						;
		ORR R0, R0, #0x0B					; turn on GPIO A, B and D clock
		STR R0, [R1]
		NOP									; allow time for clock to finish
		NOP
		NOP

; no need to unlock Port A bits

; disable analog mode
		LDR R1, =GPIO_PORTA_AMSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0					; disable analog mode on PortA bit 4-7
		STR R0, [R1]

;configure as GPIO
		LDR R1, =GPIO_PORTA_PCTL_R
		LDR R0, [R1]
		BIC R0, R0,#0x00FF0000				; clear PortA bit 4 & 5
		BIC R0, R0,#0xFF000000				; clear PortA bit 6 & 7
		STR R0, [R1]

;set direction register
		LDR R1, =GPIO_PORTA_DIR_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0					; set PortA bit 4-7 input (0: input, 1: output)
		STR R0, [R1]

; disable alternate function
		LDR R1, =GPIO_PORTA_AFSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0					; disable alternate function on PortA bit 4-7
		STR R0, [R1]

; pull-up resistors on switch pins
		LDR R1, =GPIO_PORTA_PUR_R;
		LDR R0, [R1];
		ORR R0, R0, #0xF0					; enable pull-up on PortA bit 4-7
		STR R0, [R1]

; enable digital port
		LDR R1, =GPIO_PORTA_DEN_R
		LDR R0, [R1]
		ORR R0, R0, #0xF0					; enable digital I/O on PortA bit 4-7
		STR R0, [R1]

; no need to unlock Port B bits
; disable analog mode
		LDR R1, =GPIO_PORTB_AMSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0x0F					; Clear bit 0-3, disable analog function
		STR R0, [R1]

; configure as GPIO
		LDR R1, =GPIO_PORTB_PCTL_R
		LDR R0, [R1]
		BIC R0, R0,#0x000000FF				; bit clear PortA bit 0 & 1
		BIC R0, R0,#0x0000FF00				; bit clear PortA bit 2 & 3
		STR R0, [R1]

; set direction register
		LDR R1, =GPIO_PORTB_DIR_R
		LDR R0, [R1]
		ORR R0, R0, #0x0F					; set PortB bit 0-3 as output (0: input, 1: output)
		STR R0, [R1]

; disable alternate function
		LDR R1, =GPIO_PORTB_AFSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0x0F					; disable alternate function on PortB bit 0-3
		STR R0, [R1]

; enable digital port
		LDR R1, =GPIO_PORTB_DEN_R
		LDR R0, [R1]
		ORR R0, #0x0F						; enable PortB digital I/O
		STR R0, [R1]

; no need to unlock Port D bits
; disable analog mode
		LDR R1, =GPIO_PORTD_AMSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0x09					; Clear bit 0 and 3 to disable analog function
		STR R0, [R1]

; configure as GPIO
		LDR R1, =GPIO_PORTD_PCTL_R
		LDR R0, [R1]
		BIC R0, R0,#0x0000000F				; clear PortD bit 0
		BIC R0, R0,#0x0000F000				; clear PortD bit 3
		STR R0, [R1]

; set direction register
		LDR R1, =GPIO_PORTD_DIR_R
		LDR R0, [R1]
		BIC R0, R0, #0x01					; set PortD bit 0 input
		ORR R0, R0, #0x08					; set PortD bit 3 output (0: input, 1: output)
		STR R0, [R1]

; disable alternate function
		LDR R1, =GPIO_PORTD_AFSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0x09					; disable alternate function on bit 0 and 3
		STR R0, [R1]

; pull-up resistors on switch pins
		LDR R1, =GPIO_PORTD_PUR_R			; R1 = address of GPIO_PORTD_PUR_R
		LDR R0, [R1]						;
		ORR R0, R0, #0x01					; enable pull-up on PortD bit 0
		STR R0, [R1]

; enable digital port
		LDR R1, =GPIO_PORTD_DEN_R
		LDR R0, [R1]
		ORR R0, R0, #0x09					; enable digital I/O on bit 0 and 3
		STR R0, [R1]

Again1
		BL readPortA
		BL outputPortB

		; Port D stuff
		LDR R1, =PD
		MOV R0, #0
		STR R0, [R1]						; "off" buzzer
		LDR R2, [R1]						; check switch, PortD bit 0 status
		TST R2, #1							;
		BNE Again1							; perform a bitwise AND operation and test again if switch is not pressed
		MOV R0, #0x08						; when switch is pressed, set PortD bit 3 "high" to turn on buzzer
		STR R0, [R1]						;
Again2
		BL readPortA
		BL outputPortB
		LDR R1, =PD
		LDR R2, [R1]						; check switch
		TST R2, #1							; perform a bitwise AND operation and test again if switch is not released
		BEQ Again2							;
		B Again1							;

readPortA
		LDR R1, =PA_4567					; Get the address of port A
		LDR R0, [R1]						; R0 = dip switch status
		MOV R7, R0							; store data in R7
		BX LR

outputPortB
		LDR R1, =PB_0123					; Get the address of port B
		LSR R0, R7, 4						; Shift the value of R7 (port A) right 4 bits
		STR R0, [R1]						; Write the result to port B
		BX LR

		ALIGN								; make sure the end of this section is aligned
		END									; end of file
