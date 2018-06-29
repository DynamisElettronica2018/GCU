
_dSignalLed_init:

;d_signalled.c,7 :: 		void dSignalLed_init(void) {
;d_signalled.c,8 :: 		DSIGNAL_0_Direction = OUTPUT;
	PUSH	W10
	BCLR	TRISG14_bit, BitPos(TRISG14_bit+0)
;d_signalled.c,9 :: 		dSignalLed_unset(DSIGNAL_LED_0);
	CLR	W10
	CALL	_dSignalLed_unset
;d_signalled.c,10 :: 		}
L_end_dSignalLed_init:
	POP	W10
	RETURN
; end of _dSignalLed_init

_dSignalLed_switch:

;d_signalled.c,12 :: 		void dSignalLed_switch(unsigned char led) {
;d_signalled.c,13 :: 		switch (led) {
	GOTO	L_dSignalLed_switch0
;d_signalled.c,14 :: 		case DSIGNAL_LED_0:
L_dSignalLed_switch2:
;d_signalled.c,15 :: 		DSIGNAL_0_Pin = !DSIGNAL_0_Pin;
	BTG	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,16 :: 		break;
	GOTO	L_dSignalLed_switch1
;d_signalled.c,17 :: 		}
L_dSignalLed_switch0:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_switch11
	GOTO	L_dSignalLed_switch2
L__dSignalLed_switch11:
L_dSignalLed_switch1:
;d_signalled.c,18 :: 		}
L_end_dSignalLed_switch:
	RETURN
; end of _dSignalLed_switch

_dSignalLed_set:

;d_signalled.c,20 :: 		void dSignalLed_set(unsigned char led) {
;d_signalled.c,21 :: 		switch (led) {
	GOTO	L_dSignalLed_set3
;d_signalled.c,22 :: 		case DSIGNAL_LED_0:
L_dSignalLed_set5:
;d_signalled.c,23 :: 		DSIGNAL_0_Pin = DSIGNAL_LED_ON;
	BSET	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,24 :: 		break;
	GOTO	L_dSignalLed_set4
;d_signalled.c,25 :: 		}
L_dSignalLed_set3:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_set13
	GOTO	L_dSignalLed_set5
L__dSignalLed_set13:
L_dSignalLed_set4:
;d_signalled.c,26 :: 		}
L_end_dSignalLed_set:
	RETURN
; end of _dSignalLed_set

_dSignalLed_unset:

;d_signalled.c,28 :: 		void dSignalLed_unset(unsigned char led) {
;d_signalled.c,29 :: 		switch (led) {
	GOTO	L_dSignalLed_unset6
;d_signalled.c,30 :: 		case DSIGNAL_LED_0:
L_dSignalLed_unset8:
;d_signalled.c,31 :: 		DSIGNAL_0_Pin = DSIGNAL_LED_OFF;
	BCLR	RG14_bit, BitPos(RG14_bit+0)
;d_signalled.c,32 :: 		break;
	GOTO	L_dSignalLed_unset7
;d_signalled.c,33 :: 		}
L_dSignalLed_unset6:
	CP.B	W10, #0
	BRA NZ	L__dSignalLed_unset15
	GOTO	L_dSignalLed_unset8
L__dSignalLed_unset15:
L_dSignalLed_unset7:
;d_signalled.c,34 :: 		}
L_end_dSignalLed_unset:
	RETURN
; end of _dSignalLed_unset
