//
// Created by Aaron Russo on 16/07/16.
//

#ifndef FIRMWARE_GEARMOTOR_H
#define FIRMWARE_GEARMOTOR_H

#include "basic.h"
#include "dspic.h"

#define GEARMOTOR_IN1_Pin   LATC1_bit
#define GEARMOTOR_IN2_Pin   LATB0_bit
#define GEARMOTOR_INH_Pin   LATB1_bit
#define GEARMOTOR_IN1_Direction TRISC1_bit
#define GEARMOTOR_IN2_Direction TRISB0_bit
#define GEARMOTOR_INH_Direction TRISB1_bit

void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);

#endif //FIRMWARE_GEARMOTOR_H