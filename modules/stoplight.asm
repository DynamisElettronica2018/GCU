
_StopLight_init:

;stoplight.c,11 :: 		void StopLight_init(void) {
;stoplight.c,12 :: 		StopLight_setupPWM();
	CALL	_StopLight_setupPWM
;stoplight.c,13 :: 		}
L_end_StopLight_init:
	RETURN
; end of _StopLight_init

_StopLight_setupPWM:

;stoplight.c,15 :: 		void StopLight_setupPWM(void) {
;stoplight.c,16 :: 		OC7CON = 0x6; //PWM on Timer 2
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#6, W0
	MOV	WREG, OC7CON
;stoplight.c,17 :: 		STOPLIGHT_PWM_PERIOD_VALUE = getTimerPeriod(STOPLIGHT_PWM_PERIOD, TIMER2_PRESCALER);
	MOV	#lo_addr(T2CONbits), W0
	MOV.B	[W0], W0
	MOV.B	W0, W1
	MOV.B	#48, W0
	AND.B	W1, W0, W1
	ZE	W1, W0
	LSR	W0, #4, W1
	MOV.B	W1, W12
	MOV	#55050, W10
	MOV	#15523, W11
	CALL	_getTimerPeriod
	MOV	W0, _STOPLIGHT_PWM_PERIOD_VALUE
;stoplight.c,19 :: 		(STOPLIGHT_PWM_PERCENTAGE / 100.0));
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _STOPLIGHT_PWM_VALUE
;stoplight.c,20 :: 		OC7R = STOPLIGHT_PWM_VALUE;
	MOV	WREG, OC7R
;stoplight.c,21 :: 		OC7RS = STOPLIGHT_PWM_VALUE;
	MOV	WREG, OC7RS
;stoplight.c,22 :: 		}
L_end_StopLight_setupPWM:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _StopLight_setupPWM

_StopLight_setBrightness:
	LNK	#4

;stoplight.c,24 :: 		void StopLight_setBrightness(unsigned char percentage) {
;stoplight.c,26 :: 		pwmValue = (unsigned int) (STOPLIGHT_PWM_PERIOD_VALUE * (percentage / 100.0));
	ZE	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Div_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_STOPLIGHT_PWM_PERIOD_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Mul_FP
	CALL	__Float2Longint
; pwmValue start address is: 4 (W2)
	MOV	W0, W2
;stoplight.c,27 :: 		if (pwmValue > 100) {
	MOV	#100, W1
	CP	W0, W1
	BRA GTU	L__StopLight_setBrightness7
	GOTO	L_StopLight_setBrightness0
L__StopLight_setBrightness7:
; pwmValue end address is: 4 (W2)
;stoplight.c,28 :: 		pwmValue = (unsigned int) STOPLIGHT_PWM_PERIOD_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_STOPLIGHT_PWM_PERIOD_VALUE, W0
;stoplight.c,29 :: 		} else if (pwmValue < 0) {
; pwmValue end address is: 0 (W0)
	GOTO	L_StopLight_setBrightness1
L_StopLight_setBrightness0:
; pwmValue start address is: 4 (W2)
	CP	W2, #0
	BRA LTU	L__StopLight_setBrightness8
	GOTO	L__StopLight_setBrightness3
L__StopLight_setBrightness8:
; pwmValue end address is: 4 (W2)
;stoplight.c,30 :: 		pwmValue = 1;
; pwmValue start address is: 0 (W0)
	MOV	#1, W0
; pwmValue end address is: 0 (W0)
;stoplight.c,31 :: 		}
	GOTO	L_StopLight_setBrightness2
L__StopLight_setBrightness3:
;stoplight.c,29 :: 		} else if (pwmValue < 0) {
	MOV	W2, W0
;stoplight.c,31 :: 		}
L_StopLight_setBrightness2:
; pwmValue start address is: 0 (W0)
; pwmValue end address is: 0 (W0)
L_StopLight_setBrightness1:
;stoplight.c,32 :: 		OC7RS = pwmValue;
; pwmValue start address is: 0 (W0)
	MOV	WREG, OC7RS
; pwmValue end address is: 0 (W0)
;stoplight.c,33 :: 		}
L_end_StopLight_setBrightness:
	ULNK
	RETURN
; end of _StopLight_setBrightness
