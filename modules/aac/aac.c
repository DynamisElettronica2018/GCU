#include "aac.h"

aac_states aac_currentState;
int aac_parameters[AAC_NUM_PARAMS];
int aac_externValues[AAC_NUM_VALUES];
int aac_dtRelease;      //counter for clutch "slow" release
/*
int aac_shiftTry = 0;
int aac_shiftCounter = 0;
int aac_targetGear = -1;
//*/
float aac_clutchStep;   //step for each "frame" of aac
float aac_clutchValue;

void aac_init(void){
    aac_currentState = OFF;
}

void aac_execute(void){
    switch (aac_currentState) {
        case START:
            Efi_setRPMLimiter();
//            Activate Launch Control
            Clutch_set(100);
            Can_writeByte(SW_AUX_ID, MEX_READY);
            aac_currentState = READY;
            aac_clutchValue = 100;
            return;
        case READY:
            Clutch_set(aac_clutchValue);
            return;
        case START_RELEASE:
            aac_clutchValue = aac_parameters[RAMP_START];
            Clutch_set(aac_clutchValue);
            aac_dtRelease = aac_parameters[RAMP_TIME] / AAC_WORK_RATE_ms;
            aac_clutchStep = (float)((RAMP_START - RAMP_END) * AAC_WORK_RATE_ms / aac_parameters[RAMP_TIME]);
            aac_currentState = RELEASING;
            return;
        case RELEASING:
//             Clutch_set(aac_parameters[RAMP_END] + (aac_clutchStep * aac_dtRelease));        //Works iff the cluth paddle is disabled
            aac_clutchValue -= aac_clutchStep;
            Clutch_set((unsigned char)aac_clutchValue);
            aac_dtRelease--;
            if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END]){
                Clutch_set(0);
                Efi_unsetRPMLimiter();
                aac_currentState = RUNNING;
            }
            Buzzer_bip();
            return;
        case RUNNING:
        //Check condizioni e cambio
            if(gearShift_currentGear == 4){
                aac_stop();
                return;
            }
        //parameters for gear is taken using as a index the baseline (RPM_LIMIT_1_2) + (gear - 1)
            if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
              && aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
                GearShift_up();
            }
            return;
        case STOPPING:
            Can_writeByte(SW_AUX_ID, MEX_OFF);
            aac_currentState = OFF;
            return;
        //gearshift check
        default: return;
    }
}

void aac_loadDefaultParams(void){
//Use defaults only if eeprom unavailable
#ifndef AAC_EEPROM_H
    aac_parameters[RAMP_START]      = DEF_RAMP_START;
    aac_parameters[RAMP_END]        = DEF_RAMP_END;
    aac_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
    aac_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
    aac_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
    aac_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
    aac_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
    aac_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
    aac_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
#endif
}

void aac_updateParam(const aac_params id, const int value){
    if(id < AAC_NUM_PARAMS)
        aac_parameters[id] = value;
}

void aac_stop(void){
    if(aac_currentState != OFF)
        aac_currentState = STOPPING;
}