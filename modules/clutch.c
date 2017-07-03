//
// Created by Aaron Russo on 16/07/16.
//

#include "clutch.h"

unsigned char Clutch_currentValue = 0;

void Clutch_insert(void) {
    Clutch_set(100);
}

void Clutch_release(void) {
    Clutch_set(0);
}

void Clutch_set(unsigned char percentage) {
    unsigned char actualPercentage = 0;
    if (percentage > 100) {
        actualPercentage = 100;
    } else {
        actualPercentage = percentage;
    }
    ClutchMotor_setPosition(100 - actualPercentage);
    Clutch_currentValue = actualPercentage;
}

unsigned char Clutch_get(void) {
    return Clutch_currentValue;
}