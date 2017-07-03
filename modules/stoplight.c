//
// Created by Aaron Russo on 15/07/16.
//

#include "stoplight.h"

unsigned int STOPLIGHT_PWM_PERIOD_VALUE;
double STOPLIGHT_PERCENTAGE_STEP;
unsigned int STOPLIGHT_PWM_VALUE;

void StopLight_init(void) {
    StopLight_setupPWM();
}

void StopLight_setupPWM(void) {
    OC7CON = 0x6; //PWM on Timer 2
    STOPLIGHT_PWM_PERIOD_VALUE = getTimerPeriod(STOPLIGHT_PWM_PERIOD, TIMER2_PRESCALER);
    STOPLIGHT_PWM_VALUE = (unsigned int) (STOPLIGHT_PWM_PERIOD_VALUE *
                                                (STOPLIGHT_PWM_PERCENTAGE / 100.0));
    OC7R = STOPLIGHT_PWM_VALUE;
    OC7RS = STOPLIGHT_PWM_VALUE;
}

void StopLight_setBrightness(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) (STOPLIGHT_PWM_PERIOD_VALUE * (percentage / 100.0));
    if (pwmValue > 100) {
        pwmValue = (unsigned int) STOPLIGHT_PWM_PERIOD_VALUE;
    } else if (pwmValue < 0) {
        pwmValue = 1;
    }
    OC7RS = pwmValue;
}