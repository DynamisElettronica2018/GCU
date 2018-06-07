
_Sensors_init:

;sensors.c,26 :: 		void Sensors_init(void) {
;sensors.c,27 :: 		setupAnalogSampling();
	PUSH	W10
	CALL	_setupAnalogSampling
;sensors.c,28 :: 		setAnalogPIN(SENSORS[sensors_pinIndex]);
	MOV	#lo_addr(_sensors_pinIndex), W0
	ZE	[W0], W1
	MOV	#lo_addr(_SENSORS), W0
	ADD	W0, W1, W1
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W10
	CALL	_setAnalogPIN
;sensors.c,29 :: 		turnOnAnalogModule();
	CALL	_turnOnAnalogModule
;sensors.c,30 :: 		}
L_end_Sensors_init:
	POP	W10
	RETURN
; end of _Sensors_init

_Sensors_send:

;sensors.c,32 :: 		void Sensors_send(void) {
;sensors.c,33 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;sensors.c,34 :: 		Can_addIntToWritePacket(sensors_fanCurrent);
	MOV	_sensors_fanCurrent, W10
	CALL	_Can_addIntToWritePacket
;sensors.c,35 :: 		Can_addIntToWritePacket(sensors_fuelPumpCurrent);
	MOV	_sensors_fuelPumpCurrent, W10
	CALL	_Can_addIntToWritePacket
;sensors.c,36 :: 		Can_addIntToWritePacket(sensors_GCUTemp);
	MOV	_sensors_GCUTemp, W10
	CALL	_Can_addIntToWritePacket
;sensors.c,37 :: 		Can_addIntToWritePacket(sensors_H2OPumpCurrent);
	MOV	_sensors_H2OPumpCurrent, W10
	CALL	_Can_addIntToWritePacket
;sensors.c,38 :: 		Can_write(GCU_SENSE_ID);
	MOV	#1742, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors.c,39 :: 		}
L_end_Sensors_send:
	POP	W11
	POP	W10
	RETURN
; end of _Sensors_send

_Sensors_tick:

;sensors.c,41 :: 		void Sensors_tick(void) {
;sensors.c,42 :: 		Sensors_read();
	CALL	_Sensors_read
;sensors.c,43 :: 		Sensors_nextPin();
	CALL	_Sensors_nextPin
;sensors.c,44 :: 		}
L_end_Sensors_tick:
	RETURN
; end of _Sensors_tick

_Sensors_read:
	LNK	#2

;sensors.c,46 :: 		void Sensors_read(void) {
;sensors.c,48 :: 		analogValue = getAnalogValue();
	PUSH	W10
	CALL	_getAnalogValue
; analogValue start address is: 4 (W2)
	MOV	W0, W2
;sensors.c,49 :: 		switch (SENSORS[sensors_pinIndex]) {
	MOV	#lo_addr(_sensors_pinIndex), W0
	ZE	[W0], W1
	MOV	#lo_addr(_SENSORS), W0
	ADD	W0, W1, W0
	MOV	W0, [W14+0]
	GOTO	L_Sensors_read0
;sensors.c,50 :: 		case FAN_CURRENT_Pin:
L_Sensors_read2:
;sensors.c,51 :: 		Sensors_sampleFanCurrent(analogValue);
	MOV	W2, W10
; analogValue end address is: 4 (W2)
	CALL	_Sensors_sampleFanCurrent
;sensors.c,52 :: 		break;
	GOTO	L_Sensors_read1
;sensors.c,53 :: 		case H2O_PUMP_CURRENT_Pin:
L_Sensors_read3:
;sensors.c,54 :: 		Sensors_sampleH2OPumpCurrent(analogValue);
; analogValue start address is: 4 (W2)
	MOV	W2, W10
; analogValue end address is: 4 (W2)
	CALL	_Sensors_sampleH2OPumpCurrent
;sensors.c,55 :: 		break;
	GOTO	L_Sensors_read1
;sensors.c,56 :: 		case FUEL_PUMP_CURRENT_Pin:
L_Sensors_read4:
;sensors.c,57 :: 		Sensors_sampleFuelPumpCurrent(analogValue);
; analogValue start address is: 4 (W2)
	MOV	W2, W10
; analogValue end address is: 4 (W2)
	CALL	_Sensors_sampleFuelPumpCurrent
;sensors.c,58 :: 		break;
	GOTO	L_Sensors_read1
;sensors.c,59 :: 		case GCU_TEMP_Pin:
L_Sensors_read5:
;sensors.c,60 :: 		Sensors_sampleGCUTemp(analogValue);
; analogValue start address is: 4 (W2)
	MOV	W2, W10
; analogValue end address is: 4 (W2)
	CALL	_Sensors_sampleGCUTemp
;sensors.c,61 :: 		break;
	GOTO	L_Sensors_read1
;sensors.c,62 :: 		default:
L_Sensors_read6:
;sensors.c,63 :: 		break;
	GOTO	L_Sensors_read1
;sensors.c,64 :: 		}
L_Sensors_read0:
; analogValue start address is: 4 (W2)
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV	[W14+0], W1
	MOV.B	[W1], W0
	CP.B	W0, #5
	BRA NZ	L__Sensors_read12
	GOTO	L_Sensors_read2
L__Sensors_read12:
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W0
	CP.B	W0, #4
	BRA NZ	L__Sensors_read13
	GOTO	L_Sensors_read3
L__Sensors_read13:
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W0
	CP.B	W0, #3
	BRA NZ	L__Sensors_read14
	GOTO	L_Sensors_read4
L__Sensors_read14:
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W0
	CP.B	W0, #2
	BRA NZ	L__Sensors_read15
	GOTO	L_Sensors_read5
L__Sensors_read15:
; analogValue end address is: 4 (W2)
	GOTO	L_Sensors_read6
L_Sensors_read1:
;sensors.c,65 :: 		}
L_end_Sensors_read:
	POP	W10
	ULNK
	RETURN
; end of _Sensors_read

_Sensors_nextPin:

;sensors.c,67 :: 		void Sensors_nextPin(void) {
;sensors.c,68 :: 		unsetAnalogPIN(SENSORS[sensors_pinIndex]);
	PUSH	W10
	MOV	#lo_addr(_sensors_pinIndex), W0
	ZE	[W0], W1
	MOV	#lo_addr(_SENSORS), W0
	ADD	W0, W1, W1
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W10
	CALL	_unsetAnalogPIN
;sensors.c,69 :: 		sensors_pinIndex += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_sensors_pinIndex), W0
	ADD.B	W1, [W0], [W0]
;sensors.c,70 :: 		if (sensors_pinIndex == sizeof(SENSORS)) {
	MOV	#lo_addr(_sensors_pinIndex), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA Z	L__Sensors_nextPin17
	GOTO	L_Sensors_nextPin7
L__Sensors_nextPin17:
;sensors.c,71 :: 		sensors_pinIndex = 0;
	MOV	#lo_addr(_sensors_pinIndex), W1
	CLR	W0
	MOV.B	W0, [W1]
;sensors.c,72 :: 		}
L_Sensors_nextPin7:
;sensors.c,73 :: 		setAnalogPIN(SENSORS[sensors_pinIndex]);
	MOV	#lo_addr(_sensors_pinIndex), W0
	ZE	[W0], W1
	MOV	#lo_addr(_SENSORS), W0
	ADD	W0, W1, W1
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W10
	CALL	_setAnalogPIN
;sensors.c,74 :: 		}
L_end_Sensors_nextPin:
	POP	W10
	RETURN
; end of _Sensors_nextPin

_Sensors_sampleFanCurrent:
	LNK	#4

;sensors.c,76 :: 		void Sensors_sampleFanCurrent(unsigned int value) {
;sensors.c,77 :: 		sensors_fanCurrent = sensors_fanCurrent * 0.95 + value * 0.05;
	PUSH	W10
	MOV	_sensors_fanCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	POP	W10
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_fanCurrent
;sensors.c,78 :: 		}
L_end_Sensors_sampleFanCurrent:
	ULNK
	RETURN
; end of _Sensors_sampleFanCurrent

_Sensors_sampleH2OPumpCurrent:
	LNK	#4

;sensors.c,80 :: 		void Sensors_sampleH2OPumpCurrent(unsigned int value) {
;sensors.c,92 :: 		sensors_H2OPumpCurrent = sensors_H2OPumpCurrent * 0.95 + value * 0.05;
	PUSH	W10
	MOV	_sensors_H2OPumpCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	POP	W10
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_H2OPumpCurrent
;sensors.c,93 :: 		}
L_end_Sensors_sampleH2OPumpCurrent:
	ULNK
	RETURN
; end of _Sensors_sampleH2OPumpCurrent

_Sensors_sampleFuelPumpCurrent:
	LNK	#4

;sensors.c,95 :: 		void Sensors_sampleFuelPumpCurrent(unsigned int value) {
;sensors.c,107 :: 		sensors_fuelPumpCurrent = sensors_fuelPumpCurrent * 0.95 + value * 0.05;
	PUSH	W10
	MOV	_sensors_fuelPumpCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	POP	W10
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_fuelPumpCurrent
;sensors.c,108 :: 		}
L_end_Sensors_sampleFuelPumpCurrent:
	ULNK
	RETURN
; end of _Sensors_sampleFuelPumpCurrent

_Sensors_sampleGCUTemp:
	LNK	#4

;sensors.c,110 :: 		void Sensors_sampleGCUTemp(unsigned int value) {
;sensors.c,111 :: 		sensors_GCUTemp = sensors_GCUTemp * 0.95 + value * 0.05;
	PUSH	W10
	MOV	_sensors_GCUTemp, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	POP	W10
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_GCUTemp
;sensors.c,112 :: 		}
L_end_Sensors_sampleGCUTemp:
	ULNK
	RETURN
; end of _Sensors_sampleGCUTemp
