
_GCU_isAlive:

;DY_GCU.c,48 :: 		void GCU_isAlive(void) {
;DY_GCU.c,49 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,50 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,51 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,53 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,54 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,55 :: 		Can_write(GCU_CLUTCH_ID);
	MOV	#1559, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,57 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,59 :: 		void init(void) {
;DY_GCU.c,60 :: 		dSignalLed_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_dSignalLed_init
;DY_GCU.c,61 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,62 :: 		EngineControl_init();
	CALL	_EngineControl_init
;DY_GCU.c,63 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,64 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,65 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,66 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,67 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,68 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,69 :: 		Sensors_init();
	CALL	_Sensors_init
;DY_GCU.c,70 :: 		rio_init();
	CALL	_rio_init
;DY_GCU.c,75 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,83 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,85 :: 		}
L_end_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _init

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;DY_GCU.c,87 :: 		void main() {
;DY_GCU.c,88 :: 		init();
	CALL	_init
;DY_GCU.c,89 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,91 :: 		while (1) {
L_main0:
;DY_GCU.c,93 :: 		Delay_ms(1000);
	MOV	#102, W8
	MOV	#47563, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
;DY_GCU.c,94 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,95 :: 		}
	GOTO	L_main0
;DY_GCU.c,96 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_timer1_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,99 :: 		onTimer1Interrupt{
;DY_GCU.c,100 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,101 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,102 :: 		Sensors_tick();
	CALL	_Sensors_tick
;DY_GCU.c,103 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,104 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,105 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,106 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,107 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,112 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt47
	GOTO	L_timer1_interrupt4
L__timer1_interrupt47:
;DY_GCU.c,113 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt48
	GOTO	L_timer1_interrupt5
L__timer1_interrupt48:
;DY_GCU.c,114 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,116 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,117 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,118 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,119 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt49
	GOTO	L_timer1_interrupt6
L__timer1_interrupt49:
;DY_GCU.c,120 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,121 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,122 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,125 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt50
	GOTO	L_timer1_interrupt7
L__timer1_interrupt50:
;DY_GCU.c,126 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,127 :: 		Sensors_send();
	CALL	_Sensors_send
;DY_GCU.c,128 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,129 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,131 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt51
	GOTO	L_timer1_interrupt8
L__timer1_interrupt51:
;DY_GCU.c,132 :: 		rio_sendTimes();
	CALL	_rio_sendTimes
;DY_GCU.c,136 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,137 :: 		}
L_timer1_interrupt8:
;DY_GCU.c,139 :: 		if (timer1_counter4 >= RIO_UPDATE_RATE_ms) {
	MOV	#166, W1
	MOV	#lo_addr(_timer1_counter4), W0
	CP	W1, [W0]
	BRA LE	L__timer1_interrupt52
	GOTO	L_timer1_interrupt9
L__timer1_interrupt52:
;DY_GCU.c,141 :: 		rio_send();
	CALL	_rio_send
;DY_GCU.c,142 :: 		timer1_counter4 = 0;
	CLR	W0
	MOV	W0, _timer1_counter4
;DY_GCU.c,143 :: 		}
L_timer1_interrupt9:
;DY_GCU.c,153 :: 		}
L_end_timer1_interrupt:
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer1_interrupt

_CAN_Interrupt:
	LNK	#24
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,155 :: 		onCanInterrupt{
;DY_GCU.c,160 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W14, #22, W3
	ADD	W14, #20, W2
	ADD	W14, #12, W1
	ADD	W14, #8, W0
	MOV	W3, W13
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_Can_read
;DY_GCU.c,161 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,163 :: 		if (dataLen >= 2) {
	MOV	[W14+20], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt54
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt54:
;DY_GCU.c,164 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
	ADD	W14, #12, W1
	MOV.B	[W1], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #1, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #0, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,165 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,166 :: 		if (dataLen >= 4) {
	MOV	[W14+20], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt55
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt55:
;DY_GCU.c,167 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
	ADD	W14, #12, W1
	ADD	W1, #2, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #3, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #2, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,168 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,169 :: 		if (dataLen >= 6) {
	MOV	[W14+20], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt56
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt56:
;DY_GCU.c,170 :: 		thirdInt = (unsigned int) ((dataBuffer[4] << 8) | (dataBuffer[5] & 0xFF));
	ADD	W14, #12, W1
	ADD	W1, #4, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #5, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #4, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,171 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,172 :: 		if (dataLen >= 8) {
	MOV	[W14+20], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt57
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt57:
;DY_GCU.c,173 :: 		fourthInt = (unsigned int) ((dataBuffer[6] << 8) | (dataBuffer[7] & 0xFF));
	ADD	W14, #12, W1
	ADD	W1, #6, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #7, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #6, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,174 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,177 :: 		switch (id) {
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,178 :: 		case EFI_GEAR_ID:
L_CAN_Interrupt16:
;DY_GCU.c,179 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,180 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,182 :: 		case SW_FIRE_ID:
L_CAN_Interrupt17:
;DY_GCU.c,183 :: 		EngineControl_resetStartCheck();
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,184 :: 		EngineControl_start();
	CALL	_EngineControl_start
;DY_GCU.c,185 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,187 :: 		case SW_RIO_GEAR_BRK_STEER_ID:
L_CAN_Interrupt18:
;DY_GCU.c,195 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,196 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,198 :: 		case EFI_FUEL_RPM_ID:
L_CAN_Interrupt19:
;DY_GCU.c,203 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,205 :: 		case SW_CLUTCH_ID:
L_CAN_Interrupt20:
;DY_GCU.c,210 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt58
	GOTO	L__CAN_Interrupt40
L__CAN_Interrupt58:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt59
	GOTO	L__CAN_Interrupt39
L__CAN_Interrupt59:
	GOTO	L__CAN_Interrupt37
L__CAN_Interrupt40:
L__CAN_Interrupt39:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt60
	GOTO	L__CAN_Interrupt41
L__CAN_Interrupt60:
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt37:
L__CAN_Interrupt41:
;DY_GCU.c,212 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #12, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,214 :: 		}
L_CAN_Interrupt25:
;DY_GCU.c,218 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,220 :: 		case CAN_ID_TIMES:
L_CAN_Interrupt26:
;DY_GCU.c,221 :: 		switch(firstInt){
	GOTO	L_CAN_Interrupt27
;DY_GCU.c,222 :: 		case CODE_SET_TIME:
L_CAN_Interrupt29:
;DY_GCU.c,223 :: 		gearShift_timings[secondInt] = thirdInt;
	MOV	[W14+2], W0
	SL	W0, #1, W1
	MOV	#lo_addr(_gearShift_timings), W0
	ADD	W0, W1, W1
	MOV	[W14+4], W0
	MOV	W0, [W1]
;DY_GCU.c,224 :: 		rio_sendOneTime(secondInt);
	MOV.B	[W14+2], W10
	CALL	_rio_sendOneTime
;DY_GCU.c,225 :: 		break;
	GOTO	L_CAN_Interrupt28
;DY_GCU.c,226 :: 		case CODE_REFRESH:
L_CAN_Interrupt30:
;DY_GCU.c,227 :: 		rio_sendAllTimes();
	CALL	_rio_sendAllTimes
;DY_GCU.c,231 :: 		break;
	GOTO	L_CAN_Interrupt28
;DY_GCU.c,237 :: 		default:
L_CAN_Interrupt31:
;DY_GCU.c,238 :: 		break;
	GOTO	L_CAN_Interrupt28
;DY_GCU.c,239 :: 		}
L_CAN_Interrupt27:
	MOV	[W14+0], W0
	CP	W0, #0
	BRA NZ	L__CAN_Interrupt61
	GOTO	L_CAN_Interrupt29
L__CAN_Interrupt61:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA NZ	L__CAN_Interrupt62
	GOTO	L_CAN_Interrupt30
L__CAN_Interrupt62:
	GOTO	L_CAN_Interrupt31
L_CAN_Interrupt28:
;DY_GCU.c,240 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,242 :: 		case EFI_OIL_BATT_ID:
L_CAN_Interrupt32:
;DY_GCU.c,243 :: 		rio_efiData[POIL] = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _rio_efiData+8
;DY_GCU.c,244 :: 		rio_efiData[TOIL_IN] = secondInt;
	MOV	[W14+2], W0
	MOV	W0, _rio_efiData+10
;DY_GCU.c,245 :: 		rio_efiData[TOIL_OUT] = thirdInt;
	MOV	[W14+4], W0
	MOV	W0, _rio_efiData+12
;DY_GCU.c,246 :: 		rio_efiData[BATTERY] = fourthInt;
	MOV	[W14+6], W0
	MOV	W0, _rio_efiData+14
;DY_GCU.c,247 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,249 :: 		case EFI_H2O_ID:
L_CAN_Interrupt33:
;DY_GCU.c,250 :: 		rio_efiData[H2O_DC] = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _rio_efiData
;DY_GCU.c,251 :: 		rio_efiData[TH2O_ENGINE] = secondInt;
	MOV	[W14+2], W0
	MOV	W0, _rio_efiData+2
;DY_GCU.c,252 :: 		rio_efiData[TH2O_IN] = thirdInt;
	MOV	[W14+4], W0
	MOV	W0, _rio_efiData+4
;DY_GCU.c,253 :: 		rio_efiData[TH2O_OUT] = fourthInt;
	MOV	[W14+6], W0
	MOV	W0, _rio_efiData+6
;DY_GCU.c,254 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,256 :: 		case EFI_MIXED_ID:
L_CAN_Interrupt34:
;DY_GCU.c,257 :: 		rio_efiData[P_FUEL] = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _rio_efiData+16
;DY_GCU.c,258 :: 		rio_efiData[FAN] = secondInt;
	MOV	[W14+2], W0
	MOV	W0, _rio_efiData+18
;DY_GCU.c,259 :: 		rio_efiData[INJ1] = thirdInt;
	MOV	[W14+4], W0
	MOV	W0, _rio_efiData+20
;DY_GCU.c,260 :: 		rio_efiData[INJ2] = fourthInt;
	MOV	[W14+6], W0
	MOV	W0, _rio_efiData+22
;DY_GCU.c,261 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,263 :: 		case SW_AUX_ID:
L_CAN_Interrupt35:
;DY_GCU.c,279 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,281 :: 		default:
L_CAN_Interrupt36:
;DY_GCU.c,282 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,283 :: 		}
L_CAN_Interrupt14:
	MOV	#776, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt63
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt63:
	MOV	#1728, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt64
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt64:
	MOV	#1280, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt65
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt65:
	MOV	#779, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt66
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt66:
	MOV	#1537, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt67
	GOTO	L_CAN_Interrupt20
L__CAN_Interrupt67:
	MOV	#1800, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt68
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt68:
	MOV	#781, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt69
	GOTO	L_CAN_Interrupt32
L__CAN_Interrupt69:
	MOV	#782, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt70
	GOTO	L_CAN_Interrupt33
L__CAN_Interrupt70:
	MOV	#783, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt71
	GOTO	L_CAN_Interrupt34
L__CAN_Interrupt71:
	MOV	#1776, W1
	MOV	#0, W2
	ADD	W14, #8, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt72
	GOTO	L_CAN_Interrupt35
L__CAN_Interrupt72:
	GOTO	L_CAN_Interrupt36
L_CAN_Interrupt15:
;DY_GCU.c,284 :: 		}
L_end_CAN_Interrupt:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _CAN_Interrupt
