
_rio_init:

;gcu_rio.c,9 :: 		void rio_init(void){
;gcu_rio.c,10 :: 		rio_canId = CAN_ID_DATA_1;
	MOV	#1801, W0
	MOV	W0, _rio_canId
;gcu_rio.c,11 :: 		}
L_end_rio_init:
	RETURN
; end of _rio_init

_rio_sendOneTime:

;gcu_rio.c,13 :: 		void rio_sendOneTime(time_id pos){
;gcu_rio.c,14 :: 		rio_timesCounter = pos;
	ZE	W10, W0
	MOV	W0, _rio_timesCounter
;gcu_rio.c,15 :: 		}
L_end_rio_sendOneTime:
	RETURN
; end of _rio_sendOneTime

_rio_sendTimes:

;gcu_rio.c,17 :: 		void rio_sendTimes(void)
;gcu_rio.c,19 :: 		if(rio_timesCounter >= 0){
	PUSH	W10
	PUSH	W11
	MOV	_rio_timesCounter, W0
	CP	W0, #0
	BRA GE	L__rio_sendTimes17
	GOTO	L_rio_sendTimes0
L__rio_sendTimes17:
;gcu_rio.c,20 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;gcu_rio.c,21 :: 		Can_addIntToWritePacket(CODE_SET_TIME);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,22 :: 		Can_addIntToWritePacket(rio_timesCounter);
	MOV	_rio_timesCounter, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,23 :: 		Can_addIntToWritePacket(gearShift_timings[rio_timesCounter]);
	MOV	_rio_timesCounter, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_gearShift_timings), W0
	ADD	W0, W1, W0
	MOV	[W0], W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,24 :: 		if(Can_write(CAN_ID_TIMES) < 0)
	MOV	#1800, W10
	MOV	#0, W11
	CALL	_Can_write
	CP	W0, #0
	BRA LTU	L__rio_sendTimes18
	GOTO	L_rio_sendTimes1
L__rio_sendTimes18:
;gcu_rio.c,25 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
L_rio_sendTimes1:
;gcu_rio.c,26 :: 		rio_timesCounter -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_rio_timesCounter), W0
	SUBR	W1, [W0], [W0]
;gcu_rio.c,27 :: 		if(!rio_sendingAll || rio_timesCounter < 0){
	MOV	#lo_addr(_rio_sendingAll), W0
	CP0.B	[W0]
	BRA NZ	L__rio_sendTimes19
	GOTO	L__rio_sendTimes13
L__rio_sendTimes19:
	MOV	_rio_timesCounter, W0
	CP	W0, #0
	BRA GE	L__rio_sendTimes20
	GOTO	L__rio_sendTimes12
L__rio_sendTimes20:
	GOTO	L_rio_sendTimes4
L__rio_sendTimes13:
L__rio_sendTimes12:
;gcu_rio.c,28 :: 		rio_sendingAll = FALSE;
	MOV	#lo_addr(_rio_sendingAll), W1
	CLR	W0
	MOV.B	W0, [W1]
;gcu_rio.c,29 :: 		rio_timesCounter = -1;
	MOV	#65535, W0
	MOV	W0, _rio_timesCounter
;gcu_rio.c,30 :: 		}
L_rio_sendTimes4:
;gcu_rio.c,31 :: 		}
L_rio_sendTimes0:
;gcu_rio.c,32 :: 		}
L_end_rio_sendTimes:
	POP	W11
	POP	W10
	RETURN
; end of _rio_sendTimes

_rio_sendAllTimes:

;gcu_rio.c,34 :: 		void rio_sendAllTimes(void)
;gcu_rio.c,36 :: 		if(!rio_sendingAll){
	MOV	#lo_addr(_rio_sendingAll), W0
	CP0.B	[W0]
	BRA Z	L__rio_sendAllTimes22
	GOTO	L_rio_sendAllTimes5
L__rio_sendAllTimes22:
;gcu_rio.c,37 :: 		rio_timesCounter = RIO_NUM_TIMES;
	MOV	#23, W0
	MOV	W0, _rio_timesCounter
;gcu_rio.c,38 :: 		rio_sendingAll = TRUE;
	MOV	#lo_addr(_rio_sendingAll), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;gcu_rio.c,39 :: 		}
L_rio_sendAllTimes5:
;gcu_rio.c,40 :: 		}
L_end_rio_sendAllTimes:
	RETURN
; end of _rio_sendAllTimes

_rio_send:

;gcu_rio.c,42 :: 		void rio_send(void){
;gcu_rio.c,43 :: 		switch(rio_canId){
	PUSH	W10
	PUSH	W11
	GOTO	L_rio_send6
;gcu_rio.c,44 :: 		case CAN_ID_DATA_1:
L_rio_send8:
;gcu_rio.c,45 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;gcu_rio.c,46 :: 		Can_addIntToWritePacket(rio_efiData[H2O_DC]);
	MOV	_rio_efiData, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,47 :: 		Can_addIntToWritePacket(rio_efiData[TH2O_ENGINE]);
	MOV	_rio_efiData+2, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,48 :: 		Can_addIntToWritePacket(rio_efiData[TH2O_IN]);
	MOV	_rio_efiData+4, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,49 :: 		Can_addIntToWritePacket(rio_efiData[TH2O_OUT]);
	MOV	_rio_efiData+6, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,50 :: 		Can_write(rio_canId);
	MOV	_rio_canId, W10
	ASR	W10, #15, W11
	CALL	_Can_write
;gcu_rio.c,51 :: 		rio_canId = CAN_ID_DATA_2;
	MOV	#1805, W0
	MOV	W0, _rio_canId
;gcu_rio.c,52 :: 		break;
	GOTO	L_rio_send7
;gcu_rio.c,53 :: 		case CAN_ID_DATA_2:
L_rio_send9:
;gcu_rio.c,54 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;gcu_rio.c,55 :: 		Can_addIntToWritePacket(rio_efiData[POIL]);
	MOV	_rio_efiData+8, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,56 :: 		Can_addIntToWritePacket(rio_efiData[TOIL_IN]);
	MOV	_rio_efiData+10, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,57 :: 		Can_addIntToWritePacket(rio_efiData[TOIL_OUT]);
	MOV	_rio_efiData+12, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,58 :: 		Can_addIntToWritePacket(rio_efiData[BATTERY]);
	MOV	_rio_efiData+14, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,59 :: 		Can_write(rio_canId);
	MOV	_rio_canId, W10
	ASR	W10, #15, W11
	CALL	_Can_write
;gcu_rio.c,60 :: 		rio_canId = CAN_ID_DATA_3;
	MOV	#1806, W0
	MOV	W0, _rio_canId
;gcu_rio.c,61 :: 		break;
	GOTO	L_rio_send7
;gcu_rio.c,62 :: 		case CAN_ID_DATA_3:
L_rio_send10:
;gcu_rio.c,63 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;gcu_rio.c,64 :: 		Can_addIntToWritePacket(rio_efiData[P_FUEL]);
	MOV	_rio_efiData+16, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,65 :: 		Can_addIntToWritePacket(rio_efiData[FAN]);
	MOV	_rio_efiData+18, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,66 :: 		Can_addIntToWritePacket(rio_efiData[INJ1]);
	MOV	_rio_efiData+20, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,67 :: 		Can_addIntToWritePacket(rio_efiData[INJ2]);
	MOV	_rio_efiData+22, W10
	CALL	_Can_addIntToWritePacket
;gcu_rio.c,68 :: 		Can_write(rio_canId);
	MOV	_rio_canId, W10
	ASR	W10, #15, W11
	CALL	_Can_write
;gcu_rio.c,69 :: 		rio_canId = CAN_ID_DATA_1;
	MOV	#1801, W0
	MOV	W0, _rio_canId
;gcu_rio.c,70 :: 		break;
	GOTO	L_rio_send7
;gcu_rio.c,71 :: 		}
L_rio_send6:
	MOV	_rio_canId, W1
	MOV	#1801, W0
	CP	W1, W0
	BRA NZ	L__rio_send24
	GOTO	L_rio_send8
L__rio_send24:
	MOV	_rio_canId, W1
	MOV	#1805, W0
	CP	W1, W0
	BRA NZ	L__rio_send25
	GOTO	L_rio_send9
L__rio_send25:
	MOV	_rio_canId, W1
	MOV	#1806, W0
	CP	W1, W0
	BRA NZ	L__rio_send26
	GOTO	L_rio_send10
L__rio_send26:
L_rio_send7:
;gcu_rio.c,72 :: 		}
L_end_rio_send:
	POP	W11
	POP	W10
	RETURN
; end of _rio_send
