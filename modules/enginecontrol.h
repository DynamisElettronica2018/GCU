//
// Created by Aaron Russo on 15/07/16.
//

#ifndef FIRMWARE_ENGINECONTROL_H
#define FIRMWARE_ENGINECONTROL_H

#include "basic.h"
#include "dspic.h"

#define ENGINE_STARTER_Direction   TRISD.B5
#define ENGINE_KILL_Direction  TRISD.B1

#define ENGINE_STARTER LATD5_bit
#define ENGINE_KILL LATD1_bit

#define ENGINE_KILLED 0
#define ENGINE_NOT_KILLED 1

#define ENGINE_CONTROL_START_CHECK_THRESHOLD 4


void EngineControl_init(void);

void EngineControl_kill(void);

void EngineControl_start(void);

void EngineControl_stop(void);

void EngineControl_resetStartCheck(void);

char EngineControl_isStarting(void);

#endif //FIRMWARE_ENGINECONTROL_H