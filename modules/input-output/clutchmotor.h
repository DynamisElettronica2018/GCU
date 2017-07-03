//
// Created by Aaron Russo on 16/07/16.
//

#ifndef FIRMWARE_CLUTCHMOTOR_H
#define FIRMWARE_CLUTCHMOTOR_H

#define CLUTCHMOTOR_PWM_PERIOD 0.020
//1% = 0.2ms
#define CLUTCHMOTOR_MAX_PWM_PERCENTAGE 11
#define CLUTCHMOTOR_MIN_PWM_PERCENTAGE  5

#include "basic.h"
#include "dspic.h"

void ClutchMotor_init(void);

void ClutchMotor_setupPWM(void);

void ClutchMotor_setPosition(unsigned char percentage);

#endif //FIRMWARE_CLUTCHMOTOR_H