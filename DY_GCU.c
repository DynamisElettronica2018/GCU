//#define OSC_FREQ_MHZ 80

#define DSIGNAL_LED_RG14 DSIGNAL_LED_0
#define DSIGNAL_LED_RG12 DSIGNAL_LED_1

//#include "./modules/input-output/d_signalLed.c"
//#include "./libs/dspic.c"
//#include "./libs/basic.c"
//#include "./libs/eeprom.c"
//#include "./libs/gcuRio.h"
//#include "./modules/d_can.h"
//#include "./modules/input-output/gearMotor.c"
//#include "./modules/input-output/clutchMotor.c"
//#include "./modules/input-output/efi.c"
//#include "./modules/input-output/buzzer.c"
//#include "./modules/input-output/sensors.c"
//#include "./modules/clutch.c"
//#include "./modules/engineControl.c"
//#include "modules/shiftTimings.c"
//#include "modules/gearShift.c"
//#include "modules/stopLight.c"
//*/

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
//*/

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0;
char bello = 0;
char isSteeringWheelAvailable;
unsigned int gearShift_timings[NUM_TIMES]; //30 tanto perchè su gcu c'è spazio e così possiamo fare fino a 30 step di cambiata, molto powa

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
            GearShift_injectCommand(firstInt);
            break;
        case SW_CLUTCH_ID:
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

        default:
            break;
    }
}