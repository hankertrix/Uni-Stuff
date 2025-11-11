; ADC two channel
; Samples two ADC channels, PortE bit 4 (PE4) and bit 5 (PE5),
; using Sample Sequencer 2 (SS2)

; GPIO_PORTE and ADC0 address

GPIO_PORTE_AFSEL_R	EQU 0x40024420
GPIO_PORTE_DEN_R	EQU 0x4002451C
GPIO_PORTE_AMSEL_R 	EQU 0x40024528

ADC0_ACTSS_R		EQU 0x40038000
ADC0_PC_R			EQU	0x40038FC4
ADC0_SSPRI_R		EQU	0x40038020
ADC0_EMUX_R			EQU	0x40038014
ADC0_SSMUX2_R		EQU 0x40038080
ADC0_SSCTL2_R		EQU	0x40038084
ADC0_IM_R			EQU 0x40038008
ADC0_PSSI_R			EQU 0x40038028
ADC0_RIS_R			EQU	0x40038004
ADC0_SSFIFO2_R		EQU	0x40038088
ADC0_ISC_R			EQU	0x4003800C

SYSCTL_RCGCGPIO_R	EQU 0x400FE608		; GPIO run mode clock gating control

SYSCTL_RCGCADC_R 	EQU 0x400FE638		; ADC run mode clock gating control

		THUMB
		AREA	DATA, ALIGN=4
		EXPORT	Result [DATA,SIZE=4]
Result	SPACE	4


		AREA	|.text|, CODE, READONLY, ALIGN=2
		THUMB
		EXPORT	Start

Start

; initialize Port E
; activate clock for PortE

		LDR R1, =SYSCTL_RCGCGPIO_R 		; R1 = address of SYSCTL_RCGCGPIO_R
		LDR R0, [R1]					;
		ORR R0, R0, #0x10				; turn on GPIOE clock
		STR R0, [R1]
		NOP								; allow time for clock to finish
		NOP
		NOP

; no need to unlock PE4 and PE5

; select alternate function
		LDR R1, =GPIO_PORTE_AFSEL_R
		LDR R0, [R1]
		ORR R0, R0, #0x30				; enable alternate function on PE4 and PE5
		STR R0, [R1]

; disable digital port
		LDR R1, =GPIO_PORTE_DEN_R
		LDR R0, [R1]
		BIC R0, R0, #0x30				; disable digital I/O on PE4 and PE5
		STR R0, [R1]

; enable analog mode
		LDR R1, =GPIO_PORTE_AMSEL_R
		LDR R0, [R1]
		ORR R0, R0, #0x30				; enable PE4 analog function
		STR R0, [R1]

; activate clock for ADC0
		LDR R1, =SYSCTL_RCGCADC_R
		LDR R0, [R1]
		ORR R0, R0, #0x01				; activate ADC0
		STR R0, [R1]

		BL Delay						; delay subroutine -> allow time for clock to finish

		LDR R1, =ADC0_PC_R
		LDR R0, [R1]
		BIC R0, R0, #0x0F				; clear max sample rate field
		ORR R0, R0, #0x1				; configure for 125K samples/sec
		STR R0, [R1]

		LDR R1, =ADC0_SSPRI_R
		LDR R0, =0x1023					; SS2 is highest priority
		STR R0, [R1]

		LDR R1, =ADC0_ACTSS_R
		LDR R0, [R1]
		BIC R0, R0, #0x0004				; disable SS2 before configuration to
		STR R0, [R1]					; prevent erroneous execution if a trigger event were to occur

		LDR R1, =ADC0_EMUX_R
		LDR R0, [R1]
		BIC R0, R0, #0x0F00				; SS2 is software trigger
		STR R0, [R1]

		LDR R1, =ADC0_SSMUX2_R
		LDR R0, [R1]
		BIC R0, R0, #0x00FF				; clear SS2 field
		ADD R0, R0, #0x89				; set channel -> select input pin AIN8 and AIN9
		STR R0, [R1]

		LDR R1, =ADC0_SSCTL2_R
		LDR R0, =0x0060					; configure sample -> not reading Temp sensor, not differentially sampled,
		STR R0, [R1]					; assert raw interrupt signal at the end of conversion, second sample is last sample

		LDR R1, =ADC0_IM_R
		LDR R0, [R1]
		BIC R0, R0, #0x0004				; disable SS2 interrupts
		STR R0, [R1]

		LDR R1, =ADC0_ACTSS_R
		LDR R0, [R1]
		ORR R0, R0, #0x0004				; enable SS2
		STR R0, [R1]

Loop
		LDR R1, =ADC0_PSSI_R
		MOV R0, #0x04					; initiate sampling in SS2
		STR R0, [R1]

		LDR R1, =ADC0_RIS_R				; R1 = address of ADC Raw Interrupt Status
		LDR R0, [R1]					; check end of a conversion
		CMP	R0, #0x04					; when a sample has completed conversion -> a raw interrupt is enabled
		BNE	Loop

		LDR R1, =ADC0_SSFIFO2_R			; load SS2 result FIFO into R1
		LDR R2, =Result
		LDR R0, [R1]
		STR R0, [R2]					; store PE4 reading in addr 0x20000000 & 0x20000001

		LDR R0, [R1]
		ADD R2, R2, #04
		STR R0, [R2]					; store PE5 reading in addr 0x20000004 & 0x20000005

		LDR R1, =ADC0_ISC_R
		LDR R0, [R1]
		ORR R0, R0, #04					; acknowledge conversion
		STR R0, [R1]

		B Loop

Delay									; Delay subroutine
		MOV R7,#0x0F

Countdown
		SUBS R7, #1						; subtract and set the flags based on the result
		BNE Countdown

		BX LR							; return from subroutine

		ALIGN							; make sure the end of this section is aligned
		END								; end of file
