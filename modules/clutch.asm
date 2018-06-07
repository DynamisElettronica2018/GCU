
_Clutch_insert:

;clutch.c,9 :: 		void Clutch_insert(void) {
;clutch.c,10 :: 		Clutch_set(100);
	PUSH	W10
	MOV.B	#100, W10
	CALL	_Clutch_set
;clutch.c,11 :: 		}
L_end_Clutch_insert:
	POP	W10
	RETURN
; end of _Clutch_insert

_Clutch_release:

;clutch.c,13 :: 		void Clutch_release(void) {
;clutch.c,14 :: 		Clutch_set(0);
	PUSH	W10
	CLR	W10
	CALL	_Clutch_set
;clutch.c,15 :: 		}
L_end_Clutch_release:
	POP	W10
	RETURN
; end of _Clutch_release

_Clutch_set:

;clutch.c,17 :: 		void Clutch_set(unsigned char percentage) {
;clutch.c,18 :: 		unsigned char actualPercentage = 0;
	PUSH	W10
;clutch.c,19 :: 		if (percentage > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Clutch_set7
	GOTO	L_Clutch_set0
L__Clutch_set7:
;clutch.c,20 :: 		actualPercentage = 100;
; actualPercentage start address is: 4 (W2)
	MOV.B	#100, W2
;clutch.c,21 :: 		} else {
; actualPercentage end address is: 4 (W2)
	GOTO	L_Clutch_set1
L_Clutch_set0:
;clutch.c,22 :: 		actualPercentage = percentage;
; actualPercentage start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentage end address is: 4 (W2)
;clutch.c,23 :: 		}
L_Clutch_set1:
;clutch.c,24 :: 		ClutchMotor_setPosition(100 - actualPercentage);
; actualPercentage start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_ClutchMotor_setPosition
	POP	W2
;clutch.c,25 :: 		Clutch_currentValue = actualPercentage;
	MOV	#lo_addr(_Clutch_currentValue), W0
	MOV.B	W2, [W0]
; actualPercentage end address is: 4 (W2)
;clutch.c,26 :: 		}
L_end_Clutch_set:
	POP	W10
	RETURN
; end of _Clutch_set

_Clutch_get:

;clutch.c,28 :: 		unsigned char Clutch_get(void) {
;clutch.c,29 :: 		return Clutch_currentValue;
	MOV	#lo_addr(_Clutch_currentValue), W0
	MOV.B	[W0], W0
;clutch.c,30 :: 		}
L_end_Clutch_get:
	RETURN
; end of _Clutch_get

_Clutch_setBiased:

;clutch.c,32 :: 		void Clutch_setBiased(unsigned char value){
;clutch.c,34 :: 		if(value >= CLUTCH_MAX_BIAS)
	PUSH	W10
	MOV.B	#95, W0
	CP.B	W10, W0
	BRA GEU	L__Clutch_setBiased10
	GOTO	L_Clutch_setBiased2
L__Clutch_setBiased10:
;clutch.c,35 :: 		Clutch_set(value);
	CALL	_Clutch_set
	GOTO	L_Clutch_setBiased3
L_Clutch_setBiased2:
;clutch.c,37 :: 		actual_value = (CLUTCH_MAX_MEANINGFUL * value) / 100;
	MOV	#70, W1
	ZE	W10, W0
	MUL.SS	W1, W0, W4
	MOV	#100, W2
	REPEAT	#17
	DIV.S	W4, W2
;clutch.c,38 :: 		Clutch_set(actual_value);
	MOV.B	W0, W10
	CALL	_Clutch_set
;clutch.c,39 :: 		}
L_Clutch_setBiased3:
;clutch.c,40 :: 		}
L_end_Clutch_setBiased:
	POP	W10
	RETURN
; end of _Clutch_setBiased
