
_GearShift_init:

;gearshift.c,14 :: 		void GearShift_init(void) {
;gearshift.c,15 :: 		gearShift_currentGear = 0;
	CLR	W0
	MOV	W0, _gearShift_currentGear
;gearshift.c,16 :: 		gearShift_isShiftingUp = FALSE;
	MOV	#lo_addr(_gearShift_isShiftingUp), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,17 :: 		gearShift_isShiftingDown = FALSE;
	MOV	#lo_addr(_gearShift_isShiftingDown), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,18 :: 		gearShift_isSettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isSettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,19 :: 		gearShift_isUnsettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,20 :: 		gearShift_ticksCounter1 = 0;
	CLR	W0
	MOV	W0, _gearShift_ticksCounter1
;gearshift.c,21 :: 		gearShift_ticksCounter2 = 0;
	CLR	W0
	MOV	W0, _gearShift_ticksCounter2
;gearshift.c,22 :: 		GearShift_loadDefaultTimings();
	CALL	_GearShift_loadDefaultTimings
;gearshift.c,23 :: 		}
L_end_GearShift_init:
	RETURN
; end of _GearShift_init

_GearShift_setCurrentGear:

;gearshift.c,25 :: 		void GearShift_setCurrentGear(unsigned int gear) {
;gearshift.c,26 :: 		if (gear <= 5) {
	CP	W10, #5
	BRA LEU	L__GearShift_setCurrentGear100
	GOTO	L_GearShift_setCurrentGear0
L__GearShift_setCurrentGear100:
;gearshift.c,27 :: 		gearShift_currentGear = gear;
	MOV	W10, _gearShift_currentGear
;gearshift.c,28 :: 		}
L_GearShift_setCurrentGear0:
;gearshift.c,29 :: 		}
L_end_GearShift_setCurrentGear:
	RETURN
; end of _GearShift_setCurrentGear

_GearShift_injectCommand:

;gearshift.c,31 :: 		void GearShift_injectCommand(unsigned int command) {
;gearshift.c,32 :: 		if (command == GEAR_COMMAND_NEUTRAL_DOWN || command == GEAR_COMMAND_NEUTRAL_UP) {
	MOV	#100, W0
	CP	W10, W0
	BRA NZ	L__GearShift_injectCommand102
	GOTO	L__GearShift_injectCommand95
L__GearShift_injectCommand102:
	MOV	#50, W0
	CP	W10, W0
	BRA NZ	L__GearShift_injectCommand103
	GOTO	L__GearShift_injectCommand94
L__GearShift_injectCommand103:
	GOTO	L_GearShift_injectCommand3
L__GearShift_injectCommand95:
L__GearShift_injectCommand94:
;gearshift.c,33 :: 		GearShift_setNeutral(command);
	CALL	_GearShift_setNeutral
;gearshift.c,34 :: 		} else if (command == GEAR_COMMAND_DOWN || command == GEAR_COMMAND_UP) {
	GOTO	L_GearShift_injectCommand4
L_GearShift_injectCommand3:
	MOV	#200, W0
	CP	W10, W0
	BRA NZ	L__GearShift_injectCommand104
	GOTO	L__GearShift_injectCommand97
L__GearShift_injectCommand104:
	MOV	#400, W0
	CP	W10, W0
	BRA NZ	L__GearShift_injectCommand105
	GOTO	L__GearShift_injectCommand96
L__GearShift_injectCommand105:
	GOTO	L_GearShift_injectCommand7
L__GearShift_injectCommand97:
L__GearShift_injectCommand96:
;gearshift.c,35 :: 		GearShift_shift(command);
	CALL	_GearShift_shift
;gearshift.c,36 :: 		} else if (command == RPM_LIMITER_ON) {
	GOTO	L_GearShift_injectCommand8
L_GearShift_injectCommand7:
	MOV	#150, W0
	CP	W10, W0
	BRA Z	L__GearShift_injectCommand106
	GOTO	L_GearShift_injectCommand9
L__GearShift_injectCommand106:
;gearshift.c,37 :: 		Efi_setRPMLimiter();
	CALL	_Efi_setRPMLimiter
;gearshift.c,38 :: 		} else if (command == RPM_LIMITER_OFF) {
	GOTO	L_GearShift_injectCommand10
L_GearShift_injectCommand9:
	MOV	#160, W0
	CP	W10, W0
	BRA Z	L__GearShift_injectCommand107
	GOTO	L_GearShift_injectCommand11
L__GearShift_injectCommand107:
;gearshift.c,39 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;gearshift.c,40 :: 		}
L_GearShift_injectCommand11:
L_GearShift_injectCommand10:
L_GearShift_injectCommand8:
L_GearShift_injectCommand4:
;gearshift.c,41 :: 		}
L_end_GearShift_injectCommand:
	RETURN
; end of _GearShift_injectCommand

_GearShift_shift:

;gearshift.c,43 :: 		void GearShift_shift(unsigned int command) {
;gearshift.c,45 :: 		if (gearShift_currentGear == GEARSHIFT_NEUTRAL) {
	MOV	_gearShift_currentGear, W0
	CP	W0, #0
	BRA Z	L__GearShift_shift109
	GOTO	L_GearShift_shift12
L__GearShift_shift109:
;gearshift.c,46 :: 		gearShift_isUnsettingNeutral = TRUE;
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;gearshift.c,47 :: 		}
L_GearShift_shift12:
;gearshift.c,48 :: 		if (command == GEAR_COMMAND_UP) {
	MOV	#400, W0
	CP	W10, W0
	BRA Z	L__GearShift_shift110
	GOTO	L_GearShift_shift13
L__GearShift_shift110:
;gearshift.c,49 :: 		GearShift_up();
	CALL	_GearShift_up
;gearshift.c,50 :: 		} else if (command == GEAR_COMMAND_DOWN) {
	GOTO	L_GearShift_shift14
L_GearShift_shift13:
	MOV	#200, W0
	CP	W10, W0
	BRA Z	L__GearShift_shift111
	GOTO	L_GearShift_shift15
L__GearShift_shift111:
;gearshift.c,51 :: 		GearShift_down();
	CALL	_GearShift_down
;gearshift.c,52 :: 		}
L_GearShift_shift15:
L_GearShift_shift14:
;gearshift.c,53 :: 		}
L_end_GearShift_shift:
	RETURN
; end of _GearShift_shift

_GearShift_setNeutral:

;gearshift.c,55 :: 		void GearShift_setNeutral(unsigned int command) {
;gearshift.c,56 :: 		gearShift_isSettingNeutral = TRUE;
	MOV	#lo_addr(_gearShift_isSettingNeutral), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;gearshift.c,58 :: 		if (command == GEAR_COMMAND_NEUTRAL_DOWN) {
	MOV	#100, W0
	CP	W10, W0
	BRA Z	L__GearShift_setNeutral113
	GOTO	L_GearShift_setNeutral16
L__GearShift_setNeutral113:
;gearshift.c,59 :: 		GearShift_down();
	CALL	_GearShift_down
;gearshift.c,60 :: 		} else if (command == GEAR_COMMAND_NEUTRAL_UP) {
	GOTO	L_GearShift_setNeutral17
L_GearShift_setNeutral16:
	MOV	#50, W0
	CP	W10, W0
	BRA Z	L__GearShift_setNeutral114
	GOTO	L_GearShift_setNeutral18
L__GearShift_setNeutral114:
;gearshift.c,61 :: 		GearShift_up();
	CALL	_GearShift_up
;gearshift.c,62 :: 		}
L_GearShift_setNeutral18:
L_GearShift_setNeutral17:
;gearshift.c,63 :: 		}
L_end_GearShift_setNeutral:
	RETURN
; end of _GearShift_setNeutral

_GearShift_up:

;gearshift.c,65 :: 		void GearShift_up(void) {
;gearshift.c,66 :: 		Can_writeInt(GCU_CLUTCH_ID, 3);//Debug
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#3, W12
	MOV	#1559, W10
	MOV	#0, W11
	CALL	_Can_writeInt
;gearshift.c,67 :: 		if (!GearShift_isShifting()) {
	CALL	_GearShift_isShifting
	CP0.B	W0
	BRA Z	L__GearShift_up116
	GOTO	L_GearShift_up19
L__GearShift_up116:
;gearshift.c,68 :: 		gearShift_isShiftingUp = TRUE;
	MOV	#lo_addr(_gearShift_isShiftingUp), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;gearshift.c,69 :: 		GearShift_setNextStep_A(STEP_UP_START);
	CLR	W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,70 :: 		GearShift_nextStep_A();
	CALL	_GearShift_nextStep_A
;gearshift.c,71 :: 		}
L_GearShift_up19:
;gearshift.c,72 :: 		}
L_end_GearShift_up:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _GearShift_up

_GearShift_down:

;gearshift.c,74 :: 		void GearShift_down(void) {
;gearshift.c,75 :: 		Can_writeInt(GCU_CLUTCH_ID, 4);//Debug
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#4, W12
	MOV	#1559, W10
	MOV	#0, W11
	CALL	_Can_writeInt
;gearshift.c,76 :: 		if (!GearShift_isShifting()) {
	CALL	_GearShift_isShifting
	CP0.B	W0
	BRA Z	L__GearShift_down118
	GOTO	L_GearShift_down20
L__GearShift_down118:
;gearshift.c,77 :: 		gearShift_isShiftingDown = TRUE;
	MOV	#lo_addr(_gearShift_isShiftingDown), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;gearshift.c,78 :: 		GearShift_setNextStep_A(STEP_DOWN_START);
	MOV.B	#4, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,79 :: 		GearShift_nextStep_A();
	CALL	_GearShift_nextStep_A
;gearshift.c,80 :: 		}
L_GearShift_down20:
;gearshift.c,81 :: 		}
L_end_GearShift_down:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _GearShift_down

_GearShift_isShifting:

;gearshift.c,83 :: 		char GearShift_isShifting(void) {
;gearshift.c,84 :: 		return gearShift_isShiftingDown || gearShift_isShiftingUp;
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__GearShift_isShifting120
	GOTO	L_GearShift_isShifting22
L__GearShift_isShifting120:
	MOV	#lo_addr(_gearShift_isShiftingUp), W0
	CP0.B	[W0]
	BRA Z	L__GearShift_isShifting121
	GOTO	L_GearShift_isShifting22
L__GearShift_isShifting121:
	CLR	W1
	GOTO	L_GearShift_isShifting21
L_GearShift_isShifting22:
	MOV.B	#1, W0
	MOV.B	W0, W1
L_GearShift_isShifting21:
	MOV.B	W1, W0
;gearshift.c,85 :: 		}
L_end_GearShift_isShifting:
	RETURN
; end of _GearShift_isShifting

_GearShift_setNextStep_A:

;gearshift.c,87 :: 		void GearShift_setNextStep_A(unsigned char step) {
;gearshift.c,88 :: 		gearShift_nextStepValue_A = step;
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	W10, [W0]
;gearshift.c,89 :: 		}
L_end_GearShift_setNextStep_A:
	RETURN
; end of _GearShift_setNextStep_A

_GearShift_setNextStep_B:

;gearshift.c,91 :: 		void GearShift_setNextStep_B(unsigned char step) {
;gearshift.c,92 :: 		gearShift_nextStepValue_B = step;
	MOV	#lo_addr(_gearShift_nextStepValue_B), W0
	MOV.B	W10, [W0]
;gearshift.c,93 :: 		}
L_end_GearShift_setNextStep_B:
	RETURN
; end of _GearShift_setNextStep_B

_GearShift_checkUp:

;gearshift.c,95 :: 		void GearShift_checkUp(void){
;gearshift.c,97 :: 		if(gearShift_ticksCounterTries <= 0){
	MOV	_gearShift_ticksCounterTries, W0
	CP	W0, #0
	BRA LE	L__GearShift_checkUp125
	GOTO	L_GearShift_checkUp23
L__GearShift_checkUp125:
;gearshift.c,99 :: 		}
L_GearShift_checkUp23:
;gearshift.c,100 :: 		}
L_end_GearShift_checkUp:
	RETURN
; end of _GearShift_checkUp

_GearShift_nextStep_A:

;gearshift.c,192 :: 		void GearShift_nextStep_A(void) {
;gearshift.c,193 :: 		switch (gearShift_nextStepValue_A) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	GOTO	L_GearShift_nextStep_A24
;gearshift.c,194 :: 		case STEP_UP_START:
L_GearShift_nextStep_A26:
;gearshift.c,195 :: 		if (gearShift_isSettingNeutral) {
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA NZ	L__GearShift_nextStep_A127
	GOTO	L_GearShift_nextStep_A27
L__GearShift_nextStep_A127:
;gearshift.c,196 :: 		Clutch_set(80);
	MOV.B	#80, W10
	CALL	_Clutch_set
;gearshift.c,197 :: 		} else {
	GOTO	L_GearShift_nextStep_A28
L_GearShift_nextStep_A27:
;gearshift.c,198 :: 		Efi_setCut();
	CALL	_Efi_setCut
;gearshift.c,199 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;gearshift.c,200 :: 		}
L_GearShift_nextStep_A28:
;gearshift.c,201 :: 		GearShift_setNextStep_A(STEP_UP_PUSH);
	MOV.B	#1, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,202 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_START));
	CLR	W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,203 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,204 :: 		case STEP_UP_PUSH:
L_GearShift_nextStep_A29:
;gearshift.c,205 :: 		if (!gearShift_isSettingNeutral) {
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__GearShift_nextStep_A128
	GOTO	L_GearShift_nextStep_A30
L__GearShift_nextStep_A128:
;gearshift.c,206 :: 		Efi_unsetCut();
	CALL	_Efi_unsetCut
;gearshift.c,207 :: 		}
L_GearShift_nextStep_A30:
;gearshift.c,208 :: 		GearShift_upPush();
	CALL	_GearMotor_turnRight
;gearshift.c,209 :: 		GearShift_setNextStep_A(STEP_UP_REBOUND);
	MOV.B	#2, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,210 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_PUSH));
	MOV.B	#1, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,211 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,212 :: 		case STEP_UP_REBOUND:
L_GearShift_nextStep_A31:
;gearshift.c,213 :: 		if (gearShift_isSettingNeutral) {
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA NZ	L__GearShift_nextStep_A129
	GOTO	L_GearShift_nextStep_A32
L__GearShift_nextStep_A129:
;gearshift.c,214 :: 		Clutch_release();
	CALL	_Clutch_release
;gearshift.c,215 :: 		}
L_GearShift_nextStep_A32:
;gearshift.c,216 :: 		GearShift_rebound();
	CALL	_GearMotor_release
;gearshift.c,217 :: 		GearShift_setNextStep_A(STEP_UP_BRAKE);
	MOV.B	#3, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,218 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_REBOUND));
	MOV.B	#2, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,219 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,220 :: 		case STEP_UP_BRAKE:
L_GearShift_nextStep_A33:
;gearshift.c,221 :: 		GearShift_brake();
	CALL	_GearMotor_brake
;gearshift.c,222 :: 		GearShift_setNextStep_A(STEP_UP_END);
	MOV.B	#8, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,223 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_BRAKE));
	MOV.B	#3, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,224 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,225 :: 		case STEP_UP_END:
L_GearShift_nextStep_A34:
;gearshift.c,226 :: 		GearShift_free();
	CALL	_GearMotor_release
;gearshift.c,227 :: 		gearShift_isShiftingUp = FALSE;
	MOV	#lo_addr(_gearShift_isShiftingUp), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,228 :: 		gearShift_isSettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isSettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,229 :: 		gearShift_isUnsettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,230 :: 		Can_writeInt(GCU_CLUTCH_ID, 33);//Debug
	MOV	#33, W12
	MOV	#1559, W10
	MOV	#0, W11
	CALL	_Can_writeInt
;gearshift.c,231 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,233 :: 		case STEP_DOWN_START:
L_GearShift_nextStep_A35:
;gearshift.c,234 :: 		if (gearShift_isSettingNeutral  && Clutch_get() <= 80) {
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA NZ	L__GearShift_nextStep_A130
	GOTO	L__GearShift_nextStep_A89
L__GearShift_nextStep_A130:
	CALL	_Clutch_get
	MOV.B	#80, W1
	CP.B	W0, W1
	BRA LEU	L__GearShift_nextStep_A131
	GOTO	L__GearShift_nextStep_A88
L__GearShift_nextStep_A131:
L__GearShift_nextStep_A87:
;gearshift.c,235 :: 		Clutch_set(80);
	MOV.B	#80, W10
	CALL	_Clutch_set
;gearshift.c,236 :: 		} else {
	GOTO	L_GearShift_nextStep_A39
;gearshift.c,234 :: 		if (gearShift_isSettingNeutral  && Clutch_get() <= 80) {
L__GearShift_nextStep_A89:
L__GearShift_nextStep_A88:
;gearshift.c,238 :: 		if (!gearShift_isUnsettingNeutral && Clutch_get() <= 60) {
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__GearShift_nextStep_A132
	GOTO	L__GearShift_nextStep_A91
L__GearShift_nextStep_A132:
	CALL	_Clutch_get
	MOV.B	#60, W1
	CP.B	W0, W1
	BRA LEU	L__GearShift_nextStep_A133
	GOTO	L__GearShift_nextStep_A90
L__GearShift_nextStep_A133:
L__GearShift_nextStep_A86:
;gearshift.c,239 :: 		Clutch_set(60);
	MOV.B	#60, W10
	CALL	_Clutch_set
;gearshift.c,238 :: 		if (!gearShift_isUnsettingNeutral && Clutch_get() <= 60) {
L__GearShift_nextStep_A91:
L__GearShift_nextStep_A90:
;gearshift.c,241 :: 		Efi_setBlip();
	CALL	_Efi_setBlip
;gearshift.c,242 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;gearshift.c,243 :: 		}
L_GearShift_nextStep_A39:
;gearshift.c,244 :: 		GearShift_setNextStep_A(STEP_DOWN_PUSH);
	MOV.B	#5, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,245 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_START));
	MOV.B	#4, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,246 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,247 :: 		case STEP_DOWN_PUSH:
L_GearShift_nextStep_A43:
;gearshift.c,248 :: 		if (!gearShift_isSettingNeutral) {
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__GearShift_nextStep_A134
	GOTO	L_GearShift_nextStep_A44
L__GearShift_nextStep_A134:
;gearshift.c,249 :: 		Efi_unsetBlip();
	CALL	_Efi_unsetBlip
;gearshift.c,250 :: 		}
L_GearShift_nextStep_A44:
;gearshift.c,251 :: 		GearShift_downPush();
	CALL	_GearMotor_turnLeft
;gearshift.c,252 :: 		GearShift_setNextStep_A(STEP_DOWN_REBOUND);
	MOV.B	#6, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,253 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_PUSH));
	MOV.B	#5, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,254 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,255 :: 		case STEP_DOWN_REBOUND:
L_GearShift_nextStep_A45:
;gearshift.c,256 :: 		GearShift_rebound();
	CALL	_GearMotor_release
;gearshift.c,257 :: 		GearShift_setNextStep_A(STEP_DOWN_BRAKE);
	MOV.B	#7, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,258 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_REBOUND));
	MOV.B	#6, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,259 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,260 :: 		case STEP_DOWN_BRAKE:
L_GearShift_nextStep_A46:
;gearshift.c,261 :: 		if (Clutch_get() <= 81)
	CALL	_Clutch_get
	MOV.B	#81, W1
	CP.B	W0, W1
	BRA LEU	L__GearShift_nextStep_A135
	GOTO	L_GearShift_nextStep_A47
L__GearShift_nextStep_A135:
;gearshift.c,262 :: 		Clutch_release();
	CALL	_Clutch_release
L_GearShift_nextStep_A47:
;gearshift.c,263 :: 		GearShift_brake();
	CALL	_GearMotor_brake
;gearshift.c,264 :: 		GearShift_setNextStep_A(STEP_DOWN_END);
	MOV.B	#9, W10
	CALL	_GearShift_setNextStep_A
;gearshift.c,265 :: 		GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_BRAKE));
	MOV.B	#7, W10
	CALL	_Gearshift_get_time
	MOV	W0, W10
	CALL	_GearShift_setMsTicks_A
;gearshift.c,266 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,267 :: 		case STEP_DOWN_END:
L_GearShift_nextStep_A48:
;gearshift.c,268 :: 		GearShift_free();
	CALL	_GearMotor_release
;gearshift.c,269 :: 		gearShift_isShiftingDown = FALSE;
	MOV	#lo_addr(_gearShift_isShiftingDown), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,270 :: 		gearShift_isSettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isSettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,271 :: 		gearShift_isUnsettingNeutral = FALSE;
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W1
	CLR	W0
	MOV.B	W0, [W1]
;gearshift.c,272 :: 		Can_writeInt(GCU_CLUTCH_ID, 22);//Debug
	MOV	#22, W12
	MOV	#1559, W10
	MOV	#0, W11
	CALL	_Can_writeInt
;gearshift.c,273 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,274 :: 		default:
L_GearShift_nextStep_A49:
;gearshift.c,275 :: 		break;
	GOTO	L_GearShift_nextStep_A25
;gearshift.c,276 :: 		}
L_GearShift_nextStep_A24:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__GearShift_nextStep_A136
	GOTO	L_GearShift_nextStep_A26
L__GearShift_nextStep_A136:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__GearShift_nextStep_A137
	GOTO	L_GearShift_nextStep_A29
L__GearShift_nextStep_A137:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__GearShift_nextStep_A138
	GOTO	L_GearShift_nextStep_A31
L__GearShift_nextStep_A138:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__GearShift_nextStep_A139
	GOTO	L_GearShift_nextStep_A33
L__GearShift_nextStep_A139:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #8
	BRA NZ	L__GearShift_nextStep_A140
	GOTO	L_GearShift_nextStep_A34
L__GearShift_nextStep_A140:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__GearShift_nextStep_A141
	GOTO	L_GearShift_nextStep_A35
L__GearShift_nextStep_A141:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__GearShift_nextStep_A142
	GOTO	L_GearShift_nextStep_A43
L__GearShift_nextStep_A142:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__GearShift_nextStep_A143
	GOTO	L_GearShift_nextStep_A45
L__GearShift_nextStep_A143:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #7
	BRA NZ	L__GearShift_nextStep_A144
	GOTO	L_GearShift_nextStep_A46
L__GearShift_nextStep_A144:
	MOV	#lo_addr(_gearShift_nextStepValue_A), W0
	MOV.B	[W0], W0
	CP.B	W0, #9
	BRA NZ	L__GearShift_nextStep_A145
	GOTO	L_GearShift_nextStep_A48
L__GearShift_nextStep_A145:
	GOTO	L_GearShift_nextStep_A49
L_GearShift_nextStep_A25:
;gearshift.c,277 :: 		}
L_end_GearShift_nextStep_A:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _GearShift_nextStep_A

_GearShift_nextStep_B:

;gearshift.c,280 :: 		void GearShift_nextStep_B(void) {
;gearshift.c,281 :: 		switch (gearShift_nextStepValue_B) {
	GOTO	L_GearShift_nextStep_B50
;gearshift.c,282 :: 		default:
L_GearShift_nextStep_B52:
;gearshift.c,283 :: 		break;
	GOTO	L_GearShift_nextStep_B51
;gearshift.c,284 :: 		}
L_GearShift_nextStep_B50:
	GOTO	L_GearShift_nextStep_B52
L_GearShift_nextStep_B51:
;gearshift.c,285 :: 		}
L_end_GearShift_nextStep_B:
	RETURN
; end of _GearShift_nextStep_B

_GearShift_setMsTicks_A:

;gearshift.c,287 :: 		void GearShift_setMsTicks_A(unsigned int ticks) {
;gearshift.c,288 :: 		gearShift_ticksCounter1 = (int) ticks + 1;
	MOV	#lo_addr(_gearShift_ticksCounter1), W0
	ADD	W10, #1, [W0]
;gearshift.c,289 :: 		}
L_end_GearShift_setMsTicks_A:
	RETURN
; end of _GearShift_setMsTicks_A

_GearShift_setMsTicks_B:

;gearshift.c,291 :: 		void GearShift_setMsTicks_B(unsigned int ticks) {
;gearshift.c,292 :: 		gearShift_ticksCounter2 = (int) ticks + 1;
	MOV	#lo_addr(_gearShift_ticksCounter2), W0
	ADD	W10, #1, [W0]
;gearshift.c,293 :: 		}
L_end_GearShift_setMsTicks_B:
	RETURN
; end of _GearShift_setMsTicks_B

_GearShift_msTick:

;gearshift.c,295 :: 		void GearShift_msTick(void) {
;gearshift.c,296 :: 		gearShift_ticksCounter1 -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_gearShift_ticksCounter1), W0
	SUBR	W1, [W0], [W0]
;gearshift.c,297 :: 		if (gearShift_ticksCounter1 == 0) {
	MOV	_gearShift_ticksCounter1, W0
	CP	W0, #0
	BRA Z	L__GearShift_msTick150
	GOTO	L_GearShift_msTick53
L__GearShift_msTick150:
;gearshift.c,298 :: 		GearShift_nextStep_A();
	CALL	_GearShift_nextStep_A
;gearshift.c,299 :: 		} else if (gearShift_ticksCounter1 < 0) {
	GOTO	L_GearShift_msTick54
L_GearShift_msTick53:
	MOV	_gearShift_ticksCounter1, W0
	CP	W0, #0
	BRA LT	L__GearShift_msTick151
	GOTO	L_GearShift_msTick55
L__GearShift_msTick151:
;gearshift.c,300 :: 		gearShift_ticksCounter1 = 0;
	CLR	W0
	MOV	W0, _gearShift_ticksCounter1
;gearshift.c,301 :: 		}
L_GearShift_msTick55:
L_GearShift_msTick54:
;gearshift.c,303 :: 		gearShift_ticksCounter2 -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_gearShift_ticksCounter2), W0
	SUBR	W1, [W0], [W0]
;gearshift.c,304 :: 		if (gearShift_ticksCounter2 == 0) {
	MOV	_gearShift_ticksCounter2, W0
	CP	W0, #0
	BRA Z	L__GearShift_msTick152
	GOTO	L_GearShift_msTick56
L__GearShift_msTick152:
;gearshift.c,305 :: 		GearShift_nextStep_B();
	CALL	_GearShift_nextStep_B
;gearshift.c,306 :: 		} else if (gearShift_ticksCounter2 < 0) {
	GOTO	L_GearShift_msTick57
L_GearShift_msTick56:
	MOV	_gearShift_ticksCounter2, W0
	CP	W0, #0
	BRA LT	L__GearShift_msTick153
	GOTO	L_GearShift_msTick58
L__GearShift_msTick153:
;gearshift.c,307 :: 		gearShift_ticksCounter2 = 0;
	CLR	W0
	MOV	W0, _gearShift_ticksCounter2
;gearshift.c,308 :: 		}
L_GearShift_msTick58:
L_GearShift_msTick57:
;gearshift.c,309 :: 		}
L_end_GearShift_msTick:
	RETURN
; end of _GearShift_msTick

_Gearshift_get_time:

;gearshift.c,343 :: 		int Gearshift_get_time(shiftStep step)
;gearshift.c,345 :: 		if(gearShift_isSettingNeutral == TRUE){
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__Gearshift_get_time155
	GOTO	L_Gearshift_get_time59
L__Gearshift_get_time155:
;gearshift.c,346 :: 		switch(step){
	GOTO	L_Gearshift_get_time60
;gearshift.c,347 :: 		case STEP_UP_START:
L_Gearshift_get_time62:
;gearshift.c,348 :: 		return gearShift_timings[NT_CLUTCH_DELAY];
	MOV	_gearShift_timings+38, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,349 :: 		case STEP_UP_PUSH:
L_Gearshift_get_time63:
;gearshift.c,350 :: 		return gearShift_timings[NT_PUSH_1_N];
	MOV	_gearShift_timings, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,351 :: 		case STEP_UP_REBOUND:
L_Gearshift_get_time64:
;gearshift.c,352 :: 		return gearShift_timings[NT_REBOUND_1_N];
	MOV	_gearShift_timings+4, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,353 :: 		case STEP_UP_BRAKE:
L_Gearshift_get_time65:
;gearshift.c,354 :: 		return gearShift_timings[NT_BRAKE_1_N];
	MOV	_gearShift_timings+6, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,357 :: 		case STEP_DOWN_PUSH:
L_Gearshift_get_time66:
;gearshift.c,358 :: 		return gearShift_timings[NT_PUSH_2_N];
	MOV	_gearShift_timings+8, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,359 :: 		case STEP_DOWN_REBOUND:
L_Gearshift_get_time67:
;gearshift.c,360 :: 		return gearShift_timings[NT_REBOUND_2_N];
	MOV	_gearShift_timings+12, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,361 :: 		case STEP_DOWN_BRAKE:
L_Gearshift_get_time68:
;gearshift.c,362 :: 		return gearShift_timings[NT_BRAKE_2_N];
	MOV	_gearShift_timings+14, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,363 :: 		}
L_Gearshift_get_time60:
	CP.B	W10, #0
	BRA NZ	L__Gearshift_get_time156
	GOTO	L_Gearshift_get_time62
L__Gearshift_get_time156:
	CP.B	W10, #1
	BRA NZ	L__Gearshift_get_time157
	GOTO	L_Gearshift_get_time63
L__Gearshift_get_time157:
	CP.B	W10, #2
	BRA NZ	L__Gearshift_get_time158
	GOTO	L_Gearshift_get_time64
L__Gearshift_get_time158:
	CP.B	W10, #3
	BRA NZ	L__Gearshift_get_time159
	GOTO	L_Gearshift_get_time65
L__Gearshift_get_time159:
	CP.B	W10, #5
	BRA NZ	L__Gearshift_get_time160
	GOTO	L_Gearshift_get_time66
L__Gearshift_get_time160:
	CP.B	W10, #6
	BRA NZ	L__Gearshift_get_time161
	GOTO	L_Gearshift_get_time67
L__Gearshift_get_time161:
	CP.B	W10, #7
	BRA NZ	L__Gearshift_get_time162
	GOTO	L_Gearshift_get_time68
L__Gearshift_get_time162:
;gearshift.c,364 :: 		}
L_Gearshift_get_time59:
;gearshift.c,365 :: 		switch(step){
	GOTO	L_Gearshift_get_time69
;gearshift.c,366 :: 		case STEP_UP_START:
L_Gearshift_get_time71:
;gearshift.c,367 :: 		return gearShift_timings[DELAY];
	MOV	_gearShift_timings+32, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,370 :: 		case STEP_UP_PUSH:
L_Gearshift_get_time72:
;gearshift.c,371 :: 		switch(gearShift_currentGear){
	GOTO	L_Gearshift_get_time73
;gearshift.c,372 :: 		case 1:
L_Gearshift_get_time75:
;gearshift.c,373 :: 		return gearShift_timings[UP_PUSH_1_2];
	MOV	_gearShift_timings+24, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,374 :: 		case 2:
L_Gearshift_get_time76:
;gearshift.c,375 :: 		return gearShift_timings[UP_PUSH_2_3];
	MOV	_gearShift_timings+26, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,376 :: 		case 3:
L_Gearshift_get_time77:
;gearshift.c,377 :: 		return gearShift_timings[UP_PUSH_3_4];
	MOV	_gearShift_timings+28, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,378 :: 		case 4:
L_Gearshift_get_time78:
;gearshift.c,379 :: 		return gearShift_timings[UP_PUSH_4_5];
	MOV	_gearShift_timings+30, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,380 :: 		default:
L_Gearshift_get_time79:
;gearshift.c,381 :: 		return gearShift_timings[UP_PUSH_2_3];
	MOV	_gearShift_timings+26, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,382 :: 		}
L_Gearshift_get_time73:
	MOV	_gearShift_currentGear, W0
	CP	W0, #1
	BRA NZ	L__Gearshift_get_time163
	GOTO	L_Gearshift_get_time75
L__Gearshift_get_time163:
	MOV	_gearShift_currentGear, W0
	CP	W0, #2
	BRA NZ	L__Gearshift_get_time164
	GOTO	L_Gearshift_get_time76
L__Gearshift_get_time164:
	MOV	_gearShift_currentGear, W0
	CP	W0, #3
	BRA NZ	L__Gearshift_get_time165
	GOTO	L_Gearshift_get_time77
L__Gearshift_get_time165:
	MOV	_gearShift_currentGear, W0
	CP	W0, #4
	BRA NZ	L__Gearshift_get_time166
	GOTO	L_Gearshift_get_time78
L__Gearshift_get_time166:
	GOTO	L_Gearshift_get_time79
;gearshift.c,383 :: 		case STEP_UP_REBOUND:
L_Gearshift_get_time80:
;gearshift.c,384 :: 		return gearShift_timings[UP_REBOUND];
	MOV	_gearShift_timings+34, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,385 :: 		case STEP_UP_BRAKE:
L_Gearshift_get_time81:
;gearshift.c,386 :: 		return gearShift_timings[UP_BRAKE];
	MOV	_gearShift_timings+36, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,387 :: 		case STEP_DOWN_START:
L_Gearshift_get_time82:
;gearshift.c,388 :: 		return gearShift_timings[CLUTCH];
	MOV	_gearShift_timings+18, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,390 :: 		case STEP_DOWN_PUSH:
L_Gearshift_get_time83:
;gearshift.c,391 :: 		return gearShift_timings[DN_PUSH];
	MOV	_gearShift_timings+16, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,392 :: 		case STEP_DOWN_REBOUND:
L_Gearshift_get_time84:
;gearshift.c,393 :: 		return gearShift_timings[DN_REBOUND];
	MOV	_gearShift_timings+20, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,394 :: 		case STEP_DOWN_BRAKE:
L_Gearshift_get_time85:
;gearshift.c,395 :: 		return gearShift_timings[DN_BRAKE];
	MOV	_gearShift_timings+22, W0
	GOTO	L_end_Gearshift_get_time
;gearshift.c,396 :: 		}
L_Gearshift_get_time69:
	CP.B	W10, #0
	BRA NZ	L__Gearshift_get_time167
	GOTO	L_Gearshift_get_time71
L__Gearshift_get_time167:
	CP.B	W10, #1
	BRA NZ	L__Gearshift_get_time168
	GOTO	L_Gearshift_get_time72
L__Gearshift_get_time168:
	CP.B	W10, #2
	BRA NZ	L__Gearshift_get_time169
	GOTO	L_Gearshift_get_time80
L__Gearshift_get_time169:
	CP.B	W10, #3
	BRA NZ	L__Gearshift_get_time170
	GOTO	L_Gearshift_get_time81
L__Gearshift_get_time170:
	CP.B	W10, #4
	BRA NZ	L__Gearshift_get_time171
	GOTO	L_Gearshift_get_time82
L__Gearshift_get_time171:
	CP.B	W10, #5
	BRA NZ	L__Gearshift_get_time172
	GOTO	L_Gearshift_get_time83
L__Gearshift_get_time172:
	CP.B	W10, #6
	BRA NZ	L__Gearshift_get_time173
	GOTO	L_Gearshift_get_time84
L__Gearshift_get_time173:
	CP.B	W10, #7
	BRA NZ	L__Gearshift_get_time174
	GOTO	L_Gearshift_get_time85
L__Gearshift_get_time174:
;gearshift.c,397 :: 		}
L_end_Gearshift_get_time:
	RETURN
; end of _Gearshift_get_time

_GearShift_loadDefaultTimings:

;gearshift.c,399 :: 		void GearShift_loadDefaultTimings(void) {
;gearshift.c,400 :: 		gearShift_timings[DELAY] = DEFAULT_DELAY;
	MOV	#20, W0
	MOV	W0, _gearShift_timings+32
;gearshift.c,401 :: 		gearShift_timings[UP_REBOUND] = DEFAULT_UP_REBOUND;
	MOV	#15, W0
	MOV	W0, _gearShift_timings+34
;gearshift.c,402 :: 		gearShift_timings[UP_BRAKE] = DEFAULT_UP_BRAKE;
	MOV	#20, W0
	MOV	W0, _gearShift_timings+36
;gearshift.c,403 :: 		gearShift_timings[UP_PUSH_1_2] = DEFAULT_UP_PUSH_1_2;
	MOV	#115, W0
	MOV	W0, _gearShift_timings+24
;gearshift.c,404 :: 		gearShift_timings[UP_PUSH_2_3] = DEFAULT_UP_PUSH_2_3;
	MOV	#100, W0
	MOV	W0, _gearShift_timings+26
;gearshift.c,405 :: 		gearShift_timings[UP_PUSH_3_4] = DEFAULT_UP_PUSH_3_4;
	MOV	#100, W0
	MOV	W0, _gearShift_timings+28
;gearshift.c,406 :: 		gearShift_timings[UP_PUSH_4_5] = DEFAULT_UP_PUSH_4_5;
	MOV	#100, W0
	MOV	W0, _gearShift_timings+30
;gearshift.c,408 :: 		gearShift_timings[CLUTCH] = DEFAULT_CLUTCH;
	MOV	#70, W0
	MOV	W0, _gearShift_timings+18
;gearshift.c,409 :: 		gearShift_timings[DN_PUSH] = DEFAULT_DN_PUSH;
	MOV	#100, W0
	MOV	W0, _gearShift_timings+16
;gearshift.c,410 :: 		gearShift_timings[DN_BRAKE] = DEFAULT_DN_BRAKE;
	MOV	#15, W0
	MOV	W0, _gearShift_timings+22
;gearshift.c,411 :: 		gearShift_timings[DN_REBOUND] = DEFAULT_DN_REBOUND;
	MOV	#20, W0
	MOV	W0, _gearShift_timings+20
;gearshift.c,413 :: 		gearShift_timings[NT_CLUTCH_DELAY] = DEFAULT_NT_CLUTCH_DELAY;
	MOV	#20, W0
	MOV	W0, _gearShift_timings+38
;gearshift.c,414 :: 		gearShift_timings[NT_REBOUND_1_N] = DEFAULT_NT_REBOUND_1_N;
	MOV	#15, W0
	MOV	W0, _gearShift_timings+4
;gearshift.c,415 :: 		gearShift_timings[NT_REBOUND_2_N] = DEFAULT_NT_REBOUND_2_N;
	MOV	#15, W0
	MOV	W0, _gearShift_timings+12
;gearshift.c,416 :: 		gearShift_timings[NT_BRAKE_1_N] = DEFAULT_NT_BRAKE_1_N;
	MOV	#35, W0
	MOV	W0, _gearShift_timings+6
;gearshift.c,417 :: 		gearShift_timings[NT_BRAKE_2_N] = DEFAULT_NT_BRAKE_2_N;
	MOV	#35, W0
	MOV	W0, _gearShift_timings+14
;gearshift.c,418 :: 		gearShift_timings[NT_PUSH_1_N] = DEFAULT_NT_PUSH_1_N;
	MOV	#22, W0
	MOV	W0, _gearShift_timings
;gearshift.c,419 :: 		gearShift_timings[NT_PUSH_2_N] = DEFAULT_NT_PUSH_2_N;
	MOV	#25, W0
	MOV	W0, _gearShift_timings+8
;gearshift.c,420 :: 		gearShift_timings[NT_CLUTCH_1_N] = DEFAULT_NT_CLUTCH_1_N;
	MOV	#300, W0
	MOV	W0, _gearShift_timings+2
;gearshift.c,421 :: 		gearShift_timings[NT_CLUTCH_2_N] = DEFAULT_NT_CLUTCH_2_N;
	MOV	#300, W0
	MOV	W0, _gearShift_timings+10
;gearshift.c,424 :: 		gearShift_timings[DOWN_TIME_CHECK] = DEFAULT_DOWN_TIME_CHECK;
	MOV	#500, W0
	MOV	W0, _gearShift_timings+40
;gearshift.c,425 :: 		gearShift_timings[UP_TIME_CHECK] = DEFAULT_UP_TIME_CHECK;
	MOV	#500, W0
	MOV	W0, _gearShift_timings+42
;gearshift.c,426 :: 		gearShift_timings[MAX_TRIES] = DEFAULT_MAX_TRIES;
	MOV	#2, W0
	MOV	W0, _gearShift_timings+44
;gearshift.c,427 :: 		}
L_end_GearShift_loadDefaultTimings:
	RETURN
; end of _GearShift_loadDefaultTimings
