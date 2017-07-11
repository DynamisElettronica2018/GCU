//
// Created by Aaron Russo on 15/07/16.
//

#include "enginecontrol.h"

unsigned char engineControl_isChecking;
unsigned char engineControl_startCheckCounter;

void EngineControl_init(void) {
    ENGINE_STARTER_Direction = OUTPUT;
    ENGINE_KILL_Direction = OUTPUT;
    ENGINE_KEY_Direction = OUTPUT;

    ENGINE_KILL = ENGINE_NOT_KILLED;
    ENGINE_KEY = ENGINE_KEY_ON;
    engineControl_isChecking = FALSE;
    EngineControl_resetStartCheck();
    EngineControl_stop();
}


void EngineControl_keyOn(void) {
    ENGINE_KEY = ENGINE_KEY_ON;
}
//*/

void EngineControl_keyOff(void) {
    ENGINE_KEY = ENGINE_KEY_OFF;
}
//*/
void EngineControl_start(void) {
    dSignalLed_set(DSIGNAL_LED_RG12);
    ENGINE_STARTER = TRUE;
}

void EngineControl_stop(void) {
    dSignalLed_unset(DSIGNAL_LED_RG12);
    ENGINE_STARTER = FALSE;
}

void EngineControl_resetStartCheck(void) {
    engineControl_startCheckCounter = 0;
}

char EngineControl_isStarting(void) {
    if (engineControl_startCheckCounter < ENGINE_CONTROL_START_CHECK_THRESHOLD) {
        engineControl_startCheckCounter += 1;
        return TRUE;
    } else {
        return FALSE;
    }
}