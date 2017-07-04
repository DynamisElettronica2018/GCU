#include "aac.h"

aac_states aac_currentState;
int aac_timings[AAC_NUM_ENTRIES];
int aac_dtRelease;      //counter for clutch "slow" release
float aac_clutchStep;   //step for each "frame" of aac

void aac_execute(void){
    switch (aac_currentState) {
        case READY:
            Clutch_set(100);
            return;
        case START_RELEASE:
            Clutch_set(aac_timings[RAMP_START]);
            aac_currentState = RELEASING;
            aac_dtRelease = aac_timings[RAMP_TIME] / 10;
            aac_clutchStep = float((RAMP_START - RAMP_END) * AAC_WORK_RATE_ms / aac_timings[RAMP_TIME]);
            return;
        case RELEASING:
//             Clutch_set(aac_timings[RAMP_END] + (aac_clutchStep * aac_dtRelease));        //Works iff the cluth paddle is disabled
            Clutch_set(Clutch_get() - aac_clutchStep));
            aac_dtRelease--;
            if(aac_dtRelease <= 0 || Clutch_get() <= aac_timings[RAMP_END])
                aac_currentState = STOP_RELEASE;
                Clutch_set(0)
            return;
        case RUNNING:
        //TODO Check condizioni e cambio 
        default: return;
    }
}

void aac_loadDefaultTimings(void){
//Use defaults only if eeprom unavailable
#ifndef AAC_EEPROM_H
    aac_timings[RAMP_START]      = DEF_RAMP_START;
    aac_timings[RAMP_END]        = DEF_RAMP_END;
    aac_timings[RAMP_TIME]       = DEF_RAMP_TIME;
    aac_timings[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
    aac_timings[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
    aac_timings[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
    aac_timings[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
    aac_timings[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
    aac_timings[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
#endif
}

void aac_updateTiming(const aac_times id, const int value){
    if(id < AAC_NUM_ENTRIES)
        aac_timings[id] = value;
}
