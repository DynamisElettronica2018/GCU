//
// Created by Aaron Russo on 15/07/16.
//

#ifndef FIRMWARE_STOPLIGHT_H
#define FIRMWARE_STOPLIGHT_H

#define STOPLIGHT_PWM_PERIOD 0.020    //UGUALE AL PERIODO DEL SEGNALE DEL SERVO, USO STESSO TIMER

#include "basic.h"
#include "dspic.h"

#define STOPLIGHT_CTRL_Pin   LATD6_bit
#define STOPLIGHT_PWM_PERCENTAGE 85


void StopLight_init(void);

void StopLight_setupPWM(void);

void StopLight_setBrightness(unsigned char percentage);

#endif //FIRMWARE_STOPLIGHT_H