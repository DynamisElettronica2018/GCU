
_unsignedIntToString:

;basic.c,8 :: 		void unsignedIntToString(unsigned int number, char *text) {
;basic.c,9 :: 		emptyString(text);
	PUSH	W10
	MOV	W11, W10
	CALL	_emptyString
	POP	W10
;basic.c,10 :: 		sprintf(text, "%u", number);
	MOV	#lo_addr(?lstr_1_basic), W0
	PUSH	W10
	PUSH	W0
	PUSH	W11
	CALL	_sprintf
	SUB	#6, W15
;basic.c,11 :: 		}
L_end_unsignedIntToString:
	RETURN
; end of _unsignedIntToString

_signedIntToString:

;basic.c,13 :: 		void signedIntToString(int number, char *text) {
;basic.c,14 :: 		emptyString(text);
	PUSH	W10
	MOV	W11, W10
	CALL	_emptyString
	POP	W10
;basic.c,15 :: 		sprintf(text, "%d", number);
	MOV	#lo_addr(?lstr_2_basic), W0
	PUSH	W10
	PUSH	W0
	PUSH	W11
	CALL	_sprintf
	SUB	#6, W15
;basic.c,16 :: 		}
L_end_signedIntToString:
	RETURN
; end of _signedIntToString

_emptyString:

;basic.c,18 :: 		void emptyString(char *myString) {
;basic.c,19 :: 		myString[0] = '\0';
	CLR	W0
	MOV.B	W0, [W10]
;basic.c,23 :: 		}
L_end_emptyString:
	RETURN
; end of _emptyString

_getNumberDigitCount:

;basic.c,25 :: 		unsigned char getNumberDigitCount(unsigned char number) {
;basic.c,26 :: 		if (number >= 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GEU	L__getNumberDigitCount8
	GOTO	L_getNumberDigitCount0
L__getNumberDigitCount8:
;basic.c,27 :: 		return 3;
	MOV.B	#3, W0
	GOTO	L_end_getNumberDigitCount
;basic.c,28 :: 		} else if (number >= 10) {
L_getNumberDigitCount0:
	CP.B	W10, #10
	BRA GEU	L__getNumberDigitCount9
	GOTO	L_getNumberDigitCount2
L__getNumberDigitCount9:
;basic.c,29 :: 		return 2;
	MOV.B	#2, W0
	GOTO	L_end_getNumberDigitCount
;basic.c,30 :: 		} else {
L_getNumberDigitCount2:
;basic.c,31 :: 		return 1;
	MOV.B	#1, W0
;basic.c,33 :: 		}
L_end_getNumberDigitCount:
	RETURN
; end of _getNumberDigitCount
