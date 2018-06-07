
_GearMotor_init:

;gearmotor.c,7 :: 		void GearMotor_init(void) {
;gearmotor.c,8 :: 		GEARMOTOR_IN1_Direction = OUTPUT;
	BCLR	TRISB0_bit, BitPos(TRISB0_bit+0)
;gearmotor.c,9 :: 		GEARMOTOR_IN2_Direction = OUTPUT;
	BCLR	TRISC1_bit, BitPos(TRISC1_bit+0)
;gearmotor.c,10 :: 		GEARMOTOR_INH_Direction = OUTPUT;
	BCLR	TRISB1_bit, BitPos(TRISB1_bit+0)
;gearmotor.c,11 :: 		GearMotor_release();
	CALL	_GearMotor_release
;gearmotor.c,12 :: 		}
L_end_GearMotor_init:
	RETURN
; end of _GearMotor_init

_GearMotor_turnLeft:

;gearmotor.c,14 :: 		void GearMotor_turnLeft(void) {
;gearmotor.c,15 :: 		GEARMOTOR_IN1_Pin = 0;
	BCLR	LATB0_bit, BitPos(LATB0_bit+0)
;gearmotor.c,16 :: 		GEARMOTOR_IN2_Pin = 1;
	BSET	LATC1_bit, BitPos(LATC1_bit+0)
;gearmotor.c,17 :: 		GEARMOTOR_INH_Pin = 1;
	BSET	LATB1_bit, BitPos(LATB1_bit+0)
;gearmotor.c,18 :: 		}
L_end_GearMotor_turnLeft:
	RETURN
; end of _GearMotor_turnLeft

_GearMotor_turnRight:

;gearmotor.c,20 :: 		void GearMotor_turnRight(void) {
;gearmotor.c,21 :: 		GEARMOTOR_IN1_Pin = 1;
	BSET	LATB0_bit, BitPos(LATB0_bit+0)
;gearmotor.c,22 :: 		GEARMOTOR_IN2_Pin = 0;
	BCLR	LATC1_bit, BitPos(LATC1_bit+0)
;gearmotor.c,23 :: 		GEARMOTOR_INH_Pin = 1;
	BSET	LATB1_bit, BitPos(LATB1_bit+0)
;gearmotor.c,24 :: 		}
L_end_GearMotor_turnRight:
	RETURN
; end of _GearMotor_turnRight

_GearMotor_brake:

;gearmotor.c,26 :: 		void GearMotor_brake(void) {
;gearmotor.c,27 :: 		GEARMOTOR_IN1_Pin = 0;
	BCLR	LATB0_bit, BitPos(LATB0_bit+0)
;gearmotor.c,28 :: 		GEARMOTOR_IN2_Pin = 0;
	BCLR	LATC1_bit, BitPos(LATC1_bit+0)
;gearmotor.c,29 :: 		GEARMOTOR_INH_Pin = 1;
	BSET	LATB1_bit, BitPos(LATB1_bit+0)
;gearmotor.c,30 :: 		}
L_end_GearMotor_brake:
	RETURN
; end of _GearMotor_brake

_GearMotor_release:

;gearmotor.c,32 :: 		void GearMotor_release(void) {
;gearmotor.c,33 :: 		GEARMOTOR_INH_Pin = 0;
	BCLR	LATB1_bit, BitPos(LATB1_bit+0)
;gearmotor.c,34 :: 		}
L_end_GearMotor_release:
	RETURN
; end of _GearMotor_release
