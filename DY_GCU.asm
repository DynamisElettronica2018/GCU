
_GCU_isAlive:

;DY_GCU.c,55 :: 		void GCU_isAlive(void) {
;DY_GCU.c,56 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,57 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,58 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,60 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,61 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,62 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,64 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,85 :: 		void init(void) {
;DY_GCU.c,86 :: 		dSignalLed_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_dSignalLed_init
;DY_GCU.c,87 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,88 :: 		EngineControl_init();
	CALL	_EngineControl_init
;DY_GCU.c,89 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,90 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,91 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,92 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,93 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,94 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,102 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,103 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,104 :: 		Can_addIntToWritePacket(0xFFFF);
	MOV	#65535, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,105 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,106 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,107 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,109 :: 		Can_write(GCU_LAUNCH_CONTROL_EFI_ID);
	MOV	#1281, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,110 :: 		}
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

;DY_GCU.c,112 :: 		void main() {
;DY_GCU.c,113 :: 		init();
	CALL	_init
;DY_GCU.c,114 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,116 :: 		while (1)
L_main0:
;DY_GCU.c,119 :: 		Delay_ms(1000);
	MOV	#102, W8
	MOV	#47563, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
;DY_GCU.c,120 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,122 :: 		}
	GOTO	L_main0
;DY_GCU.c,123 :: 		}
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

;DY_GCU.c,126 :: 		onTimer1Interrupt{
;DY_GCU.c,127 :: 		clearTimer1();
	PUSH	W10
	PUSH	W11
	BCLR	IFS0bits, #3
;DY_GCU.c,128 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,130 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,131 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,132 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,133 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,134 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,139 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt38
	GOTO	L_timer1_interrupt4
L__timer1_interrupt38:
;DY_GCU.c,140 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt39
	GOTO	L_timer1_interrupt5
L__timer1_interrupt39:
;DY_GCU.c,141 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,143 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,144 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,145 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,146 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt40
	GOTO	L_timer1_interrupt6
L__timer1_interrupt40:
;DY_GCU.c,147 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,148 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,149 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,152 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt41
	GOTO	L_timer1_interrupt7
L__timer1_interrupt41:
;DY_GCU.c,153 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,155 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,157 :: 		if (test_targetSlip == 900)
	MOV	_test_targetSlip, W1
	MOV	#900, W0
	CP	W1, W0
	BRA Z	L__timer1_interrupt42
	GOTO	L_timer1_interrupt8
L__timer1_interrupt42:
;DY_GCU.c,158 :: 		test_targetSlip = 500;
	MOV	#500, W0
	MOV	W0, _test_targetSlip
L_timer1_interrupt8:
;DY_GCU.c,159 :: 		test_targetSlip += 100;
	MOV	#100, W1
	MOV	#lo_addr(_test_targetSlip), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,160 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;DY_GCU.c,161 :: 		Can_addIntToWritePacket(test_targetSlip);
	MOV	_test_targetSlip, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,162 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,163 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,164 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,165 :: 		Can_write(GCU_TRACTION_CONTROL_EFI_ID);
	MOV	#1280, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,166 :: 		if (test_rpmLimiter == 900)
	MOV	_test_rpmLimiter, W1
	MOV	#900, W0
	CP	W1, W0
	BRA Z	L__timer1_interrupt43
	GOTO	L_timer1_interrupt9
L__timer1_interrupt43:
;DY_GCU.c,167 :: 		test_rpmLimiter = 0;
	CLR	W0
	MOV	W0, _test_rpmLimiter
L_timer1_interrupt9:
;DY_GCU.c,168 :: 		test_rpmLimiter += 300;
	MOV	#300, W1
	MOV	#lo_addr(_test_rpmLimiter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,193 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,195 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt44
	GOTO	L_timer1_interrupt10
L__timer1_interrupt44:
;DY_GCU.c,200 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,201 :: 		}
L_timer1_interrupt10:
;DY_GCU.c,220 :: 		}
L_end_timer1_interrupt:
	POP	W11
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
	LNK	#18
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,222 :: 		onCanInterrupt{
;DY_GCU.c,227 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W14, #16, W3
	ADD	W14, #14, W2
	ADD	W14, #6, W1
	ADD	W14, #2, W0
	MOV	W3, W13
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_Can_read
;DY_GCU.c,228 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,230 :: 		if (dataLen >= 2) {
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt46
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt46:
;DY_GCU.c,231 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
	ADD	W14, #6, W1
	MOV.B	[W1], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #1, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #0, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,232 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,233 :: 		if (dataLen >= 4) {
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt47
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt47:
;DY_GCU.c,235 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,236 :: 		if (dataLen >= 6) {
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt48
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt48:
;DY_GCU.c,238 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,239 :: 		if (dataLen >= 8) {
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt49:
;DY_GCU.c,241 :: 		}
L_CAN_Interrupt14:
;DY_GCU.c,244 :: 		switch (id) {
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,245 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt17:
;DY_GCU.c,246 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,247 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,249 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt18:
;DY_GCU.c,250 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,251 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,252 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,268 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt19:
;DY_GCU.c,269 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,270 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,282 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt20:
;DY_GCU.c,287 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt50
	GOTO	L__CAN_Interrupt31
L__CAN_Interrupt50:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt51
	GOTO	L__CAN_Interrupt30
L__CAN_Interrupt51:
	GOTO	L__CAN_Interrupt28
L__CAN_Interrupt31:
L__CAN_Interrupt30:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt52
	GOTO	L__CAN_Interrupt32
L__CAN_Interrupt52:
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt28:
L__CAN_Interrupt32:
;DY_GCU.c,288 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,289 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #6, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,291 :: 		}
L_CAN_Interrupt25:
;DY_GCU.c,295 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,322 :: 		case EFI_HALL_ID:
L_CAN_Interrupt26:
;DY_GCU.c,324 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,347 :: 		default:
L_CAN_Interrupt27:
;DY_GCU.c,348 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,349 :: 		}
L_CAN_Interrupt15:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt53
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt53:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt54
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt54:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt55
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt55:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt56
	GOTO	L_CAN_Interrupt20
L__CAN_Interrupt56:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt57
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt57:
	GOTO	L_CAN_Interrupt27
L_CAN_Interrupt16:
;DY_GCU.c,350 :: 		}
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
