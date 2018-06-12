
_aac_init:

;aac.c,19 :: 		void aac_init(void){
;aac.c,20 :: 		aac_currentState = OFF;
	MOV	#lo_addr(_aac_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,21 :: 		aac_loadDefaultParams();
	CALL	_aac_loadDefaultParams
;aac.c,22 :: 		}
L_end_aac_init:
	RETURN
; end of _aac_init

_aac_execute:
	LNK	#8

;aac.c,24 :: 		void aac_execute(void){
;aac.c,25 :: 		switch (aac_currentState) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	GOTO	L_aac_execute0
;aac.c,26 :: 		case START:
L_aac_execute2:
;aac.c,27 :: 		Efi_setRPMLimiter();
	CALL	_Efi_setRPMLimiter
;aac.c,29 :: 		Can_writeByte(SW_AUX_ID, MEX_READY);
	MOV.B	#1, W12
	MOV	#2032, W10
	MOV	#0, W11
	CALL	_Can_writeByte
;aac.c,30 :: 		aac_currentState = READY;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;aac.c,31 :: 		aac_clutchValue = 100;
	MOV	#0, W0
	MOV	#17096, W1
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,32 :: 		Clutch_set((unsigned int)aac_clutchValue);
	MOV	#0, W0
	MOV	#17096, W1
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,33 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,34 :: 		case READY:
L_aac_execute3:
;aac.c,35 :: 		Clutch_set(100);
	MOV.B	#100, W10
	CALL	_Clutch_set
;aac.c,36 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,37 :: 		case START_RELEASE:
L_aac_execute4:
;aac.c,38 :: 		aac_clutchValue = aac_parameters[RAMP_START];
	MOV	_aac_parameters, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,39 :: 		Clutch_set(aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,40 :: 		aac_dtRelease = aac_parameters[RAMP_TIME] / AAC_WORK_RATE_ms;
	MOV	_aac_parameters+4, W0
	MOV	#25, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _aac_dtRelease
;aac.c,41 :: 		aac_clutchStep = ((float)(aac_parameters[RAMP_START] - aac_parameters[RAMP_END]) * AAC_WORK_RATE_ms) / (float)aac_parameters[RAMP_TIME];
	MOV	_aac_parameters, W1
	MOV	#lo_addr(_aac_parameters+2), W0
	SUB	W1, [W0], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16840, W3
	CALL	__Mul_FP
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	MOV	_aac_parameters+4, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	[W14+4], W0
	MOV	[W14+6], W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	POP.D	W2
	MOV	W0, _aac_clutchStep
	MOV	W1, _aac_clutchStep+2
;aac.c,42 :: 		aac_currentState = RELEASING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;aac.c,43 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,44 :: 		case RELEASING:
L_aac_execute5:
;aac.c,46 :: 		aac_clutchValue = aac_clutchValue - aac_clutchStep;
	MOV	_aac_clutchValue, W0
	MOV	_aac_clutchValue+2, W1
	MOV	_aac_clutchStep, W2
	MOV	_aac_clutchStep+2, W3
	CALL	__Sub_FP
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,47 :: 		Clutch_set((unsigned char)aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,48 :: 		aac_dtRelease--;
	MOV	#1, W1
	MOV	#lo_addr(_aac_dtRelease), W0
	SUBR	W1, [W0], [W0]
;aac.c,49 :: 		if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END]){
	MOV	_aac_dtRelease, W0
	CP	W0, #0
	BRA GT	L__aac_execute38
	GOTO	L__aac_execute30
L__aac_execute38:
	CALL	_Clutch_get
	ZE	W0, W1
	MOV	#lo_addr(_aac_parameters+2), W0
	CP	W1, [W0]
	BRA GT	L__aac_execute39
	GOTO	L__aac_execute29
L__aac_execute39:
	GOTO	L_aac_execute8
L__aac_execute30:
L__aac_execute29:
;aac.c,50 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;aac.c,51 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;aac.c,52 :: 		aac_currentState = RUNNING;                 //For gearshift  Use alternatively to aac_stop
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;aac.c,55 :: 		}
L_aac_execute8:
;aac.c,56 :: 		Buzzer_bip();
	CALL	_Buzzer_Bip
;aac.c,57 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,58 :: 		case RUNNING:
L_aac_execute9:
;aac.c,60 :: 		if(gearShift_currentGear == 4){
	MOV	_gearShift_currentGear, W0
	CP	W0, #4
	BRA Z	L__aac_execute40
	GOTO	L_aac_execute10
L__aac_execute40:
;aac.c,61 :: 		aac_stop();
	CALL	_aac_stop
;aac.c,62 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,63 :: 		}
L_aac_execute10:
;aac.c,65 :: 		if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
	MOV	_gearShift_currentGear, W0
	ADD	W0, #3, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
;aac.c,66 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
	MOV	#lo_addr(_aac_externValues), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute41
	GOTO	L__aac_execute32
L__aac_execute41:
	MOV	_gearShift_currentGear, W0
	ADD	W0, #6, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_aac_externValues+2), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute42
	GOTO	L__aac_execute31
L__aac_execute42:
L__aac_execute27:
;aac.c,67 :: 		GearShift_up();
	CALL	_GearShift_up
;aac.c,66 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
L__aac_execute32:
L__aac_execute31:
;aac.c,69 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,70 :: 		case STOPPING:
L_aac_execute14:
;aac.c,71 :: 		aac_currentState = OFF;
	MOV	#lo_addr(_aac_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,72 :: 		Can_writeByte(SW_AUX_ID, MEX_OFF);
	MOV.B	#3, W12
	MOV	#2032, W10
	MOV	#0, W11
	CALL	_Can_writeByte
;aac.c,73 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,75 :: 		default: return;
L_aac_execute15:
	GOTO	L_end_aac_execute
;aac.c,76 :: 		}
L_aac_execute0:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__aac_execute43
	GOTO	L_aac_execute2
L__aac_execute43:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__aac_execute44
	GOTO	L_aac_execute3
L__aac_execute44:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__aac_execute45
	GOTO	L_aac_execute4
L__aac_execute45:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__aac_execute46
	GOTO	L_aac_execute5
L__aac_execute46:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__aac_execute47
	GOTO	L_aac_execute9
L__aac_execute47:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__aac_execute48
	GOTO	L_aac_execute14
L__aac_execute48:
	GOTO	L_aac_execute15
;aac.c,77 :: 		}
L_end_aac_execute:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _aac_execute

_aac_sendOneTime:

;aac.c,79 :: 		void aac_sendOneTime(time_id pos){
;aac.c,80 :: 		aac_timesCounter = pos;
	ZE	W10, W0
	MOV	W0, _aac_timesCounter
;aac.c,81 :: 		}
L_end_aac_sendOneTime:
	RETURN
; end of _aac_sendOneTime

_aac_sendTimes:

;aac.c,83 :: 		void aac_sendTimes(void)
;aac.c,85 :: 		if(aac_timesCounter >= 0){
	PUSH	W10
	PUSH	W11
	MOV	_aac_timesCounter, W0
	CP	W0, #0
	BRA GE	L__aac_sendTimes51
	GOTO	L_aac_sendTimes16
L__aac_sendTimes51:
;aac.c,86 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;aac.c,87 :: 		Can_addIntToWritePacket(CODE_SET_AAC);
	MOV	#2, W10
	CALL	_Can_addIntToWritePacket
;aac.c,88 :: 		Can_addIntToWritePacket(aac_timesCounter);
	MOV	_aac_timesCounter, W10
	CALL	_Can_addIntToWritePacket
;aac.c,89 :: 		Can_addIntToWritePacket(aac_parameters[aac_timesCounter]);
	MOV	_aac_timesCounter, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W10
	CALL	_Can_addIntToWritePacket
;aac.c,90 :: 		if(Can_write(GCU_GEAR_TIMING_TELEMETRY_ID) < 0)
	MOV	#1805, W10
	MOV	#0, W11
	CALL	_Can_write
	CP	W0, #0
	BRA LTU	L__aac_sendTimes52
	GOTO	L_aac_sendTimes17
L__aac_sendTimes52:
;aac.c,91 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
L_aac_sendTimes17:
;aac.c,92 :: 		aac_timesCounter -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_aac_timesCounter), W0
	SUBR	W1, [W0], [W0]
;aac.c,93 :: 		if(!aac_sendingAll || aac_timesCounter < 0){
	MOV	#lo_addr(_aac_sendingAll), W0
	CP0.B	[W0]
	BRA NZ	L__aac_sendTimes53
	GOTO	L__aac_sendTimes35
L__aac_sendTimes53:
	MOV	_aac_timesCounter, W0
	CP	W0, #0
	BRA GE	L__aac_sendTimes54
	GOTO	L__aac_sendTimes34
L__aac_sendTimes54:
	GOTO	L_aac_sendTimes20
L__aac_sendTimes35:
L__aac_sendTimes34:
;aac.c,94 :: 		aac_sendingAll = FALSE;
	MOV	#lo_addr(_aac_sendingAll), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,95 :: 		aac_timesCounter = -1;
	MOV	#65535, W0
	MOV	W0, _aac_timesCounter
;aac.c,96 :: 		}
L_aac_sendTimes20:
;aac.c,97 :: 		}
L_aac_sendTimes16:
;aac.c,98 :: 		}
L_end_aac_sendTimes:
	POP	W11
	POP	W10
	RETURN
; end of _aac_sendTimes

_aac_sendAllTimes:

;aac.c,100 :: 		void aac_sendAllTimes(void)
;aac.c,102 :: 		if(!aac_sendingAll){
	MOV	#lo_addr(_aac_sendingAll), W0
	CP0.B	[W0]
	BRA Z	L__aac_sendAllTimes56
	GOTO	L_aac_sendAllTimes21
L__aac_sendAllTimes56:
;aac.c,103 :: 		aac_timesCounter = AAC_NUM_PARAMS;
	MOV	#9, W0
	MOV	W0, _aac_timesCounter
;aac.c,104 :: 		aac_sendingAll = TRUE;
	MOV	#lo_addr(_aac_sendingAll), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;aac.c,105 :: 		}
L_aac_sendAllTimes21:
;aac.c,106 :: 		}
L_end_aac_sendAllTimes:
	RETURN
; end of _aac_sendAllTimes

_aac_loadDefaultParams:

;aac.c,108 :: 		void aac_loadDefaultParams(void){
;aac.c,111 :: 		aac_parameters[RAMP_START]      = DEF_RAMP_START;
	MOV	#70, W0
	MOV	W0, _aac_parameters
;aac.c,112 :: 		aac_parameters[RAMP_END]        = DEF_RAMP_END;
	CLR	W0
	MOV	W0, _aac_parameters+2
;aac.c,113 :: 		aac_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
	MOV	#250, W0
	MOV	W0, _aac_parameters+4
;aac.c,114 :: 		aac_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+6
;aac.c,115 :: 		aac_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+8
;aac.c,116 :: 		aac_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+10
;aac.c,117 :: 		aac_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
	MOV	#47, W0
	MOV	W0, _aac_parameters+12
;aac.c,118 :: 		aac_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
	MOV	#65, W0
	MOV	W0, _aac_parameters+14
;aac.c,119 :: 		aac_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
	MOV	#80, W0
	MOV	W0, _aac_parameters+16
;aac.c,121 :: 		}
L_end_aac_loadDefaultParams:
	RETURN
; end of _aac_loadDefaultParams

_aac_updateParam:

;aac.c,123 :: 		void aac_updateParam(const aac_params id, const int value){
;aac.c,124 :: 		if(id < AAC_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__aac_updateParam59
	GOTO	L_aac_updateParam22
L__aac_updateParam59:
;aac.c,125 :: 		aac_parameters[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_aac_updateParam22:
;aac.c,126 :: 		}
L_end_aac_updateParam:
	RETURN
; end of _aac_updateParam

_aac_stop:

;aac.c,128 :: 		void aac_stop(void){
;aac.c,129 :: 		if(aac_currentState != OFF)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__aac_stop61
	GOTO	L_aac_stop23
L__aac_stop61:
;aac.c,130 :: 		aac_currentState = STOPPING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
L_aac_stop23:
;aac.c,131 :: 		}
L_end_aac_stop:
	RETURN
; end of _aac_stop

_aac_updateExternValue:

;aac.c,133 :: 		void aac_updateExternValue(const aac_values id, const int value){
;aac.c,134 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_updateExternValue63
	GOTO	L_aac_updateExternValue24
L__aac_updateExternValue63:
;aac.c,135 :: 		aac_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_aac_updateExternValue24:
;aac.c,136 :: 		}
L_end_aac_updateExternValue:
	RETURN
; end of _aac_updateExternValue

_aac_getParam:

;aac.c,138 :: 		int aac_getParam(const aac_params id){
;aac.c,139 :: 		if(id < AAC_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__aac_getParam65
	GOTO	L_aac_getParam25
L__aac_getParam65:
;aac.c,140 :: 		return aac_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getParam
L_aac_getParam25:
;aac.c,141 :: 		return -1;
	MOV	#65535, W0
;aac.c,142 :: 		}
L_end_aac_getParam:
	RETURN
; end of _aac_getParam

_aac_getExternValue:

;aac.c,144 :: 		int aac_getExternValue(const aac_params id){
;aac.c,145 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_getExternValue67
	GOTO	L_aac_getExternValue26
L__aac_getExternValue67:
;aac.c,146 :: 		return aac_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getExternValue
L_aac_getExternValue26:
;aac.c,147 :: 		return -1;
	MOV	#65535, W0
;aac.c,148 :: 		}
L_end_aac_getExternValue:
	RETURN
; end of _aac_getExternValue
