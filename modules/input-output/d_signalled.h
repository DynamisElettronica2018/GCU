//
// Created by Aaron Russo on 08/07/16.
//

#ifndef DP8_DISPLAY_CONTROLLER_D_SIGNALLED_H
#define DP8_DISPLAY_CONTROLLER_D_SIGNALLED_H

#include "basic.h"
#include "dspic.h"

#define DSIGNAL_0_Pin RG14_bit
#define DSIGNAL_1_Pin RG12_bit

#define DSIGNAL_0_Direction TRISG14_bit
#define DSIGNAL_1_Direction TRISG12_bit

#define DSIGNAL_LED_0   0
#define DSIGNAL_LED_1   1

#define DSIGNAL_LED_ON  1
#define DSIGNAL_LED_OFF 0

void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);

#endif //DP8_DISPLAY_CONTROLLER_D_SIGNALLED_H