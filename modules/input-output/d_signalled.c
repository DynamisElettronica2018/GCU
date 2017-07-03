//
// Created by Aaron Russo on 08/07/16.
//

#include "d_signalled.h"

void dSignalLed_init(void) {
    DSIGNAL_0_Direction = OUTPUT;
    DSIGNAL_1_Direction = OUTPUT;
    dSignalLed_unset(DSIGNAL_LED_0);
    dSignalLed_unset(DSIGNAL_LED_1);
}

void dSignalLed_switch(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = !DSIGNAL_0_Pin;
            break;
        case DSIGNAL_LED_1:
            DSIGNAL_1_Pin = !DSIGNAL_1_Pin;
            break;
    }
}

void dSignalLed_set(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = DSIGNAL_LED_ON;
            break;
        case DSIGNAL_LED_1:
            DSIGNAL_1_Pin = DSIGNAL_LED_ON;
            break;
    }
}

void dSignalLed_unset(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = DSIGNAL_LED_OFF;
            break;
        case DSIGNAL_LED_1:
            DSIGNAL_1_Pin = DSIGNAL_LED_OFF;
            break;
    }
}