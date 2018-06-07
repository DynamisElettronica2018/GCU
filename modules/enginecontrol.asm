
_EngineControl_init:

;enginecontrol.c,10 :: 		void EngineControl_init(void) {
;enginecontrol.c,11 :: 		ENGINE_STARTER_Direction = OUTPUT;
	BCLR	TRISD, #5
;enginecontrol.c,12 :: 		ENGINE_KILL_Direction = OUTPUT;
	BCLR	TRISD, #1
;enginecontrol.c,13 :: 		ENGINE_KEY_Direction = OUTPUT;
	BCLR	TRISG, #15
;enginecontrol.c,15 :: 		ENGINE_KILL = ENGINE_NOT_KILLED;
	BSET	LATD1_bit, BitPos(LATD1_bit+0)
;enginecontrol.c,16 :: 		ENGINE_KEY = ENGINE_KEY_ON;
	BSET	RG15_bit, BitPos(RG15_bit+0)
;enginecontrol.c,17 :: 		engineControl_isChecking = FALSE;
	MOV	#lo_addr(_engineControl_isChecking), W1
	CLR	W0
	MOV.B	W0, [W1]
;enginecontrol.c,18 :: 		EngineControl_resetStartCheck();
	CALL	_EngineControl_resetStartCheck
;enginecontrol.c,19 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;enginecontrol.c,20 :: 		}
L_end_EngineControl_init:
	RETURN
; end of _EngineControl_init

_EngineControl_keyOn:

;enginecontrol.c,23 :: 		void EngineControl_keyOn(void) {
;enginecontrol.c,24 :: 		ENGINE_KEY = ENGINE_KEY_ON;
	BSET	RG15_bit, BitPos(RG15_bit+0)
;enginecontrol.c,25 :: 		}
L_end_EngineControl_keyOn:
	RETURN
; end of _EngineControl_keyOn

_EngineControl_keyOff:

;enginecontrol.c,28 :: 		void EngineControl_keyOff(void) {
;enginecontrol.c,29 :: 		ENGINE_KEY = ENGINE_KEY_OFF;
	BCLR	RG15_bit, BitPos(RG15_bit+0)
;enginecontrol.c,30 :: 		}
L_end_EngineControl_keyOff:
	RETURN
; end of _EngineControl_keyOff

_EngineControl_start:

;enginecontrol.c,32 :: 		void EngineControl_start(void) {
;enginecontrol.c,33 :: 		dSignalLed_set(DSIGNAL_LED_RG12);
	PUSH	W10
	MOV.B	#1, W10
	CALL	_dSignalLed_set
;enginecontrol.c,34 :: 		ENGINE_STARTER = TRUE;
	BSET	LATD5_bit, BitPos(LATD5_bit+0)
;enginecontrol.c,35 :: 		}
L_end_EngineControl_start:
	POP	W10
	RETURN
; end of _EngineControl_start

_EngineControl_stop:

;enginecontrol.c,37 :: 		void EngineControl_stop(void) {
;enginecontrol.c,38 :: 		dSignalLed_unset(DSIGNAL_LED_RG12);
	PUSH	W10
	MOV.B	#1, W10
	CALL	_dSignalLed_unset
;enginecontrol.c,39 :: 		ENGINE_STARTER = FALSE;
	BCLR	LATD5_bit, BitPos(LATD5_bit+0)
;enginecontrol.c,40 :: 		}
L_end_EngineControl_stop:
	POP	W10
	RETURN
; end of _EngineControl_stop

_EngineControl_resetStartCheck:

;enginecontrol.c,42 :: 		void EngineControl_resetStartCheck(void) {
;enginecontrol.c,43 :: 		engineControl_startCheckCounter = 0;
	MOV	#lo_addr(_engineControl_startCheckCounter), W1
	CLR	W0
	MOV.B	W0, [W1]
;enginecontrol.c,44 :: 		}
L_end_EngineControl_resetStartCheck:
	RETURN
; end of _EngineControl_resetStartCheck

_EngineControl_isStarting:

;enginecontrol.c,46 :: 		char EngineControl_isStarting(void) {
;enginecontrol.c,47 :: 		if (engineControl_startCheckCounter < ENGINE_CONTROL_START_CHECK_THRESHOLD) {
	MOV	#lo_addr(_engineControl_startCheckCounter), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA LTU	L__EngineControl_isStarting9
	GOTO	L_EngineControl_isStarting0
L__EngineControl_isStarting9:
;enginecontrol.c,48 :: 		engineControl_startCheckCounter += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_engineControl_startCheckCounter), W0
	ADD.B	W1, [W0], [W0]
;enginecontrol.c,49 :: 		return TRUE;
	MOV.B	#1, W0
	GOTO	L_end_EngineControl_isStarting
;enginecontrol.c,50 :: 		} else {
L_EngineControl_isStarting0:
;enginecontrol.c,51 :: 		return FALSE;
	CLR	W0
;enginecontrol.c,53 :: 		}
L_end_EngineControl_isStarting:
	RETURN
; end of _EngineControl_isStarting
