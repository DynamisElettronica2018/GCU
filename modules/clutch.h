//
// Created by Aaron Russo on 16/07/16.
//

#ifndef FIRMWARE_CLUTCH_H
#define FIRMWARE_CLUTCH_H

#define CLUTCH_MAX_BIAS 95

#define CLUTCH_MAX_MEANINGFUL 70

#include "clutchmotor.h"

void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

void Clutch_setBiased(unsigned char value);

#endif //FIRMWARE_CLUTCH_H