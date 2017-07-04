/*
 * Created by Andrea Milanta on 3 March 2017
 */

#ifndef AAC_H
#define AAC_H

#include "aac_defaults.h"
#include "clutch.h"

#define AAC_WORK_RATE_ms   10 //ms
#define CLUTCH_PULL_MAX_TIME_s 10
#define AAC_NUM_ENTRIES     9            //Number of aac_times enum elements

typedef enum{
    OFF,
    READY,
    START_RELEASE,
    RELEASING,
    RUNNING
}aac_states;

typedef enum{
    RAMP_START,
    RAMP_END,
    RAMP_TIME,
    //MANTAIN THE FOLLOWING ORDER!!!!!!!!!
    RPM_LIMIT_1_2,
    SPEED_LIMIT_1_2,
    RPM_LIMIT_2_3,
    SPEED_LIMIT_2_3,
    RPM_LIMIT_3_4,
    SPEED_LIMIT_3_4
}aac_times;

extern unsigned int gearShift_currentGear;

//Releases Clutch gradually
void aac_execute(void);

void aac_start(void);

void aac_stop(void);

void aac_loadDefaultTimings(void);

void aac_updateTiming(const aac_times id, const int value);

void aac_forceState(aac_states newState);

#endif
