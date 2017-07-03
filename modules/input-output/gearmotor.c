//
// Created by Aaron Russo on 16/07/16.
//

#include "gearmotor.h"

void GearMotor_init(void) {
    GEARMOTOR_IN1_Direction = OUTPUT;
    GEARMOTOR_IN2_Direction = OUTPUT;
    GEARMOTOR_INH_Direction = OUTPUT;
    GearMotor_release();
}

void GearMotor_turnLeft(void) {
    GEARMOTOR_IN1_Pin = 0;
    GEARMOTOR_IN2_Pin = 1;
    GEARMOTOR_INH_Pin = 1;
}

void GearMotor_turnRight(void) {
    GEARMOTOR_IN1_Pin = 1;
    GEARMOTOR_IN2_Pin = 0;
    GEARMOTOR_INH_Pin = 1;
}

void GearMotor_brake(void) {
    GEARMOTOR_IN1_Pin = 0;
    GEARMOTOR_IN2_Pin = 0;
    GEARMOTOR_INH_Pin = 1;
}

void GearMotor_release(void) {
    GEARMOTOR_INH_Pin = 0;
}