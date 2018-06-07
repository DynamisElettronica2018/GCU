#include "aac.h"

aac_states aac_currentState;
int aac_parameters[AAC_NUM_PARAMS];
int aac_externValues[AAC_NUM_VALUES];
int aac_dtRelease;      //counter for clutch "slow" release
char aac_sendingAll = FALSE;
int aac_timesCounter;

/*
int aac_shiftTry = 0;
int aac_shiftCounter = 0;
int aac_targetGear = -1;
//*/
float aac_clutchStep;   //step for each "frame" of aac
float aac_clutchValue;


void aac_init(void){
    aac_currentState = OFF;
    aac_loadDefaultParams();
}

void aac_execute(void){
    switch (aac_currentState) {
        case START:
            Efi_setRPMLimiter();
//            Activate Launch Control
            Can_writeByte(SW_AUX_ID, MEX_READY);
            aac_currentState = READY;
            aac_clutchValue = 100;
            Clutch_set((unsigned int)aac_clutchValue);
            return;
        case READY:
            Clutch_set(100);
            return;
        case START_RELEASE:
            aac_clutchValue = aac_parameters[RAMP_START];
            Clutch_set(aac_clutchValue);
            aac_dtRelease = aac_parameters[RAMP_TIME] / AAC_WORK_RATE_ms;
            aac_clutchStep = ((float)(aac_parameters[RAMP_START] - aac_parameters[RAMP_END]) * AAC_WORK_RATE_ms) / (float)aac_parameters[RAMP_TIME];
            aac_currentState = RELEASING;
            return;
        case RELEASING:
//             Clutch_set(aac_parameters[RAMP_END] + (aac_clutchStep * aac_dtRelease));        //Works iff the cluth paddle is disabled
            aac_clutchValue = aac_clutchValue - aac_clutchStep;
            Clutch_set((unsigned char)aac_clutchValue);
            aac_dtRelease--;
            if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END]){
                Clutch_set(0);
                Efi_unsetRPMLimiter();
                aac_currentState = RUNNING;                 //For gearshift  Use alternatively to aac_stop
//UNCOMMENT FOR CLUTCH ONLY
               // aac_stop();                               //For not gearshift (clutch only)
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
            aac_currentState = OFF;
            Can_writeByte(SW_AUX_ID, MEX_OFF);
            return;
        //gearshift check
        default: return;
    }
}

void aac_sendOneTime(time_id pos){
    aac_timesCounter = pos;
}

void aac_sendTimes(void)
{
    if(aac_timesCounter >= 0){
        Can_resetWritePacket();
        Can_addIntToWritePacket(CODE_SET_AAC);
        Can_addIntToWritePacket(aac_timesCounter);
        Can_addIntToWritePacket(aac_parameters[aac_timesCounter]);
        if(Can_write(CAN_ID_TIMES) < 0)
            Buzzer_Bip();
        aac_timesCounter -= 1;
        if(!aac_sendingAll || aac_timesCounter < 0){
            aac_sendingAll = FALSE;
            aac_timesCounter = -1;
        }
    }
}

void aac_sendAllTimes(void)
{
    if(!aac_sendingAll){
        aac_timesCounter = AAC_NUM_PARAMS;
        aac_sendingAll = TRUE;
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

void aac_updateExternValue(const aac_values id, const int value){
    if(id < AAC_NUM_VALUES)
        aac_externValues[id] = value;
}

int aac_getParam(const aac_params id){
    if(id < AAC_NUM_PARAMS)
        return aac_parameters[id];
    return -1;
}

int aac_getExternValue(const aac_params id){
    if(id < AAC_NUM_VALUES)
        return aac_externValues[id];
    return -1;
}