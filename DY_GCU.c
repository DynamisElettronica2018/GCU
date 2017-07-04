/*
 * Software GCU DP9
*/

#define OSC_FREQ_MHZ 80

#define DSIGNAL_LED_RG14 DSIGNAL_LED_0
#define DSIGNAL_LED_RG12 DSIGNAL_LED_1

#include "dspic.h"
#include "d_signalled.h"
#include "eeprom.h"
#include "gearmotor.h"
#include "clutchmotor.h"
#include "efi.h"
#include "buzzer.h"
#include "sensors.h"
#include "clutch.h"
#include "enginecontrol.h"
#include "gearshift.h"
#include "stoplight.h"
#include "gcu_rio.h"
#include "aac.h"                //COMMENT THIS LINE TO DISABLE AAC
//*/

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0;
char bello = 0;
char isSteeringWheelAvailable;

#ifdef AAC_H
  extern aac_states aac_currentState;
  extern int aac_externValues[AAC_NUM_VALUES];
  int timer1_aac_counter = 0;
#endif

unsigned int gearShift_timings[NUM_TIMES]; //30 tanto perch� su gcu c'� spazio e cos� possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

void GCU_isAlive(void) {
    Can_resetWritePacket();
    Can_addIntToWritePacket(CAN_COMMAND_GCU_IS_ALIVE);
    Can_addIntToWritePacket(Clutch_get());
    Can_write(GCU_CLUTCH_ID);
}

void init(void) {
    dSignalLed_init();
    Can_init();
    EngineControl_init();
    GearMotor_init();
    ClutchMotor_init();
    Efi_init();
    GearShift_init();
    StopLight_init();
    Buzzer_init();
    Sensors_init();
    //Generic 1ms timer
    setTimer(TIMER1_DEVICE, 0.001);
    setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
}

void main() {
    init();
    Buzzer_Bip();
    //ShiftTimings_load();
    while (1) {
        dSignalLed_switch(DSIGNAL_LED_RG14);
        Delay_ms(1000);
        bello += 1;
    }
}

//Generic 1ms timer
onTimer1Interrupt{
    clearTimer1();
    GearShift_msTick();
    Sensors_tick();
    timer1_counter0 += 1;
    timer1_counter1 += 1;
    timer1_counter2 += 1;

    if (timer1_counter0 > 25) {
        if (!EngineControl_isStarting()) {
            EngineControl_stop();
            Buzzer_Bip();
        }
        timer1_counter0 = 0;
    }
    if (timer1_counter1 == 100) {
        GCU_isAlive();
        timer1_counter1 = 0;
    }
    if (timer1_counter2 == 166) {
        Sensors_send();
        timer1_counter2 = 0;
    }

  #ifdef AAC_H
    timer1_aac_counter += 1;
    if(timer1_aac_counter == AAC_WORK_RATE_ms){
        aac_execute();
        timer1_aac_counter = 0;
    }
  #endif

}

onCanInterrupt{
    unsigned int intCommand, firstInt, secondInt, thirdInt, fourthInt;
    unsigned long int id;
    char dataBuffer[8];
    unsigned int dataLen, flags;
    Can_read(&id, dataBuffer, &dataLen, &flags);
    Can_clearInterrupt();

    if (dataLen >= 2) {
        firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
    }
    if (dataLen >= 4) {
        secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
    }
    if (dataLen >= 6) {
        thirdInt = (unsigned int) ((dataBuffer[4] << 8) | (dataBuffer[5] & 0xFF));
    }
    if (dataLen >= 8) {
        fourthInt = (unsigned int) ((dataBuffer[6] << 8) | (dataBuffer[7] & 0xFF));
    }

    dSignalLed_switch(DSIGNAL_LED_RG12);
    switch (id) {
        case EFI_GEAR_ID:
            GearShift_setCurrentGear(firstInt);
            break;

        case SW_FIRE_ID:
            EngineControl_resetStartCheck();
            EngineControl_start();
            break;

        case SW_RIO_GEAR_BRK_STEER_ID:
          #ifdef AAC_H
            if (Clutch_get() != 100
                  &&(firstInt == GEAR_COMMAND_NEUTRAL_DOWN
                     || firstInt == GEAR_COMMAND_NEUTRAL_UP
                     || firstInt == GEAR_COMMAND_DOWN))
                aac_stop();
          #endif
            GearShift_injectCommand(firstInt);
            break;

        case SW_CLUTCH_ID:
          #ifdef AAC_H
            if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL)
                aac_stop();
          #endif
            if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
                Clutch_set(dataBuffer[0]);
            }
            break;

        case CAN_ID_TIMES:
            switch(firstInt){
                case CODE_SET:
                     gearShift_timings[secondInt] = thirdInt;
                     sendOneTime(secondInt);
                     break;
                case CODE_REFRESH:
                     sendAllTimes();
                     break;
                default:
                     break;
            }
            break;

        case SW_AUX_ID:
          #ifdef AAC_H
            if(aac_currentState == OFF
              && gearShift_currentGear == GEARSHIFT_NEUTRAL
              && aac_externValues[WHEEL_SPEED] <= 1){
                aac_currentState = START;
                break;
            }
            if(aac_currentState == READY){
                aac_currentState = START_RELEASE;
                break;
            }
            //If none of the previous conditions are met, the aac is stopped
            aac_stop();
          #endif
            break;

        default:
            break;
    }
}
