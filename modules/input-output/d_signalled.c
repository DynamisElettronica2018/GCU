//
// Created by Aaron Russo on 08/07/16.
//

#include "d_signalled.h"

void dSignalLed_init(void) {
    DSIGNAL_0_Direction = OUTPUT;
    dSignalLed_unset(DSIGNAL_LED_0);
}

void dSignalLed_switch(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = !DSIGNAL_0_Pin;
            break;
    }
}

void dSignalLed_set(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = DSIGNAL_LED_ON;
            break;
    }
}

void dSignalLed_unset(unsigned char led) {
    switch (led) {
        case DSIGNAL_LED_0:
            DSIGNAL_0_Pin = DSIGNAL_LED_OFF;
            break;
    }
}