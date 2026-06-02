; Setup sequence for ADC
;	1. Enable clock for GPIO port [RCGCGPIO]
;	2. Select alternate function for port [GPIOAFSEL]
;	3. Disable digital port [GPIODEN]
;	4. Enable analogue mode [GPIOAMSEL]
;	5. Activate clock for ADCA [RCGCADC]
;	6. Configure ADC max sample rate [ADCPC]
;	7. Configure ADC priority [ADCSSPRI]
;	8. Disable sample sequencer for safe configuration [ADCACTSS]
;	9. Configure the trigger select [ADCEMUX]
;	10. Configure the input channel [ADCSSMUXn]
;	11. Configure the sample [ADCSSCTLn]
;	12. Configure the interrupt mask [ADCIM]
;	13. Re-enable the sample sequencer [ADCACTSS]

		AREA	|.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	setup_adc_ss0
		EXPORT	setup_adc_ss1
		EXPORT	setup_adc_ss2
		EXPORT	setup_adc_ss3
		EXPORT	delay

; ADC 0 base address and variables
ADC0_BASE		EQU 0x40038000
ADC0_RCGCADC	EQU 0x1

; ADC 1 base address and variables
ADC1_BASE		EQU 0x40039000
ADC1_RCGCADC	EQU 0x2

; Offsets for the ADC
ADC_ACTSS_OFFSET		EQU 0x00000000
ADC_PC_OFFSET			EQU 0x00000FC4
ADC_SSPRI_OFFSET		EQU 0x00000020
ADC_EMUX_OFFSET			EQU 0x00000014
ADC_IM_OFFSET			EQU 0x00000008
ADC_PSSI_OFFSET			EQU 0x00000028
ADC_RIS_OFFSET			EQU 0x00000004
ADC_ISC_OFFSET			EQU 0x0000000C

; Offsets for sample sequencer 0
ADC_SSMUX0_OFFSET		EQU 0x00000040
ADC_SSCTL0_OFFSET		EQU 0x00000044
ADC_SSFIFO0_OFFSET		EQU 0x00000048

; Variables for sample sequencer 0
SS0_VALUE				EQU 0x01
SS0_SSPRI				EQU 0x3210
SS0_EMUX				EQU 0x000F

; Offsets for sample sequencer 1
ADC_SSMUX1_OFFSET		EQU 0x00000060
ADC_SSCTL1_OFFSET		EQU 0x00000064
ADC_SSFIFO1_OFFSET		EQU 0x00000068

; Variables for sample sequencer 1
SS1_VALUE				EQU 0x02
SS1_SSPRI				EQU 0x2103
SS1_EMUX				EQU 0x00F0

; Offsets for sample sequencer 2
ADC_SSMUX2_OFFSET		EQU 0x00000080
ADC_SSCTL2_OFFSET		EQU 0x00000084
ADC_SSFIFO2_OFFSET		EQU 0x00000088

; Variables for sample sequencer 2
SS2_VALUE				EQU 0x04
SS2_SSPRI				EQU 0x1023
SS2_EMUX				EQU 0x0F00

; Offsets for sample sequencer 3
ADC_SSMUX3_OFFSET		EQU 0x000000A0
ADC_SSCTL3_OFFSET		EQU 0x000000A4
ADC_SSFIFO3_OFFSET		EQU 0x000000A8

; Variables for sample sequencer 3
SS3_VALUE				EQU 0x08
SS3_SSPRI				EQU 0x0123
SS3_EMUX				EQU 0xF000

; ADC run mode clock gating control
SYSCTL_RCGCADC_R		EQU 0x400FE638


; Call this function after importing to setup the ADC
; with sample sequencer 0
;
; Pass the ADC wanted to R8
; Pass the analogue inputs used to R9 and R10
; Pass the number of analogue inputs to R11
;
; Function returns:
;	R4: Sample sequencer value
;	R5: PSSI address
;	R6: RIS address
;	R7: FIFO address
;	R8: ISC address
setup_adc_ss0

		; Load the values for SS0
		LDR R4, =SS0_VALUE
		LDR R5, =SS0_SSPRI
		LDR R6, =SS0_EMUX

		; Go to the check_given_adc function
		B check_given_adc


; Call this function after importing to setup the ADC
; with sample sequencer 1
;
; Pass the ADC wanted to R8
; Pass the analogue inputs used to R9 and R10
;
; Function returns:
;	R4: Sample sequencer value
;	R5: PSSI address
;	R6: RIS address
;	R7: FIFO address
;	R8: ISC address
setup_adc_ss1

		; Load the values for SS1
		LDR R4, =SS1_VALUE
		LDR R5, =SS1_SSPRI
		LDR R6, =SS1_EMUX

		; Go to the check_given_adc function
		B check_given_adc


; Call this function after importing to setup the ADC
; with sample sequencer 2
;
; Pass the ADC wanted to R8
; Pass the analogue inputs used to R9 and R10
; Pass the number of analogue inputs to R11
;
; Function returns:
;	R4: Sample sequencer value
;	R5: PSSI address
;	R6: RIS address
;	R7: FIFO address
;	R8: ISC address
setup_adc_ss2

		; Load the values for SS2
		LDR R4, =SS2_VALUE
		LDR R5, =SS2_SSPRI
		LDR R6, =SS2_EMUX

		; Go to the check_given_adc function
		B check_given_adc


; Call this function after importing to setup the ADC
; with sample sequencer 3
;
; Pass the ADC wanted to R8
; Pass the analogue inputs used to R9 and R10
; Pass the number of analogue inputs to R11
;
; Function returns:
;	R4: Sample sequencer value
;	R5: PSSI address
;	R6: RIS address
;	R7: FIFO address
;	R8: ISC address
setup_adc_ss3

		; Load the values for SS3
		LDR R4, =SS3_VALUE
		LDR R5, =SS3_SSPRI
		LDR R6, =SS3_EMUX

		; Go to the check_given_adc function
		B check_given_adc

; This function checks the given ADC
check_given_adc

		; Check if the ADC given is ADC 1
		LDR R0, =ADC1_BASE
		CMP R8, R0

		; If it is, load the value for ADC 1
		LDREQ R7, =ADC1_RCGCADC

		; Otherwise, load the value for ADC 0
		LDRNE R7, =ADC0_RCGCADC

; Activate the clock for the given ADC

		; Get the value of the RCGCADC register
		LDR R1, =SYSCTL_RCGCADC_R
		LDR R0, [R1]

		; Activate the given ADC
		ORR R0, R0, R7
		STR R0, [R1]

		; Move the ADC base address into R3
		MOV R3, R8

		; Move the values of R9, R10 and R11 1 register up
		; Basically:
		; - R10 contains the first bit for the analogue input
		; - R11 contains the second bit for the analogue input
		; - R12 contains the number of analogue inputs
		MOV R12, R11
		MOV R11, R10
		MOV R10, R9

		; Total delay
		MOV R8, #0x0F

		; Subtraction amount
		MOV R9, #1

		; Store the link register in R7
		MOV R7, LR

		; Call the delay function
		BL delay

		; Move the link register value back
		MOV LR, R7

; Configure the sample rate

		; Get the value of the ADCPC register
		LDR R2, =ADC_PC_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the max sample rate field
		BIC R0, R0, #0x0F

		; Configure for 125k samples/sec
		;
		; Possible values:
		; - 0x1: 125k samples/sec
		; - 0x3: 250k samples/sec
		; - 0x5: 500k samples/sec
		; - 0x7: 1M samples/sec
		ORR R0, R0, #0x1
		STR R0, [R1]

; Configure the sample sequencer priority

		; Get the value of the SSPRI register
		LDR R2, =ADC_SSPRI_OFFSET
		ORR R1, R3, R2

		; Set the priority to the one given, which is in R5
		STR R5, [R1]

; Disable the sample sequencer given
; The value is in R4

		; Get the value of the ACTSS register
		LDR R2, =ADC_ACTSS_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Disable the sample sequencer before configuration
		; to prevent erroneous execution if a trigger event were to occur
		BIC R0, R0, R4
		STR R0, [R1]

; Set the trigger
; The value is in R6

		; Get the value of EMUX register
		LDR R2, =ADC_EMUX_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the trigger to always trigger
		BIC R0, R0, R6

; Load the addresses for the sample sequencer

		; Check if the sample sequencer value is for SS0
		LDR R0, =SS0_VALUE
		CMP R4, R0

		; If it is, load the addresses needed into R5, R6, and R7
		LDREQ R5, =ADC_SSMUX0_OFFSET
		LDREQ R6, =ADC_SSCTL0_OFFSET
		LDREQ R7, =ADC_SSFIFO0_OFFSET

		; Check if the sample sequencer value is for SS1
		LDR R0, =SS1_VALUE
		CMP R4, R0

		; If it is, load the addresses needed into R5, R6, and R7
		LDREQ R5, =ADC_SSMUX1_OFFSET
		LDREQ R6, =ADC_SSCTL1_OFFSET
		LDREQ R7, =ADC_SSFIFO1_OFFSET

		; Check if the sample sequencer value is for SS2
		LDR R0, =SS2_VALUE
		CMP R4, R0

		; If it is, load the addresses needed into R5, R6, and R7
		LDREQ R5, =ADC_SSMUX2_OFFSET
		LDREQ R6, =ADC_SSCTL2_OFFSET
		LDREQ R7, =ADC_SSFIFO2_OFFSET

		; Check if the sample sequencer value is for SS3
		LDR R0, =SS3_VALUE
		CMP R4, R0

		; If it is, load the addresses needed into R5, R6, and R7
		LDREQ R5, =ADC_SSMUX3_OFFSET
		LDREQ R6, =ADC_SSCTL3_OFFSET
		LDREQ R7, =ADC_SSFIFO3_OFFSET

; Set the channel to sample from
; The address is in R5
; The values given are in R10 and R11

		; Get the value of the SSMUX register
		MOV R2, R5
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the input field
		BIC R0, R0, #0x00FF
		BIC R0, R0, #0xFF00

		; Set the channels
		ADD R0, R0, R11
		ADD R0, R0, R12
		STR R0, [R1]

; Configure the sample
; The number of analogue inputs are in R12

		; Get the SSCTL register
		MOV R2, R6
		ORR R1, R3, R2


		; Multiply the number of analogue inputs
		; by the number of bits per hex value
		MOV R0, #4
		MUL R12, R0

		; The default sample configuration
		LDR R0, =0x0006

		; Shift R0 by the amount in R12 and write the value
		LSL R0, R12
		STR R0, [R1]

; Disable the interrupts on the sample sequencer
; The value is in R4

		; Get the value of the IM register
		LDR R2, =ADC_IM_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Clear the required bits for the sample sequencer
		BIC R0, R0, R4

; Enable the sample sequencer

		; Get the value of the ACTSS register
		LDR R2, =ADC_ACTSS_OFFSET
		ORR R1, R3, R2
		LDR R0, [R1]

		; Set the required bits to enable the sample sequencer
		ORR R0, R0, R4
		STR R0, [R1]

		; Set the PSSI register in R5
		LDR R5, =ADC_PSSI_OFFSET
		ORR R5, R5, R3

		; Set the RIS register in R6
		LDR R6, =ADC_RIS_OFFSET
		ORR R6, R6, R3

		; The FIFO offset is already in R7,
		; so just create the address in R7
		ORR R7, R7, R3

		; Set the ISC register in R8
		LDR R8, =ADC_ISC_OFFSET
		ORR R8, R8, R3

		; Return from the function
		BX LR


; Delay function to wait for ADC clock to finish
;
; Pass the total delay to R8
; Pass the subtraction to R9
delay

		; Subtract and set the condition flags
		SUBS R8, R9

		; If it's not zero, continue delaying
		BNE delay

		; Return from the function
		BX LR


		; Make sure the section is aligned
		ALIGN

		; End of file
		END
