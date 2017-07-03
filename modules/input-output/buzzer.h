//
// Created by Aaron Russo on 02/08/16.
//

#ifndef FIRMWARE_BUZZER_H
#define FIRMWARE_BUZZER_H

#include "basic.h"
#include "dspic.h"

#define BUZZER_TIMER_PERIOD 0.0005
#define BUZZER_BIP_TIME 1 //s

#define BUZZER_Pin RG13_bit
#define BUZZER_Direction TRISG13_bit

void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);

#endif //FIRMWARE_BUZZER_H