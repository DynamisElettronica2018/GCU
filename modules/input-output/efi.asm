
_Efi_init:

;efi.c,6 :: 		void Efi_init(void) {
;efi.c,7 :: 		DOWNCUT_Direction = OUTPUT;
	BCLR	TRISD2_bit, BitPos(TRISD2_bit+0)
;efi.c,8 :: 		UPCUT_Direction = OUTPUT;
	BCLR	TRISD3_bit, BitPos(TRISD3_bit+0)
;efi.c,9 :: 		RPM_LIMITER_Direction = OUTPUT;
	BCLR	TRISD4_bit, BitPos(TRISD4_bit+0)
;efi.c,10 :: 		RPM_LIMITER_Pin = 0;
	BCLR	RD4_bit, BitPos(RD4_bit+0)
;efi.c,11 :: 		Efi_unsetBlip();
	CALL	_Efi_unsetBlip
;efi.c,12 :: 		Efi_unsetCut();
	CALL	_Efi_unsetCut
;efi.c,13 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;efi.c,14 :: 		}
L_end_Efi_init:
	RETURN
; end of _Efi_init

_Efi_setCut:

;efi.c,16 :: 		void Efi_setCut(void) {
;efi.c,17 :: 		UPCUT_Pin = SET_CUT;
	BCLR	RD3_bit, BitPos(RD3_bit+0)
;efi.c,18 :: 		}
L_end_Efi_setCut:
	RETURN
; end of _Efi_setCut

_Efi_unsetCut:

;efi.c,20 :: 		void Efi_unsetCut(void) {
;efi.c,21 :: 		UPCUT_Pin = UNSET_CUT;
	BSET	RD3_bit, BitPos(RD3_bit+0)
;efi.c,22 :: 		}
L_end_Efi_unsetCut:
	RETURN
; end of _Efi_unsetCut

_Efi_setBlip:

;efi.c,24 :: 		void Efi_setBlip(void) {
;efi.c,25 :: 		DOWNCUT_Pin = SET_CUT;
	BCLR	RD2_bit, BitPos(RD2_bit+0)
;efi.c,26 :: 		}
L_end_Efi_setBlip:
	RETURN
; end of _Efi_setBlip

_Efi_unsetBlip:

;efi.c,28 :: 		void Efi_unsetBlip(void) {
;efi.c,29 :: 		DOWNCUT_Pin = UNSET_CUT;
	BSET	RD2_bit, BitPos(RD2_bit+0)
;efi.c,30 :: 		}
L_end_Efi_unsetBlip:
	RETURN
; end of _Efi_unsetBlip

_Efi_setRPMLimiter:

;efi.c,32 :: 		void Efi_setRPMLimiter(void){
;efi.c,33 :: 		RPM_LIMITER_Pin = SET_RPM_LIMITER;
	BCLR	RD4_bit, BitPos(RD4_bit+0)
;efi.c,34 :: 		}
L_end_Efi_setRPMLimiter:
	RETURN
; end of _Efi_setRPMLimiter

_Efi_unsetRPMLimiter:

;efi.c,36 :: 		void Efi_unsetRPMLimiter(void){
;efi.c,37 :: 		RPM_LIMITER_Pin = UNSET_RPM_LIMITER;
	BSET	RD4_bit, BitPos(RD4_bit+0)
;efi.c,38 :: 		}
L_end_Efi_unsetRPMLimiter:
	RETURN
; end of _Efi_unsetRPMLimiter
