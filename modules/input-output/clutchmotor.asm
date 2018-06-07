
_timer2_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;clutchmotor.c,12 :: 		onTimer2Interrupt{
;clutchmotor.c,13 :: 		clearTimer2();
	BCLR	IFS0bits, #6
;clutchmotor.c,14 :: 		}
L_end_timer2_interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer2_interrupt

_ClutchMotor_init:

;clutchmotor.c,16 :: 		void ClutchMotor_init(void) {
;clutchmotor.c,17 :: 		setTimer(TIMER2_DEVICE, CLUTCHMOTOR_PWM_PERIOD);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#55050, W11
	MOV	#15523, W12
	MOV.B	#2, W10
	CALL	_setTimer
;clutchmotor.c,18 :: 		ClutchMotor_setupPWM();
	CALL	_ClutchMotor_setupPWM
;clutchmotor.c,19 :: 		}
L_end_ClutchMotor_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _ClutchMotor_init

_ClutchMotor_setupPWM:

;clutchmotor.c,21 :: 		void ClutchMotor_setupPWM(void) {
;clutchmotor.c,22 :: 		OC8CON = 0x6; //PWM on Timer 2
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#6, W0
	MOV	WREG, OC8CON
;clutchmotor.c,23 :: 		CLUTCHMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(CLUTCHMOTOR_PWM_PERIOD, TIMER2_PRESCALER);
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
	MOV	W0, _CLUTCHMOTOR_PWM_PERIOD_VALUE
;clutchmotor.c,26 :: 		(CLUTCHMOTOR_MAX_PWM_PERCENTAGE / 100.0));
	CLR	W1
	CALL	__Long2Float
	MOV	#18350, W2
	MOV	#15841, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _CLUTCHMOTOR_PWM_MAX_VALUE
;clutchmotor.c,28 :: 		(CLUTCHMOTOR_MIN_PWM_PERCENTAGE / 100.0));
	MOV	_CLUTCHMOTOR_PWM_PERIOD_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _CLUTCHMOTOR_PWM_MIN_VALUE
;clutchmotor.c,29 :: 		CLUTCHMOTOR_PERCENTAGE_STEP = (CLUTCHMOTOR_PWM_MAX_VALUE - CLUTCHMOTOR_PWM_MIN_VALUE) / 100.0;
	MOV	#lo_addr(_CLUTCHMOTOR_PWM_MAX_VALUE), W1
	SUBR	W0, [W1], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Div_FP
	MOV	W0, _CLUTCHMOTOR_PERCENTAGE_STEP
	MOV	W1, _CLUTCHMOTOR_PERCENTAGE_STEP+2
;clutchmotor.c,30 :: 		OC8R = CLUTCHMOTOR_PWM_MIN_VALUE;
	MOV	_CLUTCHMOTOR_PWM_MIN_VALUE, W0
	MOV	WREG, OC8R
;clutchmotor.c,31 :: 		ClutchMotor_setPosition(100);
	MOV.B	#100, W10
	CALL	_ClutchMotor_setPosition
;clutchmotor.c,32 :: 		}
L_end_ClutchMotor_setupPWM:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _ClutchMotor_setupPWM

_ClutchMotor_setPosition:
	LNK	#4

;clutchmotor.c,34 :: 		void ClutchMotor_setPosition(unsigned char percentage) {
;clutchmotor.c,36 :: 		pwmValue = (unsigned int) ((percentage * CLUTCHMOTOR_PERCENTAGE_STEP) + CLUTCHMOTOR_PWM_MIN_VALUE);
	ZE	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	_CLUTCHMOTOR_PERCENTAGE_STEP, W2
	MOV	_CLUTCHMOTOR_PERCENTAGE_STEP+2, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_CLUTCHMOTOR_PWM_MIN_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
; pwmValue start address is: 4 (W2)
	MOV	W0, W2
;clutchmotor.c,37 :: 		if (pwmValue > CLUTCHMOTOR_PWM_MAX_VALUE) {
	MOV	#lo_addr(_CLUTCHMOTOR_PWM_MAX_VALUE), W1
	CP	W0, [W1]
	BRA GTU	L__ClutchMotor_setPosition8
	GOTO	L_ClutchMotor_setPosition0
L__ClutchMotor_setPosition8:
; pwmValue end address is: 4 (W2)
;clutchmotor.c,38 :: 		pwmValue = CLUTCHMOTOR_PWM_MAX_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_CLUTCHMOTOR_PWM_MAX_VALUE, W0
;clutchmotor.c,39 :: 		} else if (pwmValue < CLUTCHMOTOR_PWM_MIN_VALUE) {
; pwmValue end address is: 0 (W0)
	GOTO	L_ClutchMotor_setPosition1
L_ClutchMotor_setPosition0:
; pwmValue start address is: 4 (W2)
	MOV	#lo_addr(_CLUTCHMOTOR_PWM_MIN_VALUE), W0
	CP	W2, [W0]
	BRA LTU	L__ClutchMotor_setPosition9
	GOTO	L__ClutchMotor_setPosition3
L__ClutchMotor_setPosition9:
; pwmValue end address is: 4 (W2)
;clutchmotor.c,40 :: 		pwmValue = CLUTCHMOTOR_PWM_MIN_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_CLUTCHMOTOR_PWM_MIN_VALUE, W0
; pwmValue end address is: 0 (W0)
;clutchmotor.c,41 :: 		}
	GOTO	L_ClutchMotor_setPosition2
L__ClutchMotor_setPosition3:
;clutchmotor.c,39 :: 		} else if (pwmValue < CLUTCHMOTOR_PWM_MIN_VALUE) {
	MOV	W2, W0
;clutchmotor.c,41 :: 		}
L_ClutchMotor_setPosition2:
; pwmValue start address is: 0 (W0)
; pwmValue end address is: 0 (W0)
L_ClutchMotor_setPosition1:
;clutchmotor.c,42 :: 		OC8RS = pwmValue;
; pwmValue start address is: 0 (W0)
	MOV	WREG, OC8RS
; pwmValue end address is: 0 (W0)
;clutchmotor.c,43 :: 		}
L_end_ClutchMotor_setPosition:
	ULNK
	RETURN
; end of _ClutchMotor_setPosition
