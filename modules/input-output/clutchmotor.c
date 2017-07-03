//
// Created by Aaron Russo on 16/07/16.
//

#include "clutchmotor.h"

unsigned int CLUTCHMOTOR_PWM_PERIOD_VALUE;
double CLUTCHMOTOR_PERCENTAGE_STEP;
unsigned int CLUTCHMOTOR_PWM_MAX_VALUE;
unsigned int CLUTCHMOTOR_PWM_MIN_VALUE;

onTimer2Interrupt{
    clearTimer2();
}

void ClutchMotor_init(void) {
    setTimer(TIMER2_DEVICE, CLUTCHMOTOR_PWM_PERIOD);
    ClutchMotor_setupPWM();
}

void ClutchMotor_setupPWM(void) {
    OC8CON = 0x6; //PWM on Timer 2
    CLUTCHMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(CLUTCHMOTOR_PWM_PERIOD, TIMER2_PRESCALER);
    //There will be 100 possible steps on the 5-10% PWM range
    CLUTCHMOTOR_PWM_MAX_VALUE = (unsigned int) (CLUTCHMOTOR_PWM_PERIOD_VALUE *
                                                (CLUTCHMOTOR_MAX_PWM_PERCENTAGE / 100.0));
    CLUTCHMOTOR_PWM_MIN_VALUE = (unsigned int) (CLUTCHMOTOR_PWM_PERIOD_VALUE *
                                                (CLUTCHMOTOR_MIN_PWM_PERCENTAGE / 100.0));
    CLUTCHMOTOR_PERCENTAGE_STEP = (CLUTCHMOTOR_PWM_MAX_VALUE - CLUTCHMOTOR_PWM_MIN_VALUE) / 100.0;
    OC8R = CLUTCHMOTOR_PWM_MIN_VALUE;
    ClutchMotor_setPosition(100);
}

void ClutchMotor_setPosition(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) ((percentage * CLUTCHMOTOR_PERCENTAGE_STEP) + CLUTCHMOTOR_PWM_MIN_VALUE);
    if (pwmValue > CLUTCHMOTOR_PWM_MAX_VALUE) {
        pwmValue = CLUTCHMOTOR_PWM_MAX_VALUE;
    } else if (pwmValue < CLUTCHMOTOR_PWM_MIN_VALUE) {
        pwmValue = CLUTCHMOTOR_PWM_MIN_VALUE;
    }
    OC8RS = pwmValue;
}