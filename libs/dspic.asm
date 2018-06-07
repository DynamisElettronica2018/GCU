
_setAllPinAsDigital:

;dspic.c,10 :: 		void setAllPinAsDigital(void) {
;dspic.c,11 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;dspic.c,12 :: 		}
L_end_setAllPinAsDigital:
	RETURN
; end of _setAllPinAsDigital

_setInterruptPriority:

;dspic.c,14 :: 		void setInterruptPriority(unsigned char device, unsigned char priority) {
;dspic.c,15 :: 		switch (device) {
	GOTO	L_setInterruptPriority0
;dspic.c,16 :: 		case INT0_DEVICE:
L_setInterruptPriority2:
;dspic.c,17 :: 		INT0_PRIORITY = priority;
	MOV.B	W11, W1
	MOV	#lo_addr(IPC0bits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #7, W1
	MOV	#lo_addr(IPC0bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(IPC0bits), W0
	MOV.B	W1, [W0]
;dspic.c,18 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,19 :: 		case INT1_DEVICE:
L_setInterruptPriority3:
;dspic.c,20 :: 		INT1_PRIORITY = priority;
	MOV.B	W11, W1
	MOV	#lo_addr(IPC4bits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #7, W1
	MOV	#lo_addr(IPC4bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(IPC4bits), W0
	MOV.B	W1, [W0]
;dspic.c,21 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,22 :: 		case INT2_DEVICE:
L_setInterruptPriority4:
;dspic.c,23 :: 		INT2_PRIORITY = priority;
	ZE	W11, W0
	MOV	W0, W1
	MOV.B	#12, W0
	SE	W0, W0
	SL	W1, W0, W1
	MOV	#lo_addr(IPC5bits), W0
	XOR	W1, [W0], W1
	MOV	#28672, W0
	AND	W1, W0, W1
	MOV	#lo_addr(IPC5bits), W0
	XOR	W1, [W0], W1
	MOV	W1, IPC5bits
;dspic.c,24 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,25 :: 		case INT4_DEVICE:
L_setInterruptPriority5:
;dspic.c,26 :: 		INT4_PRIORITY = priority;
	MOV.B	W11, W3
	MOV.B	#4, W0
	ZE	W3, W1
	SE	W0, W2
	SL	W1, W2, W3
	MOV	#lo_addr(IPC9bits), W0
	XOR.B	W3, [W0], W3
	MOV.B	#112, W0
	AND.B	W3, W0, W3
	MOV	#lo_addr(IPC9bits), W0
	XOR.B	W3, [W0], W3
	MOV	#lo_addr(IPC9bits), W0
	MOV.B	W3, [W0]
;dspic.c,27 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,28 :: 		case TIMER1_DEVICE:
L_setInterruptPriority6:
;dspic.c,29 :: 		TIMER1_PRIORITY = priority;
	ZE	W11, W0
	MOV	W0, W1
	MOV.B	#12, W0
	SE	W0, W0
	SL	W1, W0, W1
	MOV	#lo_addr(IPC0bits), W0
	XOR	W1, [W0], W1
	MOV	#28672, W0
	AND	W1, W0, W1
	MOV	#lo_addr(IPC0bits), W0
	XOR	W1, [W0], W1
	MOV	W1, IPC0bits
;dspic.c,30 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,31 :: 		case TIMER2_DEVICE:
L_setInterruptPriority7:
;dspic.c,32 :: 		TIMER2_PRIORITY = priority;
	ZE	W11, W0
	MOV	W0, W1
	MOV.B	#8, W0
	SE	W0, W0
	SL	W1, W0, W1
	MOV	#lo_addr(IPC1bits), W0
	XOR	W1, [W0], W1
	MOV	#1792, W0
	AND	W1, W0, W1
	MOV	#lo_addr(IPC1bits), W0
	XOR	W1, [W0], W1
	MOV	W1, IPC1bits
;dspic.c,33 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,34 :: 		case TIMER4_DEVICE:
L_setInterruptPriority8:
;dspic.c,35 :: 		TIMER4_PRIORITY = priority;
	MOV.B	W11, W3
	MOV.B	#4, W0
	ZE	W3, W1
	SE	W0, W2
	SL	W1, W2, W3
	MOV	#lo_addr(IPC5bits), W0
	XOR.B	W3, [W0], W3
	MOV.B	#112, W0
	AND.B	W3, W0, W3
	MOV	#lo_addr(IPC5bits), W0
	XOR.B	W3, [W0], W3
	MOV	#lo_addr(IPC5bits), W0
	MOV.B	W3, [W0]
;dspic.c,36 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,37 :: 		default:
L_setInterruptPriority9:
;dspic.c,38 :: 		break;
	GOTO	L_setInterruptPriority1
;dspic.c,39 :: 		}
L_setInterruptPriority0:
	CP.B	W10, #4
	BRA NZ	L__setInterruptPriority72
	GOTO	L_setInterruptPriority2
L__setInterruptPriority72:
	CP.B	W10, #5
	BRA NZ	L__setInterruptPriority73
	GOTO	L_setInterruptPriority3
L__setInterruptPriority73:
	CP.B	W10, #6
	BRA NZ	L__setInterruptPriority74
	GOTO	L_setInterruptPriority4
L__setInterruptPriority74:
	CP.B	W10, #8
	BRA NZ	L__setInterruptPriority75
	GOTO	L_setInterruptPriority5
L__setInterruptPriority75:
	CP.B	W10, #1
	BRA NZ	L__setInterruptPriority76
	GOTO	L_setInterruptPriority6
L__setInterruptPriority76:
	CP.B	W10, #2
	BRA NZ	L__setInterruptPriority77
	GOTO	L_setInterruptPriority7
L__setInterruptPriority77:
	CP.B	W10, #3
	BRA NZ	L__setInterruptPriority78
	GOTO	L_setInterruptPriority8
L__setInterruptPriority78:
	GOTO	L_setInterruptPriority9
L_setInterruptPriority1:
;dspic.c,40 :: 		}
L_end_setInterruptPriority:
	RETURN
; end of _setInterruptPriority

_setExternalInterrupt:

;dspic.c,42 :: 		void setExternalInterrupt(unsigned char device, char edge) {
;dspic.c,43 :: 		setInterruptPriority(device, MEDIUM_PRIORITY);
	PUSH	W11
	MOV.B	#4, W11
	CALL	_setInterruptPriority
	POP	W11
;dspic.c,44 :: 		switch (device) {
	GOTO	L_setExternalInterrupt10
;dspic.c,45 :: 		case INT0_DEVICE:
L_setExternalInterrupt12:
;dspic.c,46 :: 		INT0_TRIGGER_EDGE = edge;
	BTSS	W11, #0
	BCLR	INTCON2, #0
	BTSC	W11, #0
	BSET	INTCON2, #0
;dspic.c,47 :: 		INT0_OCCURRED = FALSE;
	BCLR	IFS0, #0
;dspic.c,48 :: 		INT0_ENABLE = TRUE;
	BSET	IEC0, #0
;dspic.c,49 :: 		break;
	GOTO	L_setExternalInterrupt11
;dspic.c,50 :: 		case INT1_DEVICE:
L_setExternalInterrupt13:
;dspic.c,51 :: 		INT1_TRIGGER_EDGE = edge;
	BTSS	W11, #0
	BCLR	INTCON2, #1
	BTSC	W11, #0
	BSET	INTCON2, #1
;dspic.c,52 :: 		INT1_OCCURRED = FALSE;
	BCLR	IFS1, #0
;dspic.c,53 :: 		INT1_ENABLE = TRUE;
	BSET	IEC1, #0
;dspic.c,54 :: 		break;
	GOTO	L_setExternalInterrupt11
;dspic.c,55 :: 		case INT2_DEVICE:
L_setExternalInterrupt14:
;dspic.c,56 :: 		INT2_TRIGGER_EDGE = edge;
	BTSS	W11, #0
	BCLR	INTCON2, #2
	BTSC	W11, #0
	BSET	INTCON2, #2
;dspic.c,57 :: 		INT2_OCCURRED = FALSE;
	BCLR	IFS1, #7
;dspic.c,58 :: 		INT2_ENABLE = TRUE;
	BSET	IEC1, #7
;dspic.c,59 :: 		break;
	GOTO	L_setExternalInterrupt11
;dspic.c,60 :: 		case INT4_DEVICE:
L_setExternalInterrupt15:
;dspic.c,61 :: 		INT4_TRIGGER_EDGE = edge;
	BTSS	W11, #0
	BCLR	INTCON2, #4
	BTSC	W11, #0
	BSET	INTCON2, #4
;dspic.c,62 :: 		INT4_OCCURRED = FALSE;
	BCLR	IFS2, #5
;dspic.c,63 :: 		INT4_ENABLE = TRUE;
	BSET	IEC2, #5
;dspic.c,64 :: 		default:
L_setExternalInterrupt16:
;dspic.c,65 :: 		break;
	GOTO	L_setExternalInterrupt11
;dspic.c,66 :: 		}
L_setExternalInterrupt10:
	CP.B	W10, #4
	BRA NZ	L__setExternalInterrupt80
	GOTO	L_setExternalInterrupt12
L__setExternalInterrupt80:
	CP.B	W10, #5
	BRA NZ	L__setExternalInterrupt81
	GOTO	L_setExternalInterrupt13
L__setExternalInterrupt81:
	CP.B	W10, #6
	BRA NZ	L__setExternalInterrupt82
	GOTO	L_setExternalInterrupt14
L__setExternalInterrupt82:
	CP.B	W10, #8
	BRA NZ	L__setExternalInterrupt83
	GOTO	L_setExternalInterrupt15
L__setExternalInterrupt83:
	GOTO	L_setExternalInterrupt16
L_setExternalInterrupt11:
;dspic.c,67 :: 		}
L_end_setExternalInterrupt:
	RETURN
; end of _setExternalInterrupt

_switchExternalInterruptEdge:

;dspic.c,69 :: 		void switchExternalInterruptEdge(unsigned char device) {
;dspic.c,70 :: 		switch (device) {
	GOTO	L_switchExternalInterruptEdge17
;dspic.c,71 :: 		case INT0_DEVICE:
L_switchExternalInterruptEdge19:
;dspic.c,72 :: 		if (INT0_TRIGGER_EDGE == NEGATIVE_EDGE) {
	BTSS	INTCON2, #0
	GOTO	L_switchExternalInterruptEdge20
;dspic.c,73 :: 		INT0_TRIGGER_EDGE = POSITIVE_EDGE;
	BCLR	INTCON2, #0
;dspic.c,74 :: 		} else {
	GOTO	L_switchExternalInterruptEdge21
L_switchExternalInterruptEdge20:
;dspic.c,75 :: 		INT0_TRIGGER_EDGE = NEGATIVE_EDGE;
	BSET	INTCON2, #0
;dspic.c,76 :: 		}
L_switchExternalInterruptEdge21:
;dspic.c,77 :: 		break;
	GOTO	L_switchExternalInterruptEdge18
;dspic.c,78 :: 		case INT1_DEVICE:
L_switchExternalInterruptEdge22:
;dspic.c,79 :: 		if (INT1_TRIGGER_EDGE == NEGATIVE_EDGE) {
	BTSS	INTCON2, #1
	GOTO	L_switchExternalInterruptEdge23
;dspic.c,80 :: 		INT1_TRIGGER_EDGE = POSITIVE_EDGE;
	BCLR	INTCON2, #1
;dspic.c,81 :: 		} else {
	GOTO	L_switchExternalInterruptEdge24
L_switchExternalInterruptEdge23:
;dspic.c,82 :: 		INT1_TRIGGER_EDGE = NEGATIVE_EDGE;
	BSET	INTCON2, #1
;dspic.c,83 :: 		}
L_switchExternalInterruptEdge24:
;dspic.c,84 :: 		break;
	GOTO	L_switchExternalInterruptEdge18
;dspic.c,85 :: 		case INT2_DEVICE:
L_switchExternalInterruptEdge25:
;dspic.c,86 :: 		if (INT2_TRIGGER_EDGE == NEGATIVE_EDGE) {
	BTSS	INTCON2, #2
	GOTO	L_switchExternalInterruptEdge26
;dspic.c,87 :: 		INT2_TRIGGER_EDGE = POSITIVE_EDGE;
	BCLR	INTCON2, #2
;dspic.c,88 :: 		} else {
	GOTO	L_switchExternalInterruptEdge27
L_switchExternalInterruptEdge26:
;dspic.c,89 :: 		INT2_TRIGGER_EDGE = NEGATIVE_EDGE;
	BSET	INTCON2, #2
;dspic.c,90 :: 		}
L_switchExternalInterruptEdge27:
;dspic.c,91 :: 		break;
	GOTO	L_switchExternalInterruptEdge18
;dspic.c,92 :: 		case INT4_DEVICE:
L_switchExternalInterruptEdge28:
;dspic.c,93 :: 		if (INT4_TRIGGER_EDGE == NEGATIVE_EDGE) {
	BTSS	INTCON2, #4
	GOTO	L_switchExternalInterruptEdge29
;dspic.c,94 :: 		INT4_TRIGGER_EDGE = POSITIVE_EDGE;
	BCLR	INTCON2, #4
;dspic.c,95 :: 		} else {
	GOTO	L_switchExternalInterruptEdge30
L_switchExternalInterruptEdge29:
;dspic.c,96 :: 		INT4_TRIGGER_EDGE = NEGATIVE_EDGE;
	BSET	INTCON2, #4
;dspic.c,97 :: 		}
L_switchExternalInterruptEdge30:
;dspic.c,98 :: 		default:
L_switchExternalInterruptEdge31:
;dspic.c,99 :: 		break;
	GOTO	L_switchExternalInterruptEdge18
;dspic.c,100 :: 		}
L_switchExternalInterruptEdge17:
	CP.B	W10, #4
	BRA NZ	L__switchExternalInterruptEdge85
	GOTO	L_switchExternalInterruptEdge19
L__switchExternalInterruptEdge85:
	CP.B	W10, #5
	BRA NZ	L__switchExternalInterruptEdge86
	GOTO	L_switchExternalInterruptEdge22
L__switchExternalInterruptEdge86:
	CP.B	W10, #6
	BRA NZ	L__switchExternalInterruptEdge87
	GOTO	L_switchExternalInterruptEdge25
L__switchExternalInterruptEdge87:
	CP.B	W10, #8
	BRA NZ	L__switchExternalInterruptEdge88
	GOTO	L_switchExternalInterruptEdge28
L__switchExternalInterruptEdge88:
	GOTO	L_switchExternalInterruptEdge31
L_switchExternalInterruptEdge18:
;dspic.c,101 :: 		}
L_end_switchExternalInterruptEdge:
	RETURN
; end of _switchExternalInterruptEdge

_getExternalInterruptEdge:

;dspic.c,103 :: 		char getExternalInterruptEdge(unsigned char device) {
;dspic.c,104 :: 		switch (device) {
	GOTO	L_getExternalInterruptEdge32
;dspic.c,105 :: 		case INT0_DEVICE:
L_getExternalInterruptEdge34:
;dspic.c,106 :: 		return INT0_TRIGGER_EDGE;
	CLR.B	W0
	BTSC	INTCON2, #0
	INC.B	W0
	GOTO	L_end_getExternalInterruptEdge
;dspic.c,107 :: 		case INT1_DEVICE:
L_getExternalInterruptEdge35:
;dspic.c,108 :: 		return INT1_TRIGGER_EDGE;
	CLR.B	W0
	BTSC	INTCON2, #1
	INC.B	W0
	GOTO	L_end_getExternalInterruptEdge
;dspic.c,109 :: 		case INT2_DEVICE:
L_getExternalInterruptEdge36:
;dspic.c,110 :: 		return INT2_TRIGGER_EDGE;
	CLR.B	W0
	BTSC	INTCON2, #2
	INC.B	W0
	GOTO	L_end_getExternalInterruptEdge
;dspic.c,111 :: 		case INT4_DEVICE:
L_getExternalInterruptEdge37:
;dspic.c,112 :: 		return INT4_TRIGGER_EDGE;
	CLR.B	W0
	BTSC	INTCON2, #4
	INC.B	W0
	GOTO	L_end_getExternalInterruptEdge
;dspic.c,113 :: 		default:
L_getExternalInterruptEdge38:
;dspic.c,114 :: 		return 0;
	CLR	W0
	GOTO	L_end_getExternalInterruptEdge
;dspic.c,115 :: 		}
L_getExternalInterruptEdge32:
	CP.B	W10, #4
	BRA NZ	L__getExternalInterruptEdge90
	GOTO	L_getExternalInterruptEdge34
L__getExternalInterruptEdge90:
	CP.B	W10, #5
	BRA NZ	L__getExternalInterruptEdge91
	GOTO	L_getExternalInterruptEdge35
L__getExternalInterruptEdge91:
	CP.B	W10, #6
	BRA NZ	L__getExternalInterruptEdge92
	GOTO	L_getExternalInterruptEdge36
L__getExternalInterruptEdge92:
	CP.B	W10, #8
	BRA NZ	L__getExternalInterruptEdge93
	GOTO	L_getExternalInterruptEdge37
L__getExternalInterruptEdge93:
	GOTO	L_getExternalInterruptEdge38
;dspic.c,116 :: 		}
L_end_getExternalInterruptEdge:
	RETURN
; end of _getExternalInterruptEdge

_clearExternalInterrupt:

;dspic.c,118 :: 		void clearExternalInterrupt(unsigned char device) {
;dspic.c,119 :: 		switch (device) {
	GOTO	L_clearExternalInterrupt39
;dspic.c,120 :: 		case INT0_DEVICE:
L_clearExternalInterrupt41:
;dspic.c,121 :: 		INT0_OCCURRED = FALSE;
	BCLR	IFS0, #0
;dspic.c,122 :: 		break;
	GOTO	L_clearExternalInterrupt40
;dspic.c,123 :: 		case INT1_DEVICE:
L_clearExternalInterrupt42:
;dspic.c,124 :: 		INT1_OCCURRED = FALSE;
	BCLR	IFS1, #0
;dspic.c,125 :: 		break;
	GOTO	L_clearExternalInterrupt40
;dspic.c,126 :: 		case INT2_DEVICE:
L_clearExternalInterrupt43:
;dspic.c,127 :: 		INT2_OCCURRED = FALSE;
	BCLR	IFS1, #7
;dspic.c,128 :: 		break;
	GOTO	L_clearExternalInterrupt40
;dspic.c,129 :: 		case INT4_DEVICE:
L_clearExternalInterrupt44:
;dspic.c,130 :: 		INT4_OCCURRED = FALSE;
	BCLR	IFS2, #5
;dspic.c,131 :: 		default:
L_clearExternalInterrupt45:
;dspic.c,132 :: 		break;
	GOTO	L_clearExternalInterrupt40
;dspic.c,133 :: 		}
L_clearExternalInterrupt39:
	CP.B	W10, #4
	BRA NZ	L__clearExternalInterrupt95
	GOTO	L_clearExternalInterrupt41
L__clearExternalInterrupt95:
	CP.B	W10, #5
	BRA NZ	L__clearExternalInterrupt96
	GOTO	L_clearExternalInterrupt42
L__clearExternalInterrupt96:
	CP.B	W10, #6
	BRA NZ	L__clearExternalInterrupt97
	GOTO	L_clearExternalInterrupt43
L__clearExternalInterrupt97:
	CP.B	W10, #8
	BRA NZ	L__clearExternalInterrupt98
	GOTO	L_clearExternalInterrupt44
L__clearExternalInterrupt98:
	GOTO	L_clearExternalInterrupt45
L_clearExternalInterrupt40:
;dspic.c,134 :: 		}
L_end_clearExternalInterrupt:
	RETURN
; end of _clearExternalInterrupt

_setTimer:

;dspic.c,136 :: 		void setTimer(unsigned char device, double timePeriod) {
;dspic.c,138 :: 		setInterruptPriority(device, MEDIUM_PRIORITY);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W11
	PUSH	W12
	MOV.B	#4, W11
	CALL	_setInterruptPriority
	POP	W12
	POP	W11
;dspic.c,140 :: 		prescalerIndex = getTimerPrescaler(timePeriod);
	PUSH	W11
	PUSH	W12
	PUSH	W10
	MOV	W11, W10
	MOV	W12, W11
	CALL	_getTimerPrescaler
	POP	W10
	POP	W12
	POP	W11
; prescalerIndex start address is: 2 (W1)
	MOV.B	W0, W1
;dspic.c,141 :: 		switch (device) {
	GOTO	L_setTimer46
;dspic.c,142 :: 		case TIMER1_DEVICE:
L_setTimer48:
;dspic.c,143 :: 		TIMER1_PERIOD = getTimerPeriod(timePeriod, prescalerIndex);
	MOV	W11, W10
	MOV	W12, W11
; prescalerIndex end address is: 2 (W1)
	MOV.B	W1, W12
	CALL	_getTimerPeriod
	MOV	WREG, PR1
;dspic.c,144 :: 		TIMER1_ENABLE_INTERRUPT = TRUE;
	BSET	IEC0bits, #3
;dspic.c,145 :: 		T1CON = 0x8004;
	MOV	#32772, W0
	MOV	WREG, T1CON
;dspic.c,148 :: 		break;
	GOTO	L_setTimer47
;dspic.c,149 :: 		case TIMER2_DEVICE:
L_setTimer49:
;dspic.c,150 :: 		TIMER2_PERIOD = getTimerPeriod(timePeriod, prescalerIndex);
; prescalerIndex start address is: 2 (W1)
	PUSH	W1
	MOV	W11, W10
	MOV	W12, W11
	MOV.B	W1, W12
	CALL	_getTimerPeriod
	POP	W1
	MOV	WREG, PR2
;dspic.c,151 :: 		TIMER2_ENABLE_INTERRUPT = TRUE;
	BSET	IEC0bits, #6
;dspic.c,152 :: 		TIMER2_ENABLE = TRUE;
	BSET	T2CONbits, #15
;dspic.c,153 :: 		TIMER2_PRESCALER = prescalerIndex;
	MOV.B	W1, W3
; prescalerIndex end address is: 2 (W1)
	MOV.B	#4, W0
	ZE	W3, W1
	SE	W0, W2
	SL	W1, W2, W3
	MOV	#lo_addr(T2CONbits), W0
	XOR.B	W3, [W0], W3
	MOV.B	#48, W0
	AND.B	W3, W0, W3
	MOV	#lo_addr(T2CONbits), W0
	XOR.B	W3, [W0], W3
	MOV	#lo_addr(T2CONbits), W0
	MOV.B	W3, [W0]
;dspic.c,154 :: 		break;
	GOTO	L_setTimer47
;dspic.c,155 :: 		case TIMER4_DEVICE:
L_setTimer50:
;dspic.c,156 :: 		TIMER4_PERIOD = getTimerPeriod(timePeriod, prescalerIndex);
; prescalerIndex start address is: 2 (W1)
	PUSH	W1
	MOV	W11, W10
	MOV	W12, W11
	MOV.B	W1, W12
	CALL	_getTimerPeriod
	POP	W1
	MOV	WREG, PR4
;dspic.c,157 :: 		TIMER4_ENABLE_INTERRUPT = TRUE;
	BSET	IEC1bits, #5
;dspic.c,158 :: 		TIMER4_ENABLE = TRUE;
	BSET	T4CONbits, #15
;dspic.c,159 :: 		TIMER4_PRESCALER = prescalerIndex;
	MOV.B	W1, W3
; prescalerIndex end address is: 2 (W1)
	MOV.B	#4, W0
	ZE	W3, W1
	SE	W0, W2
	SL	W1, W2, W3
	MOV	#lo_addr(T4CONbits), W0
	XOR.B	W3, [W0], W3
	MOV.B	#48, W0
	AND.B	W3, W0, W3
	MOV	#lo_addr(T4CONbits), W0
	XOR.B	W3, [W0], W3
	MOV	#lo_addr(T4CONbits), W0
	MOV.B	W3, [W0]
;dspic.c,160 :: 		break;
	GOTO	L_setTimer47
;dspic.c,161 :: 		}
L_setTimer46:
; prescalerIndex start address is: 2 (W1)
	CP.B	W10, #1
	BRA NZ	L__setTimer100
	GOTO	L_setTimer48
L__setTimer100:
	CP.B	W10, #2
	BRA NZ	L__setTimer101
	GOTO	L_setTimer49
L__setTimer101:
	CP.B	W10, #3
	BRA NZ	L__setTimer102
	GOTO	L_setTimer50
L__setTimer102:
; prescalerIndex end address is: 2 (W1)
L_setTimer47:
;dspic.c,162 :: 		}
L_end_setTimer:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _setTimer

_clearTimer:

;dspic.c,164 :: 		void clearTimer(unsigned char device) {
;dspic.c,165 :: 		switch (device) {
	GOTO	L_clearTimer51
;dspic.c,166 :: 		case TIMER1_DEVICE:
L_clearTimer53:
;dspic.c,167 :: 		TIMER1_OCCURRED = FALSE;
	BCLR	IFS0bits, #3
;dspic.c,168 :: 		break;
	GOTO	L_clearTimer52
;dspic.c,169 :: 		case TIMER2_DEVICE:
L_clearTimer54:
;dspic.c,170 :: 		TIMER2_OCCURRED = FALSE;
	BCLR	IFS0bits, #6
;dspic.c,171 :: 		break;
	GOTO	L_clearTimer52
;dspic.c,172 :: 		case TIMER4_DEVICE:
L_clearTimer55:
;dspic.c,173 :: 		TIMER4_OCCURRED = FALSE;
	BCLR	IFS1bits, #5
;dspic.c,174 :: 		break;
	GOTO	L_clearTimer52
;dspic.c,175 :: 		}
L_clearTimer51:
	CP.B	W10, #1
	BRA NZ	L__clearTimer104
	GOTO	L_clearTimer53
L__clearTimer104:
	CP.B	W10, #2
	BRA NZ	L__clearTimer105
	GOTO	L_clearTimer54
L__clearTimer105:
	CP.B	W10, #3
	BRA NZ	L__clearTimer106
	GOTO	L_clearTimer55
L__clearTimer106:
L_clearTimer52:
;dspic.c,176 :: 		}
L_end_clearTimer:
	RETURN
; end of _clearTimer

_turnOnTimer:

;dspic.c,178 :: 		void turnOnTimer(unsigned char device) {
;dspic.c,179 :: 		switch (device) {
	GOTO	L_turnOnTimer56
;dspic.c,180 :: 		case TIMER1_DEVICE:
L_turnOnTimer58:
;dspic.c,181 :: 		TIMER1_ENABLE = TRUE;
	BSET	T1CONbits, #15
;dspic.c,182 :: 		break;
	GOTO	L_turnOnTimer57
;dspic.c,183 :: 		case TIMER2_DEVICE:
L_turnOnTimer59:
;dspic.c,184 :: 		TIMER2_ENABLE = TRUE;
	BSET	T2CONbits, #15
;dspic.c,185 :: 		break;
	GOTO	L_turnOnTimer57
;dspic.c,186 :: 		case TIMER4_DEVICE:
L_turnOnTimer60:
;dspic.c,187 :: 		TIMER4_ENABLE = TRUE;
	BSET	T4CONbits, #15
;dspic.c,188 :: 		break;
	GOTO	L_turnOnTimer57
;dspic.c,189 :: 		}
L_turnOnTimer56:
	CP.B	W10, #1
	BRA NZ	L__turnOnTimer108
	GOTO	L_turnOnTimer58
L__turnOnTimer108:
	CP.B	W10, #2
	BRA NZ	L__turnOnTimer109
	GOTO	L_turnOnTimer59
L__turnOnTimer109:
	CP.B	W10, #3
	BRA NZ	L__turnOnTimer110
	GOTO	L_turnOnTimer60
L__turnOnTimer110:
L_turnOnTimer57:
;dspic.c,190 :: 		}
L_end_turnOnTimer:
	RETURN
; end of _turnOnTimer

_turnOffTimer:

;dspic.c,192 :: 		void turnOffTimer(unsigned char device) {
;dspic.c,193 :: 		switch (device) {
	GOTO	L_turnOffTimer61
;dspic.c,194 :: 		case TIMER1_DEVICE:
L_turnOffTimer63:
;dspic.c,195 :: 		TIMER1_ENABLE = FALSE;
	BCLR	T1CONbits, #15
;dspic.c,196 :: 		break;
	GOTO	L_turnOffTimer62
;dspic.c,197 :: 		case TIMER2_DEVICE:
L_turnOffTimer64:
;dspic.c,198 :: 		TIMER2_ENABLE = FALSE;
	BCLR	T2CONbits, #15
;dspic.c,199 :: 		break;
	GOTO	L_turnOffTimer62
;dspic.c,200 :: 		case TIMER4_DEVICE:
L_turnOffTimer65:
;dspic.c,201 :: 		TIMER4_ENABLE = FALSE;
	BCLR	T4CONbits, #15
;dspic.c,202 :: 		break;
	GOTO	L_turnOffTimer62
;dspic.c,203 :: 		}
L_turnOffTimer61:
	CP.B	W10, #1
	BRA NZ	L__turnOffTimer112
	GOTO	L_turnOffTimer63
L__turnOffTimer112:
	CP.B	W10, #2
	BRA NZ	L__turnOffTimer113
	GOTO	L_turnOffTimer64
L__turnOffTimer113:
	CP.B	W10, #3
	BRA NZ	L__turnOffTimer114
	GOTO	L_turnOffTimer65
L__turnOffTimer114:
L_turnOffTimer62:
;dspic.c,204 :: 		}
L_end_turnOffTimer:
	RETURN
; end of _turnOffTimer

_getTimerPeriod:
	LNK	#8

;dspic.c,206 :: 		unsigned int getTimerPeriod(double timePeriod, unsigned char prescalerIndex) {
;dspic.c,207 :: 		return (unsigned int) ((timePeriod * 1000000) / (INSTRUCTION_PERIOD * PRESCALER_VALUES[prescalerIndex]));
	PUSH	W12
	MOV.D	W10, W0
	MOV	#9216, W2
	MOV	#18804, W3
	CALL	__Mul_FP
	POP	W12
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	ZE	W12, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRESCALER_VALUES), W0
	ADD	W0, W1, W2
	MOV	[W2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	[W14+4], W0
	MOV	[W14+6], W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	POP.D	W2
	CALL	__Float2Longint
;dspic.c,208 :: 		}
L_end_getTimerPeriod:
	ULNK
	RETURN
; end of _getTimerPeriod

_getTimerPrescaler:

;dspic.c,210 :: 		unsigned char getTimerPrescaler(double timePeriod) {
;dspic.c,213 :: 		exactTimerPrescaler = getExactTimerPrescaler(timePeriod);
	CALL	_getExactTimerPrescaler
; exactTimerPrescaler start address is: 8 (W4)
	MOV.D	W0, W4
;dspic.c,214 :: 		for (i = 0; i < sizeof(PRESCALER_VALUES) / 2; i += 1) {
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
L_getTimerPrescaler66:
; i start address is: 6 (W3)
; exactTimerPrescaler start address is: 8 (W4)
; exactTimerPrescaler end address is: 8 (W4)
	CP.B	W3, #4
	BRA LTU	L__getTimerPrescaler117
	GOTO	L_getTimerPrescaler67
L__getTimerPrescaler117:
; exactTimerPrescaler end address is: 8 (W4)
;dspic.c,215 :: 		if ((int) exactTimerPrescaler < PRESCALER_VALUES[i]) {
; exactTimerPrescaler start address is: 8 (W4)
	PUSH.D	W4
	PUSH	W3
	PUSH.D	W10
	MOV.D	W4, W0
	CALL	__Float2Longint
	POP.D	W10
	POP	W3
	POP.D	W4
	ZE	W3, W1
	SL	W1, #1, W2
	MOV	#lo_addr(_PRESCALER_VALUES), W1
	ADD	W1, W2, W2
	MOV	#___Lib_System_DefaultPage, W1
	MOV	W1, 52
	MOV	[W2], W1
	CP	W0, W1
	BRA LTU	L__getTimerPrescaler118
	GOTO	L_getTimerPrescaler69
L__getTimerPrescaler118:
; exactTimerPrescaler end address is: 8 (W4)
;dspic.c,216 :: 		return i;
	MOV.B	W3, W0
; i end address is: 6 (W3)
	GOTO	L_end_getTimerPrescaler
;dspic.c,217 :: 		}
L_getTimerPrescaler69:
;dspic.c,214 :: 		for (i = 0; i < sizeof(PRESCALER_VALUES) / 2; i += 1) {
; i start address is: 0 (W0)
; exactTimerPrescaler start address is: 8 (W4)
; i start address is: 6 (W3)
	ADD.B	W3, #1, W0
; i end address is: 6 (W3)
;dspic.c,218 :: 		}
; exactTimerPrescaler end address is: 8 (W4)
; i end address is: 0 (W0)
	MOV.B	W0, W3
	GOTO	L_getTimerPrescaler66
L_getTimerPrescaler67:
;dspic.c,219 :: 		i -= 1;
; i start address is: 6 (W3)
	ZE	W3, W0
; i end address is: 6 (W3)
	DEC	W0
;dspic.c,221 :: 		return i;
;dspic.c,222 :: 		}
L_end_getTimerPrescaler:
	RETURN
; end of _getTimerPrescaler

_getExactTimerPrescaler:

;dspic.c,224 :: 		double getExactTimerPrescaler(double timePeriod) {
;dspic.c,225 :: 		return (timePeriod * 1000000) / (INSTRUCTION_PERIOD * MAX_TIMER_PERIOD_VALUE);
	MOV.D	W10, W0
	MOV	#9216, W2
	MOV	#18804, W3
	CALL	__Mul_FP
	MOV	#52224, W2
	MOV	#17740, W3
	CALL	__Div_FP
;dspic.c,226 :: 		}
L_end_getExactTimerPrescaler:
	RETURN
; end of _getExactTimerPrescaler

_setupAnalogSampling:

;dspic.c,228 :: 		void setupAnalogSampling(void) {
;dspic.c,229 :: 		ANALOG_CONVERSION_TRIGGER_SOURCE = ACTS_AUTOMATIC;
	PUSH	W10
	MOV	#lo_addr(ADCON1bits), W0
	MOV.B	[W0], W1
	MOV.B	#224, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	MOV.B	W1, [W0]
;dspic.c,230 :: 		ANALOG_DATA_OUTPUT_FORMAT = ADOF_UNSIGNED_INTEGER;
	MOV	ADCON1bits, W1
	MOV	#64767, W0
	AND	W1, W0, W0
	MOV	WREG, ADCON1bits
;dspic.c,231 :: 		ANALOG_IDLE_ENABLE = FALSE;
	BCLR	ADCON1bits, #13
;dspic.c,232 :: 		ANALOG_CH0_SCAN_ENABLE = TRUE;
	BSET	ADCON2bits, #10
;dspic.c,233 :: 		ANALOG_BUFFER_SIZE = ABS_16BIT;
	BCLR	ADCON2bits, #1
;dspic.c,234 :: 		ANALOG_ENABLE_ALTERNATING_MULTIPLEXER = FALSE;
	BCLR	ADCON2bits, #0
;dspic.c,235 :: 		ANALOG_CLOCK_SOURCE = ACS_EXTERNAL;
	BCLR	ADCON3bits, #7
;dspic.c,236 :: 		ANALOG_CHANNEL_B_NEGATIVE_INPUT = ACNI_VREF;
	BCLR	ADCHSbits, #12
;dspic.c,237 :: 		ANALOG_CHANNEL_A_NEGATIVE_INPUT = ACNI_VREF;
	BCLR	ADCHSbits, #4
;dspic.c,238 :: 		ANALOG_CHANNEL_B_POSITIVE_INPUT = 0;
	MOV	ADCHSbits, W1
	MOV	#61695, W0
	AND	W1, W0, W0
	MOV	WREG, ADCHSbits
;dspic.c,239 :: 		ANALOG_CHANNEL_A_POSITIVE_INPUT = 0;
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	[W0], W1
	MOV.B	#240, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;dspic.c,242 :: 		ANALOG_CLOCK_CONVERSION = getMinimumAnalogClockConversion();
	CALL	_getMinimumAnalogClockConversion
	MOV.B	W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCON3bits), W0
	MOV.B	W1, [W0]
;dspic.c,243 :: 		ANALOG_AUTOMATIC_SAMPLING_TADS_INTERVAL = 1;
	MOV	#256, W0
	MOV	W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR	W1, [W0], W1
	MOV	#7936, W0
	AND	W1, W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR	W1, [W0], W1
	MOV	W1, ADCON3bits
;dspic.c,245 :: 		ANALOG_MODE_PORT = 0b1111111111111111; //All analog inputs are disabled
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;dspic.c,246 :: 		ANALOG_SCAN_PORT = 0; //Skipping pin scan
	CLR	ADCSSL
;dspic.c,248 :: 		setAutomaticSampling();
	CALL	_setAutomaticSampling
;dspic.c,249 :: 		setAnalogVoltageReference(AVR_AVDD_AVSS);
	CLR	W10
	CALL	_setAnalogVoltageReference
;dspic.c,250 :: 		unsetAnalogInterrupt();
	CALL	_unsetAnalogInterrupt
;dspic.c,251 :: 		startSampling();
	CALL	_startSampling
;dspic.c,252 :: 		}
L_end_setupAnalogSampling:
	POP	W10
	RETURN
; end of _setupAnalogSampling

_turnOnAnalogModule:

;dspic.c,254 :: 		void turnOnAnalogModule() {
;dspic.c,255 :: 		ANALOG_SAMPLING_ENABLE = TRUE;
	BSET	ADCON1bits, #15
;dspic.c,256 :: 		}
L_end_turnOnAnalogModule:
	RETURN
; end of _turnOnAnalogModule

_turnOffAnalogModule:

;dspic.c,258 :: 		void turnOffAnalogModule() {
;dspic.c,259 :: 		ANALOG_SAMPLING_ENABLE = FALSE;
	BCLR	ADCON1bits, #15
;dspic.c,260 :: 		}
L_end_turnOffAnalogModule:
	RETURN
; end of _turnOffAnalogModule

_startSampling:

;dspic.c,262 :: 		void startSampling(void) {
;dspic.c,263 :: 		ANALOG_SAMPLING_STATUS = TRUE;
	BSET	ADCON1bits, #1
;dspic.c,264 :: 		}
L_end_startSampling:
	RETURN
; end of _startSampling

_getAnalogValue:

;dspic.c,266 :: 		unsigned int getAnalogValue(void) {
;dspic.c,267 :: 		return ANALOG_BUFFER0;
	MOV	ADCBUF0, WREG
;dspic.c,268 :: 		}
L_end_getAnalogValue:
	RETURN
; end of _getAnalogValue

_setAnalogPIN:

;dspic.c,270 :: 		void setAnalogPIN(unsigned char pin) {
;dspic.c,271 :: 		ANALOG_MODE_PORT = ANALOG_MODE_PORT & ~(int) (TRUE << pin);
	ZE	W10, W1
	MOV	#1, W0
	SL	W0, W1, W2
	MOV	W2, W0
	COM	W0, W1
	MOV	#lo_addr(ADPCFG), W0
	AND	W1, [W0], [W0]
;dspic.c,272 :: 		ANALOG_SCAN_PORT = ANALOG_SCAN_PORT | (TRUE << pin);
	MOV	#lo_addr(ADCSSL), W0
	IOR	W2, [W0], [W0]
;dspic.c,273 :: 		}
L_end_setAnalogPIN:
	RETURN
; end of _setAnalogPIN

_unsetAnalogPIN:

;dspic.c,275 :: 		void unsetAnalogPIN(unsigned char pin) {
;dspic.c,276 :: 		ANALOG_MODE_PORT = ANALOG_MODE_PORT | (TRUE << pin);
	ZE	W10, W1
	MOV	#1, W0
	SL	W0, W1, W1
	MOV	#lo_addr(ADPCFG), W0
	IOR	W1, [W0], [W0]
;dspic.c,277 :: 		ANALOG_SCAN_PORT = ANALOG_SCAN_PORT & ~(int) (TRUE << pin);
	MOV	W1, W0
	COM	W0, W1
	MOV	#lo_addr(ADCSSL), W0
	AND	W1, [W0], [W0]
;dspic.c,278 :: 		}
L_end_unsetAnalogPIN:
	RETURN
; end of _unsetAnalogPIN

_setAnalogInterrupt:

;dspic.c,280 :: 		void setAnalogInterrupt(void) {
;dspic.c,281 :: 		clearAnalogInterrupt();
	CALL	_clearAnalogInterrupt
;dspic.c,282 :: 		ANALOG_INTERRUPT_ENABLE = TRUE;
	BSET	IEC0bits, #11
;dspic.c,283 :: 		}
L_end_setAnalogInterrupt:
	RETURN
; end of _setAnalogInterrupt

_unsetAnalogInterrupt:

;dspic.c,285 :: 		void unsetAnalogInterrupt(void) {
;dspic.c,286 :: 		clearAnalogInterrupt();
	CALL	_clearAnalogInterrupt
;dspic.c,287 :: 		ANALOG_INTERRUPT_ENABLE = FALSE;
	BCLR	IEC0bits, #11
;dspic.c,288 :: 		}
L_end_unsetAnalogInterrupt:
	RETURN
; end of _unsetAnalogInterrupt

_clearAnalogInterrupt:

;dspic.c,290 :: 		void clearAnalogInterrupt(void) {
;dspic.c,291 :: 		ANALOG_INTERRUPT_OCCURRED = FALSE;
	BCLR	IFS0bits, #11
;dspic.c,292 :: 		}
L_end_clearAnalogInterrupt:
	RETURN
; end of _clearAnalogInterrupt

_setAutomaticSampling:

;dspic.c,294 :: 		void setAutomaticSampling(void) {
;dspic.c,295 :: 		AUTOMATIC_SAMPLING = TRUE;
	BSET	ADCON1bits, #2
;dspic.c,296 :: 		}
L_end_setAutomaticSampling:
	RETURN
; end of _setAutomaticSampling

_unsetAutomaticSampling:

;dspic.c,298 :: 		void unsetAutomaticSampling(void) {
;dspic.c,299 :: 		AUTOMATIC_SAMPLING = FALSE;
	BCLR	ADCON1bits, #2
;dspic.c,300 :: 		}
L_end_unsetAutomaticSampling:
	RETURN
; end of _unsetAutomaticSampling

_setAnalogVoltageReference:

;dspic.c,302 :: 		void setAnalogVoltageReference(unsigned char mode) {
;dspic.c,303 :: 		ANALOG_VOLTAGE_REFERENCE = mode;
	ZE	W10, W0
	MOV	W0, W1
	MOV.B	#13, W0
	SE	W0, W0
	SL	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	XOR	W1, [W0], W1
	MOV	#57344, W0
	AND	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	XOR	W1, [W0], W1
	MOV	W1, ADCON2bits
;dspic.c,304 :: 		}
L_end_setAnalogVoltageReference:
	RETURN
; end of _setAnalogVoltageReference

_setAnalogDataOutputFormat:

;dspic.c,306 :: 		void setAnalogDataOutputFormat(unsigned char adof) {
;dspic.c,307 :: 		ANALOG_DATA_OUTPUT_FORMAT = adof;
	ZE	W10, W0
	MOV	W0, W1
	MOV.B	#8, W0
	SE	W0, W0
	SL	W1, W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	XOR	W1, [W0], W1
	MOV	#768, W0
	AND	W1, W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	XOR	W1, [W0], W1
	MOV	W1, ADCON1bits
;dspic.c,308 :: 		}
L_end_setAnalogDataOutputFormat:
	RETURN
; end of _setAnalogDataOutputFormat

_getMinimumAnalogClockConversion:

;dspic.c,310 :: 		int getMinimumAnalogClockConversion(void) {
;dspic.c,311 :: 		return (int) ((MINIMUM_TAD_PERIOD * OSC_FREQ_MHZ) / 500.0);
	MOV	#24, W0
;dspic.c,312 :: 		}
L_end_getMinimumAnalogClockConversion:
	RETURN
; end of _getMinimumAnalogClockConversion
