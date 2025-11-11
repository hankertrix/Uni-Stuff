	GET		lib_gpio.s
	GET		lib_adc.s

	THUMB
	AREA	DATA, ALIGN=4
	EXPORT	Result	[Data, SIZE=4]
Result	SPACE	4

	AREA	|.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT	Start

Start

; Activate clock for port E

	; Pass the required value to activate the clock
	MOV R8, #0x10
	BL activate_clock

	; Load the base address for port E
	LDR R3, =GPIO_PORT_E_BASE

	; The value for port E bit 4 and 5 (PE4 and PE5)
	LDR R4, #0x30

; Enable alternate function

	; Get the value of the AFSEL register
	LDR R2, =GPIO_AFSEL_OFFSET
	ORR R1, R3, R2
	LDR R0, [R1]

	; Set the required bits for alternate function
	ORR R0, R0, R4
	STR R0, [R1]

; Disable the digital port

	; Get the value of the DEN register
	LDR R2, =GPIO_DEN_OFFSET
	ORR R1, R3, R2
	LDR R0, [R1]

	; Clear the required bits to disable digital IO
	BIC R0, R0, R4
	STR R0, [R1]

; Enable analogue functionality

	; Get the value of the AMSEL register
	LDR R2, =GPIO_AMSEL_OFFSET
	ORR R1, R3, R2
	LDR R0, [R1]

	; Set the required bits to enable analogue functionality
	ORR R0, R0, R4
	STR R0, [R1]

; Set up the ADC

	; Set the ADC base
	MOV R8, =ADC0_BASE

	; Set the analogue inputs
	MOV R9, #0x89

	; Set the number of analogue inputs
	MOV R11, #2

	; Set up the ADC using sample sequencer 2
	BL setup_adc_ss2

	; Function returns:
	;	R4: Sample sequencer value
	;	R5: PSSI address
	;	R6: RIS address
	;	R7: FIFO address
	;	R8: ISC address

; Main loop
loop

	; Initiate sampling in the sample sequencer using the PSSI
	MOV R1, R5
	MOV R0, R4
	STR R0, [R1]

	; Get the value of the ADC raw interrupt status (RIS)
	MOV R1, R6
	LDR R0, [R1]

	; Check if a sample has finished conversion
	CMP R0, R4

	; If it's not done, check again
	BNE loop

	; Otherwise, load the result

	; Get the first value of the FIFO
	MOV R1, R7
	LDR R0, [R1]

	; Store the first value, PE4 reading,
	; in 0x2000.0000 and 0x2000.0001
	LDR R2, =Result
	STR R0, [R2]

	; Get the second value of the FIFO
	LDR R0, [R1]

	; Offset the value of R2 by 4 bytes
	ADD R2, R2, #4

	; Store the second value, PE5 reading,
	; in 0x2000.0004 and 0x2000.0005
	STR R0, [R2]

	; Get the value of the ISC register
	MOV R1, R8
	LDR R0, [R1]

	; Acknowledge conversion
	ORR R0, R0, R4
	STR R0, [R1]

	; Continue the loop
	B loop

	; Make sure the section is aligned
	ALIGN

	; End of file
	END
