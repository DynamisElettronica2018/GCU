#include "aac.h"

aac_states aac_currentState;
int aac_parameters[AAC_NUM_PARAMS];
int aac_externValues[AAC_NUM_VALUES];
int aac_dtRelease;      //counter for clutch "slow" release
float aac_clutchStep;   //step for each "frame" of aac

void aac_execute(void){
    switch (aac_currentState) {
        case START:
            Efi_setRPMLimiter();
            Clutch_set(100);
            aac_notifySW(READY);
            aac_currentState = READY;
            return;
        case READY:
            Clutch_set(100);
            return;
        case START_RELEASE:
            Clutch_set(aac_parameters[RAMP_START]);
            aac_dtRelease = aac_parameters[RAMP_TIME] / 10;
            aac_clutchStep = (float)((RAMP_START - RAMP_END) * AAC_WORK_RATE_ms / aac_parameters[RAMP_TIME]);
            return;
        case RELEASING:
//             Clutch_set(aac_parameters[RAMP_END] + (aac_clutchStep * aac_dtRelease));        //Works iff the cluth paddle is disabled
            Clutch_set(Clutch_get() - aac_clutchStep);
            aac_dtRelease--;
            if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END])
                aac_currentState = RUNNING;
                Clutch_set(0);
                Efi_unsetRPMLimiter();
            return;
        case RUNNING:
        //TODO Check condizioni e cambio
            if(gearShift_currentGear == 4){
                aac_currentState = OFF;
                return;
            }
          //parameters for gear is taken using as a index the baseline (RPM_LIMIT_1_2) + (gear - 1)
            if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
              && aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
                GearShift_up();
            }
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

void aac_notifySW(const aac_notifications mex){
    //TODO CAN mex to steering wheel
}
