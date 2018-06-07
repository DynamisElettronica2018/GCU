
_dSignalLed_init:

;d_signalled.c,7 :: 		void dSignalLed_init(void) {
;d_signalled.c,8 :: 		DSIGNAL_0_Direction = OUTPUT;
	PUSH	W10
	BCLR	TRISG14_bit, BitPos(TRISG14_bit+0)
;d_signalled.c,9 :: 		DSIGNAL_1_Direction = OUTPUT;
	BCLR	TRISG12_bit, BitPos(TRISG12_bit+0)
;d_signalled.c,10 :: 		dSignalLed_unset(DSIGNAL_LED_0);
	CLR	W10
	CALL	_dSignalLed_unset
;d_signalled.c,11 :: 		dSignalLed_unset(DSIGNAL_LED_1);
	MOV.B	#1, W10
	CALL	_dSignalLed_unset
;d_signalled.c,12 :: 		}
L_end_dSignalLed_init:
	POP	W10
	RETURN
; end of _dSignalLed_init

_dSignalLed_switch:

;d_signalled.c,14 :: 		void dSignalLed_switch(unsigned char led) {
;d_signalled.c,15 :: 		switch (led) {
	GOTO	L_dSignalLed_switch0
;d_signalled.c,16 :: 		case DSIGNAL_LED_0:
L_dSignalLed_switch2:
;d_signalled.c,17 :: 		DSIGNAL_0_Pin = !DSIGNAL_0_Pin;
	BTG	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,18 :: 		break;
	GOTO	L_dSignalLed_switch1
;d_signalled.c,19 :: 		case DSIGNAL_LED_1:
L_dSignalLed_switch3:
;d_signalled.c,20 :: 		DSIGNAL_1_Pin = !DSIGNAL_1_Pin;
	BTG	RG12_bit, BitPos(RG12_bit+0)
;d_signalled.c,21 :: 		break;
	GOTO	L_dSignalLed_switch1
;d_signalled.c,22 :: 		}
L_dSignalLed_switch0:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_switch14
	GOTO	L_dSignalLed_switch2
L__dSignalLed_switch14:
	CP.B	W10, #1
	BRA NZ	L__dSignalLed_switch15
	GOTO	L_dSignalLed_switch3
L__dSignalLed_switch15:
L_dSignalLed_switch1:
;d_signalled.c,23 :: 		}
L_end_dSignalLed_switch:
	RETURN
; end of _dSignalLed_switch

_dSignalLed_set:

;d_signalled.c,25 :: 		void dSignalLed_set(unsigned char led) {
;d_signalled.c,26 :: 		switch (led) {
	GOTO	L_dSignalLed_set4
;d_signalled.c,27 :: 		case DSIGNAL_LED_0:
L_dSignalLed_set6:
;d_signalled.c,28 :: 		DSIGNAL_0_Pin = DSIGNAL_LED_ON;
	BSET	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,29 :: 		break;
	GOTO	L_dSignalLed_set5
;d_signalled.c,30 :: 		case DSIGNAL_LED_1:
L_dSignalLed_set7:
;d_signalled.c,31 :: 		DSIGNAL_1_Pin = DSIGNAL_LED_ON;
	BSET	RG12_bit, BitPos(RG12_bit+0)
;d_signalled.c,32 :: 		break;
	GOTO	L_dSignalLed_set5
;d_signalled.c,33 :: 		}
L_dSignalLed_set4:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_set17
	GOTO	L_dSignalLed_set6
L__dSignalLed_set17:
	CP.B	W10, #1
	BRA NZ	L__dSignalLed_set18
	GOTO	L_dSignalLed_set7
L__dSignalLed_set18:
L_dSignalLed_set5:
;d_signalled.c,34 :: 		}
L_end_dSignalLed_set:
	RETURN
; end of _dSignalLed_set

_dSignalLed_unset:

;d_signalled.c,36 :: 		void dSignalLed_unset(unsigned char led) {
;d_signalled.c,37 :: 		switch (led) {
	GOTO	L_dSignalLed_unset8
;d_signalled.c,38 :: 		case DSIGNAL_LED_0:
L_dSignalLed_unset10:
;d_signalled.c,39 :: 		DSIGNAL_0_Pin = DSIGNAL_LED_OFF;
	BCLR	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,40 :: 		break;
	GOTO	L_dSignalLed_unset9
;d_signalled.c,41 :: 		case DSIGNAL_LED_1:
L_dSignalLed_unset11:
;d_signalled.c,42 :: 		DSIGNAL_1_Pin = DSIGNAL_LED_OFF;
	BCLR	RG12_bit, BitPos(RG12_bit+0)
;d_signalled.c,43 :: 		break;
	GOTO	L_dSignalLed_unset9
;d_signalled.c,44 :: 		}
L_dSignalLed_unset8:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_unset20
	GOTO	L_dSignalLed_unset10
L__dSignalLed_unset20:
	CP.B	W10, #1
	BRA NZ	L__dSignalLed_unset21
	GOTO	L_dSignalLed_unset11
L__dSignalLed_unset21:
L_dSignalLed_unset9:
;d_signalled.c,45 :: 		}
L_end_dSignalLed_unset:
	RETURN
; end of _dSignalLed_unset
