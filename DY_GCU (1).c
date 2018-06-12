/*
 * Software GCU DP9
*/



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

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;

//TODO///////
//uncommentare il led 14 nel main e commentarlo/rimuoverl in onCanInterrupt


#ifdef AAC_H
  extern aac_states aac_currentState;
  extern int aac_externValues[AAC_NUM_VALUES];
  extern int aac_parameters[AAC_NUM_PARAMS ];
  //extern bool aac_sendingAll = false;
  extern int aac_timesCounter;
  int timer1_aac_counter = 0;
#endif

//variables to send data from efi to rio
extern int rio_efiData[RIO_NUM_EFI_DATA];
extern int timer1_rioEfiCounter;

unsigned int gearShift_timings[RIO_NUM_TIMES]; //30 tanto perch� su gcu c'� spazio e cos� possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

void GCU_isAlive(void) {
    Can_resetWritePacket();
    Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
    Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
//    Can_addIntToWritePacket(aac_getExternValue(WHEEL_SPEED));
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
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
    rio_init();
  #ifdef AAC_H
    aac_init();
  #endif
    //Generic 1ms timer
    setTimer(TIMER1_DEVICE, 0.001);
    /*
    T1CON         = 0x8000;
    T1IE_bit         = 1;
    T1IF_bit         = 0;
    IPC0         = IPC0 | 0x1000;
    PR1                 = 20000;
    //*/
    setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
    //*/
}

void main() {
    init();
    Buzzer_Bip();
    //ShiftTimings_load();
    while (1) {
        //dSignalLed_switch(DSIGNAL_LED_RG14);
        Delay_ms(1000);
        bello += 1;
    }
}

//Generic 1ms timer
onTimer1Interrupt{
    clearTimer1();
    GearShift_msTick();
    //Sensors_tick();
    timer1_counter0 += 1;
    timer1_counter1 += 1;
    timer1_counter2 += 1;
    timer1_counter3 += 1;
    timer1_counter4 += 1;
    //STUFF FOR REPEATED SHIFT

    //*/

    if (timer1_counter0 > 25) {
        if (!EngineControl_isStarting()) {
            EngineControl_stop();
            //Buzzer_Bip();
        }
        timer1_counter0 = 0;
    }
    if (timer1_counter1 >= 20) {
        GCU_isAlive();
        timer1_counter1 = 0;
    }

//    if (timer1_counter2 >= 166) {
    if (timer1_counter2 >= 1000) {
        dSignalLed_switch(DSIGNAL_LED_RG14);
        Sensors_send();
        timer1_counter2 = 0;
    }
    //*/
    if (timer1_counter3 >= 10) {
        rio_sendTimes();
      #ifdef AAC_H
        aac_sendTimes();
      #endif
        timer1_counter3 = 0;
    }
    
    if (timer1_counter4 >= RIO_UPDATE_RATE_ms) {
       //dSignalLed_switch(DSIGNAL_LED_RG12);
        rio_send();
        timer1_counter4 = 0;
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

   //dSignalLed_switch(DSIGNAL_LED_RG12);              //switch led state on CAN receive
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
             
        case EFI_FUEL_RPM_ID:
          #ifdef AAC_H
            aac_updateExternValue(WHEEL_SPEED, thirdInt / 10);
            aac_updateExternValue(RPM, fourthInt);
          #endif
            break;

        case SW_CLUTCH_ID:
          #ifdef AAC_H
            if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL){
                //aac_stop();
          #endif
                if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
                    //Buzzer_Bip();
                    Clutch_setBiased(dataBuffer[0]);
                   //Clutch_set(dataBuffer[0]);
               }
          #ifdef AAC_H
            }
          #endif
            break;

        case CAN_ID_TIMES:
            switch(firstInt){
                case CODE_SET_TIME:
                     gearShift_timings[secondInt] = thirdInt;
                     rio_sendOneTime(secondInt);
                     break;
                case CODE_REFRESH:
                     rio_sendAllTimes();
                   #ifdef AAC_H
                     aac_sendAllTimes();
                   #endif
                     break;
              #ifdef AAC_H
                case CODE_SET_AAC:
                     aac_parameters[secondInt] = thirdInt;
                     aac_sendOneTime(secondInt);
              #endif
                default:
                     break;
            }
            break;

        case EFI_OIL_BATT_ID:
            rio_efiData[POIL] = firstInt;
            rio_efiData[TOIL_IN] = secondInt;
            rio_efiData[TOIL_OUT] = thirdInt;
            rio_efiData[BATTERY] = fourthInt;
            break;

        case EFI_H2O_ID:
            rio_efiData[H2O_DC] = firstInt;
            rio_efiData[TH2O_ENGINE] = secondInt;
            rio_efiData[TH2O_IN] = thirdInt;
            rio_efiData[TH2O_OUT] = fourthInt;
            break;

        case EFI_MIXED_ID:
            rio_efiData[P_FUEL] = firstInt;
            rio_efiData[FAN] = secondInt;
            rio_efiData[INJ1] = thirdInt;
            rio_efiData[INJ2] = fourthInt;
            break;

        case SW_AUX_ID:
          #ifdef AAC_H
            dSignalLed_switch(DSIGNAL_LED_RG12);
            if(aac_currentState == OFF                                  //FOR TESTING
 //             && gearShift_currentGear == GEARSHIFT_NEUTRAL
 //             && aac_externValues[WHEEL_SPEED] <= 1
              ){
                aac_currentState = START; //comment to disable AAC
            }
            else if(aac_currentState == READY){
                aac_currentState = START_RELEASE; //comment to disable AAC
            }
            //If none of the previous conditions are met, the aac is stopped
            else
                aac_stop();
          #endif
            break;

        default:
            break;
    }
}