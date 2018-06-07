
_Can_init:

;can.c,35 :: 		void Can_init() {
;can.c,36 :: 		unsigned int Can_Init_flags = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
;can.c,43 :: 		CAN1Initialize(2, 4, 3, 4, 2, Can_Init_flags);          // SJW,BRP,PHSEG1,PHSEG2,PROPSEG
	MOV	#4, W13
	MOV	#3, W12
	MOV	#4, W11
	MOV	#2, W10
	MOV	#251, W0
	PUSH	W0
	MOV	#2, W0
	PUSH	W0
	CALL	_CAN1Initialize
	SUB	#4, W15
;can.c,44 :: 		CAN1SetOperationMode(_CAN_MODE_CONFIG, 0xFF);
	MOV	#255, W11
	MOV	#4, W10
	CALL	_CAN1SetOperationMode
;can.c,53 :: 		CAN1SetMask(_CAN_MASK_B1, 0, _CAN_CONFIG_MATCH_MSG_TYPE & _CAN_CONFIG_STD_MSG);
	MOV	#255, W13
	CLR	W11
	CLR	W12
	CLR	W10
	CALL	_CAN1SetMask
;can.c,54 :: 		CAN1SetFilter(_CAN_FILTER_B1_F1, 0, _CAN_CONFIG_STD_MSG);
	MOV	#255, W13
	CLR	W11
	CLR	W12
	CLR	W10
	CALL	_CAN1SetFilter
;can.c,55 :: 		CAN1SetFilter(_CAN_FILTER_B1_F2, 0, _CAN_CONFIG_STD_MSG);
	MOV	#255, W13
	CLR	W11
	CLR	W12
	MOV	#1, W10
	CALL	_CAN1SetFilter
;can.c,57 :: 		CAN1SetMask(_CAN_MASK_B2, 0, _CAN_CONFIG_MATCH_MSG_TYPE & _CAN_CONFIG_STD_MSG);
	MOV	#255, W13
	CLR	W11
	CLR	W12
	MOV	#1, W10
	CALL	_CAN1SetMask
;can.c,58 :: 		CAN1SetFilter(_CAN_FILTER_B2_F1, 0, _CAN_CONFIG_STD_MSG);
	MOV	#255, W13
	CLR	W11
	CLR	W12
	MOV	#2, W10
	CALL	_CAN1SetFilter
;can.c,60 :: 		CAN1SetOperationMode(_CAN_MODE_NORMAL, 0xFF);
	MOV	#255, W11
	CLR	W10
	CALL	_CAN1SetOperationMode
;can.c,62 :: 		Delay_ms(250);
	MOV	#26, W8
	MOV	#28274, W7
L_Can_init0:
	DEC	W7
	BRA NZ	L_Can_init0
	DEC	W8
	BRA NZ	L_Can_init0
;can.c,64 :: 		Can_initInterrupt();
	CALL	_Can_initInterrupt
;can.c,65 :: 		Can_setWritePriority(CAN_PRIORITY_MEDIUM);
	MOV	#253, W10
	CALL	_Can_setWritePriority
;can.c,66 :: 		}
L_end_Can_init:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _Can_init

_Can_read:

;can.c,68 :: 		void Can_read(unsigned long int *id, char dataBuffer[], unsigned int *dataLength, unsigned int *inFlags) {
;can.c,69 :: 		if (Can_B0hasBeenReceived()) {
	CALL	_Can_B0hasBeenReceived
	CP0.B	W0
	BRA NZ	L__Can_read19
	GOTO	L_Can_read2
L__Can_read19:
;can.c,70 :: 		Can_clearB0Flag();
	CALL	_Can_clearB0Flag
;can.c,71 :: 		Can1Read(id, dataBuffer, dataLength, inFlags);
	CALL	_CAN1Read
;can.c,72 :: 		}
	GOTO	L_Can_read3
L_Can_read2:
;can.c,73 :: 		else if (Can_B1hasBeenReceived()) {
	CALL	_Can_B1hasBeenReceived
	CP0.B	W0
	BRA NZ	L__Can_read20
	GOTO	L_Can_read4
L__Can_read20:
;can.c,74 :: 		Can_clearB1Flag();
	CALL	_Can_clearB1Flag
;can.c,75 :: 		Can1Read(id, dataBuffer, dataLength, inFlags);
	CALL	_CAN1Read
;can.c,76 :: 		}
L_Can_read4:
L_Can_read3:
;can.c,77 :: 		}
L_end_Can_read:
	RETURN
; end of _Can_read

_Can_writeByte:

;can.c,79 :: 		void Can_writeByte(unsigned long int id, unsigned char dataOut) {
;can.c,80 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;can.c,81 :: 		Can_addByteToWritePacket(dataOut);
	PUSH.D	W10
	MOV.B	W12, W10
	CALL	_Can_addByteToWritePacket
	POP.D	W10
;can.c,82 :: 		Can_write(id);
	CALL	_Can_write
;can.c,83 :: 		}
L_end_Can_writeByte:
	RETURN
; end of _Can_writeByte

_Can_writeInt:

;can.c,85 :: 		void Can_writeInt(unsigned long int id, int dataOut) {
;can.c,86 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;can.c,87 :: 		Can_addIntToWritePacket(dataOut);
	PUSH.D	W10
	MOV	W12, W10
	CALL	_Can_addIntToWritePacket
	POP.D	W10
;can.c,88 :: 		Can_write(id);
	CALL	_Can_write
;can.c,89 :: 		}
L_end_Can_writeInt:
	RETURN
; end of _Can_writeInt

_Can_addIntToWritePacket:

;can.c,91 :: 		void Can_addIntToWritePacket(int dataOut) {
;can.c,92 :: 		Can_addByteToWritePacket((unsigned char) (dataOut >> 8));
	PUSH	W10
	ASR	W10, #8, W0
	PUSH	W10
	MOV.B	W0, W10
	CALL	_Can_addByteToWritePacket
	POP	W10
;can.c,93 :: 		Can_addByteToWritePacket((unsigned char) (dataOut & 0xFF));
	MOV	#255, W0
	AND	W10, W0, W0
	MOV.B	W0, W10
	CALL	_Can_addByteToWritePacket
;can.c,94 :: 		}
L_end_Can_addIntToWritePacket:
	POP	W10
	RETURN
; end of _Can_addIntToWritePacket

_Can_addByteToWritePacket:

;can.c,96 :: 		void Can_addByteToWritePacket(unsigned char dataOut) {
;can.c,97 :: 		can_dataOutBuffer[can_dataOutLength] = dataOut;
	MOV	#lo_addr(_can_dataOutBuffer), W1
	MOV	#lo_addr(_can_dataOutLength), W0
	ADD	W1, [W0], W0
	MOV.B	W10, [W0]
;can.c,98 :: 		can_dataOutLength += 1;
	MOV	#1, W1
	MOV	#lo_addr(_can_dataOutLength), W0
	ADD	W1, [W0], [W0]
;can.c,99 :: 		}
L_end_Can_addByteToWritePacket:
	RETURN
; end of _Can_addByteToWritePacket

_Can_write:

;can.c,101 :: 		unsigned int Can_write(unsigned long int id) {
;can.c,102 :: 		unsigned int sent, i = 0;
	PUSH	W12
	PUSH	W13
; i start address is: 14 (W7)
	CLR	W7
; i end address is: 14 (W7)
;can.c,103 :: 		do {
L_Can_write5:
;can.c,104 :: 		sent = CAN1Write(id, can_dataOutBuffer, CAN_PACKET_SIZE, Can_getWriteFlags());
; i start address is: 14 (W7)
	CALL	_Can_getWriteFlags
	PUSH.D	W10
	MOV	#8, W13
	MOV	#lo_addr(_can_dataOutBuffer), W12
	PUSH	W0
	CALL	_CAN1Write
	SUB	#2, W15
	POP.D	W10
;can.c,105 :: 		i += 1;
	INC	W7
;can.c,106 :: 		} while ((sent == 0) && (i < CAN_RETRY_LIMIT));
	CP	W0, #0
	BRA Z	L__Can_write26
	GOTO	L__Can_write16
L__Can_write26:
	CP	W7, #5
	BRA LTU	L__Can_write27
	GOTO	L__Can_write15
L__Can_write27:
	GOTO	L_Can_write5
L__Can_write16:
L__Can_write15:
;can.c,107 :: 		if (i == CAN_RETRY_LIMIT) {
	CP	W7, #5
	BRA Z	L__Can_write28
	GOTO	L_Can_write10
L__Can_write28:
; i end address is: 14 (W7)
;can.c,108 :: 		can_err++;
	MOV	#1, W1
	MOV	#lo_addr(_can_err), W0
	ADD	W1, [W0], [W0]
;can.c,109 :: 		return -1;
	MOV	#65535, W0
	GOTO	L_end_Can_write
;can.c,110 :: 		}
L_Can_write10:
;can.c,111 :: 		return i;
; i start address is: 14 (W7)
	MOV	W7, W0
; i end address is: 14 (W7)
;can.c,112 :: 		}
;can.c,111 :: 		return i;
;can.c,112 :: 		}
L_end_Can_write:
	POP	W13
	POP	W12
	RETURN
; end of _Can_write

_Can_setWritePriority:

;can.c,114 :: 		void Can_setWritePriority(unsigned int txPriority) {
;can.c,115 :: 		can_txPriority = txPriority;
	MOV	W10, _can_txPriority
;can.c,116 :: 		}
L_end_Can_setWritePriority:
	RETURN
; end of _Can_setWritePriority

_Can_resetWritePacket:

;can.c,118 :: 		void Can_resetWritePacket(void) {
;can.c,119 :: 		for (can_dataOutLength = 0; can_dataOutLength < CAN_PACKET_SIZE; can_dataOutLength += 1) {
	CLR	W0
	MOV	W0, _can_dataOutLength
L_Can_resetWritePacket11:
	MOV	_can_dataOutLength, W0
	CP	W0, #8
	BRA LTU	L__Can_resetWritePacket31
	GOTO	L_Can_resetWritePacket12
L__Can_resetWritePacket31:
;can.c,120 :: 		can_dataOutBuffer[can_dataOutLength] = 0;
	MOV	#lo_addr(_can_dataOutBuffer), W1
	MOV	#lo_addr(_can_dataOutLength), W0
	ADD	W1, [W0], W1
	CLR	W0
	MOV.B	W0, [W1]
;can.c,119 :: 		for (can_dataOutLength = 0; can_dataOutLength < CAN_PACKET_SIZE; can_dataOutLength += 1) {
	MOV	#1, W1
	MOV	#lo_addr(_can_dataOutLength), W0
	ADD	W1, [W0], [W0]
;can.c,121 :: 		}
	GOTO	L_Can_resetWritePacket11
L_Can_resetWritePacket12:
;can.c,122 :: 		can_dataOutLength = 0;
	CLR	W0
	MOV	W0, _can_dataOutLength
;can.c,123 :: 		}
L_end_Can_resetWritePacket:
	RETURN
; end of _Can_resetWritePacket

_Can_getWriteFlags:

;can.c,125 :: 		unsigned int Can_getWriteFlags(void) {
;can.c,126 :: 		return CAN_DEFAULT_FLAGS & can_txPriority;
	MOV	#255, W1
	MOV	#lo_addr(_can_txPriority), W0
	AND	W1, [W0], W0
;can.c,127 :: 		}
L_end_Can_getWriteFlags:
	RETURN
; end of _Can_getWriteFlags

_Can_B0hasBeenReceived:

;can.c,129 :: 		unsigned char Can_B0hasBeenReceived(void) {
;can.c,130 :: 		return CAN_INTERRUPT_ONB0_OCCURRED == 1;
	CLR.B	W0
	BTSC	C1INTFbits, #0
	INC.B	W0
	CP.B	W0, #1
	CLR.B	W0
	BRA NZ	L__Can_B0hasBeenReceived34
	INC.B	W0
L__Can_B0hasBeenReceived34:
;can.c,131 :: 		}
L_end_Can_B0hasBeenReceived:
	RETURN
; end of _Can_B0hasBeenReceived

_Can_B1hasBeenReceived:

;can.c,133 :: 		unsigned char Can_B1hasBeenReceived(void) {
;can.c,134 :: 		return CAN_INTERRUPT_ONB1_OCCURRED == 1;
	CLR.B	W0
	BTSC	C1INTFbits, #1
	INC.B	W0
	CP.B	W0, #1
	CLR.B	W0
	BRA NZ	L__Can_B1hasBeenReceived36
	INC.B	W0
L__Can_B1hasBeenReceived36:
;can.c,135 :: 		}
L_end_Can_B1hasBeenReceived:
	RETURN
; end of _Can_B1hasBeenReceived

_Can_clearB0Flag:

;can.c,137 :: 		void Can_clearB0Flag(void) {
;can.c,138 :: 		CAN_INTERRUPT_ONB0_OCCURRED = 0;
	BCLR	C1INTFbits, #0
;can.c,139 :: 		}
L_end_Can_clearB0Flag:
	RETURN
; end of _Can_clearB0Flag

_Can_clearB1Flag:

;can.c,141 :: 		void Can_clearB1Flag(void) {
;can.c,142 :: 		CAN_INTERRUPT_ONB1_OCCURRED = 0;
	BCLR	C1INTFbits, #1
;can.c,143 :: 		}
L_end_Can_clearB1Flag:
	RETURN
; end of _Can_clearB1Flag

_Can_clearInterrupt:

;can.c,145 :: 		void Can_clearInterrupt(void) {
;can.c,146 :: 		CAN_INTERRUPT_OCCURRED = 0;
	BCLR	IFS1bits, #11
;can.c,147 :: 		}
L_end_Can_clearInterrupt:
	RETURN
; end of _Can_clearInterrupt

_Can_initInterrupt:

;can.c,149 :: 		void Can_initInterrupt(void) {
;can.c,156 :: 		IEC1BITS.C1IE = 1;
	BSET	IEC1bits, #11
;can.c,157 :: 		C1INTEBITS.RXB0IE = 1;
	BSET.B	C1INTEbits, #0
;can.c,158 :: 		C1INTEBITS.RXB1IE = 1;
	BSET.B	C1INTEbits, #1
;can.c,160 :: 		}
L_end_Can_initInterrupt:
	RETURN
; end of _Can_initInterrupt
