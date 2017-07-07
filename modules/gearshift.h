//
// Created by Aaron Russo on 16/07/16.
//

#ifndef FIRMWARE_GEARCONTROL_H
#define FIRMWARE_GEARCONTROL_H

#include "basic.h"
#include "gearmotor.h"
#include "efi.h"
#include "buzzer.h"
#include "clutch.h"
#include "d_can.h"
#include "gcu_rio.h"

//Shift steps
typedef enum {
     STEP_UP_START,
     //STEP_UP_PUSH_DELAY,
     STEP_UP_PUSH,
     STEP_UP_REBOUND,
     STEP_UP_BRAKE,
     STEP_DOWN_START,
     //STEP_DOWN_CLUTCH,
     STEP_DOWN_PUSH,
     STEP_DOWN_REBOUND,
     STEP_DOWN_BRAKE,
     STEP_UP_END,
     STEP_DOWN_END
     }shiftStep;
/*
#define STEP_UP_PUSH_DELAY      0
#define STEP_UP_PUSH            1
#define STEP_UP_REBOUND         2
#define STEP_UP_BRAKE           3
#define STEP_DOWN_CLUTCH        4
#define STEP_DOWN_PUSH          5
#define STEP_DOWN_REBOUND       6
#define STEP_DOWN_BRAKE         7
#define STEP_UP_END             8
#define STEP_DOWN_END           9
#define STEP_UP_START   STEP_UP_PUSH_DELAY
#define STEP_DOWN_START STEP_DOWN_CLUTCH
//*/


//Gears
#define GEARSHIFT_NEUTRAL 0
#define GEARSHIFT_GEAR_1
#define GEARSHIFT_GEAR_2
#define GEARSHIFT_GEAR_3
#define GEARSHIFT_GEAR_4
#define GEARSHIFT_GEAR_5
#define GEARSHIFT_NO_GEAR 8

//SW Can commands
#define GEAR_COMMAND_NEUTRAL_UP 50
#define GEAR_COMMAND_NEUTRAL_DOWN   100
#define GEAR_COMMAND_UP 400
#define GEAR_COMMAND_DOWN   200
#define RPM_LIMITER_ON  150
#define RPM_LIMITER_OFF 160

#define GearShift_rebound   GearMotor_release
#define GearShift_upPush    GearMotor_turnRight
#define GearShift_downPush  GearMotor_turnLeft
#define GearShift_brake     GearMotor_brake
#define GearShift_free      GearMotor_release

//unsigned int gearShift_timings[30]; //30 tanto perchè su gcu c'è spazio e così possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_timings[RIO_NUM_TIMES];


void GearShift_init(void);

void GearShift_injectCommand(unsigned int command);

void GearShift_shift(unsigned int command);

void GearShift_setNeutral(unsigned int command);

void GearShift_setCurrentGear(unsigned int gear);

void GearShift_up(void);

void GearShift_down(void);

char GearShift_isShifting(void);

void GearShift_setNextStep_A(unsigned char step);

void GearShift_nextStep_A(void);

void GearShift_setNextStep_B(unsigned char step);

void GearShift_nextStep_B(void);

void GearShift_setMsTicks_A(unsigned int ticks);

void GearShift_setMsTicks_B(unsigned int ticks);

void GearShift_msTick(void);

void GearShift_loadDefaultTimings(void);

void GearShift_loadNeutralTimings(void);

int Gearshift_get_time(shiftStep step);

//void GearShift_checkUp(void);

//void GearShift_checkDown(void);

#endif //FIRMWARE_GEARCONTROL_H
