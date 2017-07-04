/*
 * Created by Andrea Milanta on 3 March 2017
 */

#ifndef AAC_H
#define AAC_H

#include "aac_defaults.h"
#include "clutch.h"
#include "gearshift.h"
#include "efi.h"

#define AAC_WORK_RATE_ms   10 //ms
#define CLUTCH_PULL_MAX_TIME_s 10
#define AAC_NUM_PARAMS    9            //Number of aac_params enum elements
#define AAC_NUM_VALUES    3            //Number of aac_values enum elements

typedef enum{
    OFF,
    START,
    READY,
    START_RELEASE,
    RELEASING,
    RUNNING
}aac_states;

//when modifying entries update AAC_NUM_PARAMS
typedef enum{
    RAMP_START,
    RAMP_END,
    RAMP_TIME,
    //MANTAIN THE ORDER!!!!!!!!!
    RPM_LIMIT_1_2,
    RPM_LIMIT_2_3,
    RPM_LIMIT_3_4,
    SPEED_LIMIT_1_2,
    SPEED_LIMIT_2_3,
    SPEED_LIMIT_3_4
}aac_params;

typedef enum{
    READY,
    GO,
    OFF
}aac_notifications;

//when modifying entries update AAC_NUM_VALUES
typedef enum{
    RPM,
    WHEEL_SPEED,
    APPS
}aac_values;

extern unsigned int gearShift_currentGear;

//Releases Clutch gradually
void aac_execute(void);

void aac_start(void);

void aac_stop(void);

void aac_loadDefaultParams(void);

void aac_updateParam(const aac_params id, const int value);

void aac_forceState(const aac_states newState);

void aac_notifySW(const aac_notifications mex);

#endif
