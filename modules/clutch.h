//
// Created by Aaron Russo on 16/07/16.
//

#ifndef FIRMWARE_CLUTCH_H
#define FIRMWARE_CLUTCH_H

#include "clutchmotor.h"

void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

#endif //FIRMWARE_CLUTCH_H