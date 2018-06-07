
_timer4_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;buzzer.c,9 :: 		onTimer4Interrupt{
;buzzer.c,10 :: 		clearTimer4();
	BCLR	IFS1bits, #5
;buzzer.c,11 :: 		Buzzer_tick();
	CALL	_Buzzer_tick
;buzzer.c,12 :: 		}
L_end_timer4_interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer4_interrupt

_Buzzer_init:

;buzzer.c,14 :: 		void Buzzer_init(void) {
;buzzer.c,15 :: 		BUZZER_Direction = OUTPUT;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	BCLR	TRISG13_bit, BitPos(TRISG13_bit+0)
;buzzer.c,16 :: 		BUZZER_Pin = 0;
	BCLR	RG13_bit, BitPos(RG13_bit+0)
;buzzer.c,17 :: 		setTimer(TIMER4_DEVICE, BUZZER_TIMER_PERIOD);
	MOV	#4719, W11
	MOV	#14851, W12
	MOV.B	#3, W10
	CALL	_setTimer
;buzzer.c,18 :: 		setInterruptPriority(TIMER4_DEVICE, LOW_PRIORITY);
	MOV.B	#5, W11
	MOV.B	#3, W10
	CALL	_setInterruptPriority
;buzzer.c,19 :: 		buzzer_bipTicks = (int)(BUZZER_BIP_TIME / BUZZER_TIMER_PERIOD);
	MOV	#1999, W0
	MOV	W0, _buzzer_bipTicks
;buzzer.c,20 :: 		}
L_end_Buzzer_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _Buzzer_init

_Buzzer_tick:

;buzzer.c,22 :: 		void Buzzer_tick(void) {
;buzzer.c,23 :: 		if (buzzer_ticks > 0) {
	MOV	_buzzer_ticks, W0
	CP	W0, #0
	BRA GTU	L__Buzzer_tick5
	GOTO	L_Buzzer_tick0
L__Buzzer_tick5:
;buzzer.c,24 :: 		buzzer_ticks -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_buzzer_ticks), W0
	SUBR	W1, [W0], [W0]
;buzzer.c,25 :: 		BUZZER_Pin = !BUZZER_Pin;
	BTG	RG13_bit, BitPos(RG13_bit+0)
;buzzer.c,26 :: 		}
	GOTO	L_Buzzer_tick1
L_Buzzer_tick0:
;buzzer.c,28 :: 		BUZZER_Pin = 0;
	BCLR	RG13_bit, BitPos(RG13_bit+0)
L_Buzzer_tick1:
;buzzer.c,29 :: 		}
L_end_Buzzer_tick:
	RETURN
; end of _Buzzer_tick

_Buzzer_Bip:

;buzzer.c,31 :: 		void Buzzer_Bip(void) {
;buzzer.c,32 :: 		buzzer_ticks = buzzer_bipTicks;
	MOV	_buzzer_bipTicks, W0
	MOV	W0, _buzzer_ticks
;buzzer.c,33 :: 		}
L_end_Buzzer_Bip:
	RETURN
; end of _Buzzer_Bip
