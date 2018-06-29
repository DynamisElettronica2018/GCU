#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gearshift.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/gearmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 177 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
void setAllPinAsDigital(void);

void setInterruptPriority(unsigned char device, unsigned char priority);

void setExternalInterrupt(unsigned char device, char edge);

void switchExternalInterruptEdge(unsigned char);

char getExternalInterruptEdge(unsigned char);

void clearExternalInterrupt(unsigned char);

void setTimer(unsigned char device, double timePeriod);

void clearTimer(unsigned char device);

void turnOnTimer(unsigned char device);

void turnOffTimer(unsigned char device);

unsigned int getTimerPeriod(double timePeriod, unsigned char prescalerIndex);

unsigned char getTimerPrescaler(double timePeriod);

double getExactTimerPrescaler(double timePeriod);

void setupAnalogSampling(void);

void turnOnAnalogModule();

void turnOffAnalogModule();

void startSampling(void);

unsigned int getAnalogValue(void);

void setAnalogPIN(unsigned char pin);

void unsetAnalogPIN(unsigned char pin);

void setAnalogInterrupt(void);

void unsetAnalogInterrupt(void);

void clearAnalogInterrupt(void);


void setAutomaticSampling(void);

void unsetAutomaticSampling(void);


void setAnalogVoltageReference(unsigned char mode);

void setAnalogDataOutputFormat(unsigned char adof);

int getMinimumAnalogClockConversion(void);
#line 26 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/gearmotor.h"
void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 23 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/efi.h"
void Efi_init(void);

void Efi_setCut(void);

void Efi_unsetCut(void);

void Efi_setBlip(void);

void Efi_unsetBlip(void);

void Efi_setRPMLimiter(void);

void Efi_unsetRPMLimiter(void);

void Efi_setRPMLimiter_CAN(unsigned int limit);

void Efi_unsetRPMLimiter_CAN(unsigned int limit);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/clutchmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/clutchmotor.h"
void ClutchMotor_init(void);

void ClutchMotor_setupPWM(void);

void ClutchMotor_setPosition(unsigned char percentage);
#line 14 "c:/users/salvatore/desktop/git repo/gcu/modules/clutch.h"
void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

void Clutch_setBiased(unsigned char value);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/d_can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 22 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/d_can.h"
#line 60 "c:/users/salvatore/desktop/git repo/gcu/libs/can.h"
void Can_init(void);

void Can_read(unsigned long int *id, char dataBuffer[], unsigned int *dataLength, unsigned int *inFlags);

void Can_writeByte(unsigned long int id, unsigned char dataOut);

void Can_writeInt(unsigned long int id, int dataOut);

void Can_addIntToWritePacket(int dataOut);

void Can_addByteToWritePacket(unsigned char dataOut);

unsigned int Can_write(unsigned long int id);

void Can_setWritePriority(unsigned int txPriority);

void Can_resetWritePacket(void);

unsigned int Can_getWriteFlags(void);

unsigned char Can_B0hasBeenReceived(void);

unsigned char Can_B1hasBeenReceived(void);

void Can_clearB0Flag(void);

void Can_clearB1Flag(void);

void Can_clearInterrupt(void);

void Can_initInterrupt(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
#line 41 "c:/users/salvatore/desktop/git repo/gcu/modules/gcu_rio.h"
typedef enum {

 NT_PUSH_1_N,
 NT_CLUTCH_1_N,
 NT_REBOUND_1_N,
 NT_BRAKE_1_N,

 NT_PUSH_2_N,
 NT_CLUTCH_2_N,
 NT_REBOUND_2_N,
 NT_BRAKE_2_N,

 DN_PUSH,
 CLUTCH,
 DN_REBOUND,
 DN_BRAKE,

 UP_PUSH_1_2,
 UP_PUSH_2_3,
 UP_PUSH_3_4,
 UP_PUSH_4_5,

 DELAY,
 UP_REBOUND,
 UP_BRAKE,

 NT_CLUTCH_DELAY,


 DOWN_TIME_CHECK,
 UP_TIME_CHECK,
 MAX_TRIES,


 TIMES_LAST
 }time_id;

 typedef enum{

 H2O_DC,
 TH2O_ENGINE,
 TH2O_IN,
 TH2O_OUT,

 POIL,
 TOIL_IN,
 TOIL_OUT,
 BATTERY,

 P_FUEL,
 FAN,
 INJ1,
 INJ2,

 DATA_LAST
 }efi_dataIds;




extern unsigned int gearShift_timings[ TIMES_LAST ];

void rio_init(void);

extern void rio_sendOneTime(time_id pos);

extern void rio_sendAllTimes(void);

extern void rio_sendTimes(void);

extern void rio_send(void);
#line 17 "c:/users/salvatore/desktop/git repo/gcu/modules/gearshift.h"
typedef enum {
 STEP_UP_START,

 STEP_UP_PUSH,
 STEP_UP_REBOUND,
 STEP_UP_BRAKE,
 STEP_DOWN_START,

 STEP_DOWN_PUSH,
 STEP_DOWN_REBOUND,
 STEP_DOWN_BRAKE,
 STEP_UP_END,
 STEP_DOWN_END
 }shiftStep;
#line 71 "c:/users/salvatore/desktop/git repo/gcu/modules/gearshift.h"
extern unsigned int gearShift_timings[ TIMES_LAST ];


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
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gearshift.c"
unsigned int gearShift_currentGear, gearShift_targetGear;
int gearShift_ticksCounter1, gearShift_ticksCounter2, gearShift_ticksCounterTries, gearShift_shiftTries;
char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;
unsigned char gearShift_nextStepValue_A, gearShift_nextStepValue_B;



void GearShift_init(void) {
 gearShift_currentGear = 0;
 gearShift_isShiftingUp =  0 ;
 gearShift_isShiftingDown =  0 ;
 gearShift_isSettingNeutral =  0 ;
 gearShift_isUnsettingNeutral =  0 ;
 gearShift_ticksCounter1 = 0;
 gearShift_ticksCounter2 = 0;
 GearShift_loadDefaultTimings();
}

void GearShift_setCurrentGear(unsigned int gear) {
 if (gear <= 5) {
 gearShift_currentGear = gear;
 }
}

void GearShift_injectCommand(unsigned int command) {
 if (command ==  100  || command ==  50 ) {
 GearShift_setNeutral(command);
 } else if (command ==  200  || command ==  400 ) {
 GearShift_shift(command);
 } else if (command ==  150 ) {
 Efi_setRPMLimiter();
 } else if (command ==  160 ) {
 Efi_unsetRPMLimiter();
 }
}

void GearShift_shift(unsigned int command) {

 if (gearShift_currentGear ==  0 ) {
 gearShift_isUnsettingNeutral =  1 ;
 }
 if (command ==  400 ) {
 GearShift_up();
 } else if (command ==  200 ) {
 GearShift_down();
 }
}

void GearShift_setNeutral(unsigned int command) {
 gearShift_isSettingNeutral =  1 ;

 if (command ==  100 ) {
 GearShift_down();
 } else if (command ==  50 ) {
 GearShift_up();
 }
}

void GearShift_up(void) {

 if (!GearShift_isShifting()) {
 gearShift_isShiftingUp =  1 ;
 GearShift_setNextStep_A(STEP_UP_START);
 GearShift_nextStep_A();
 }
}

void GearShift_down(void) {

 if (!GearShift_isShifting()) {
 gearShift_isShiftingDown =  1 ;
 GearShift_setNextStep_A(STEP_DOWN_START);
 GearShift_nextStep_A();
 }
}

char GearShift_isShifting(void) {
 return gearShift_isShiftingDown || gearShift_isShiftingUp;
}

void GearShift_setNextStep_A(unsigned char step) {
 gearShift_nextStepValue_A = step;
}

void GearShift_setNextStep_B(unsigned char step) {
 gearShift_nextStepValue_B = step;
}

void GearShift_checkUp(void){

 if(gearShift_ticksCounterTries <= 0){

 }
}
#line 192 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gearshift.c"
void GearShift_nextStep_A(void) {
 switch (gearShift_nextStepValue_A) {
 case STEP_UP_START:
 if (gearShift_isSettingNeutral) {
 Clutch_set(80);
 } else {
 Efi_setCut();
 Buzzer_Bip();
 }
 GearShift_setNextStep_A(STEP_UP_PUSH);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_START));
 break;
 case STEP_UP_PUSH:
 if (!gearShift_isSettingNeutral) {
 Efi_unsetCut();
 }
  GearMotor_turnRight ();
 GearShift_setNextStep_A(STEP_UP_REBOUND);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_PUSH));
 break;
 case STEP_UP_REBOUND:
 if (gearShift_isSettingNeutral) {
 Clutch_release();
 }
  GearMotor_release ();
 GearShift_setNextStep_A(STEP_UP_BRAKE);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_REBOUND));
 break;
 case STEP_UP_BRAKE:
  GearMotor_brake ();
 GearShift_setNextStep_A(STEP_UP_END);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_BRAKE));
 break;
 case STEP_UP_END:
  GearMotor_release ();
 gearShift_isShiftingUp =  0 ;
 gearShift_isSettingNeutral =  0 ;
 gearShift_isUnsettingNeutral =  0 ;

 break;

 case STEP_DOWN_START:
 if (gearShift_isSettingNeutral && Clutch_get() <= 80) {
 Clutch_set(80);
 } else {

 if (!gearShift_isUnsettingNeutral && Clutch_get() <= 60) {
 Clutch_set(60);
 }
 Efi_setBlip();
 Buzzer_Bip();
 }
 GearShift_setNextStep_A(STEP_DOWN_PUSH);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_START));
 break;
 case STEP_DOWN_PUSH:
 if (!gearShift_isSettingNeutral) {
 Efi_unsetBlip();
 }
  GearMotor_turnLeft ();
 GearShift_setNextStep_A(STEP_DOWN_REBOUND);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_PUSH));
 break;
 case STEP_DOWN_REBOUND:
  GearMotor_release ();
 GearShift_setNextStep_A(STEP_DOWN_BRAKE);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_REBOUND));
 break;
 case STEP_DOWN_BRAKE:
 if (Clutch_get() <= 81)
 Clutch_release();
  GearMotor_brake ();
 GearShift_setNextStep_A(STEP_DOWN_END);
 GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_BRAKE));
 break;
 case STEP_DOWN_END:
  GearMotor_release ();
 gearShift_isShiftingDown =  0 ;
 gearShift_isSettingNeutral =  0 ;
 gearShift_isUnsettingNeutral =  0 ;

 break;
 default:
 break;
 }
}


void GearShift_nextStep_B(void) {
 switch (gearShift_nextStepValue_B) {
 default:
 break;
 }
}

void GearShift_setMsTicks_A(unsigned int ticks) {
 gearShift_ticksCounter1 = (int) ticks + 1;
}

void GearShift_setMsTicks_B(unsigned int ticks) {
 gearShift_ticksCounter2 = (int) ticks + 1;
}

void GearShift_msTick(void) {
 gearShift_ticksCounter1 -= 1;
 if (gearShift_ticksCounter1 == 0) {
 GearShift_nextStep_A();
 } else if (gearShift_ticksCounter1 < 0) {
 gearShift_ticksCounter1 = 0;
 }

 gearShift_ticksCounter2 -= 1;
 if (gearShift_ticksCounter2 == 0) {
 GearShift_nextStep_B();
 } else if (gearShift_ticksCounter2 < 0) {
 gearShift_ticksCounter2 = 0;
 }
}
#line 343 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gearshift.c"
int Gearshift_get_time(shiftStep step)
{
 if(gearShift_isSettingNeutral ==  1 ){
 switch(step){
 case STEP_UP_START:
 return gearShift_timings[NT_CLUTCH_DELAY];
 case STEP_UP_PUSH:
 return gearShift_timings[NT_PUSH_1_N];
 case STEP_UP_REBOUND:
 return gearShift_timings[NT_REBOUND_1_N];
 case STEP_UP_BRAKE:
 return gearShift_timings[NT_BRAKE_1_N];


 case STEP_DOWN_PUSH:
 return gearShift_timings[NT_PUSH_2_N];
 case STEP_DOWN_REBOUND:
 return gearShift_timings[NT_REBOUND_2_N];
 case STEP_DOWN_BRAKE:
 return gearShift_timings[NT_BRAKE_2_N];
 }
 }
 switch(step){
 case STEP_UP_START:
 return gearShift_timings[DELAY];
 break;

 case STEP_UP_PUSH:
 switch(gearShift_currentGear){
 case 1:
 return gearShift_timings[UP_PUSH_1_2];
 case 2:
 return gearShift_timings[UP_PUSH_2_3];
 case 3:
 return gearShift_timings[UP_PUSH_3_4];
 case 4:
 return gearShift_timings[UP_PUSH_4_5];
 default:
 return gearShift_timings[UP_PUSH_2_3];
 }
 case STEP_UP_REBOUND:
 return gearShift_timings[UP_REBOUND];
 case STEP_UP_BRAKE:
 return gearShift_timings[UP_BRAKE];
 case STEP_DOWN_START:
 return gearShift_timings[CLUTCH];

 case STEP_DOWN_PUSH:
 return gearShift_timings[DN_PUSH];
 case STEP_DOWN_REBOUND:
 return gearShift_timings[DN_REBOUND];
 case STEP_DOWN_BRAKE:
 return gearShift_timings[DN_BRAKE];
 }
}

void GearShift_loadDefaultTimings(void) {
 gearShift_timings[DELAY] =  20 ;
 gearShift_timings[UP_REBOUND] =  15 ;
 gearShift_timings[UP_BRAKE] =  20 ;
 gearShift_timings[UP_PUSH_1_2] =  115 ;
 gearShift_timings[UP_PUSH_2_3] =  100 ;
 gearShift_timings[UP_PUSH_3_4] =  100 ;
 gearShift_timings[UP_PUSH_4_5] =  100 ;

 gearShift_timings[CLUTCH] =  70 ;
 gearShift_timings[DN_PUSH] =  100 ;
 gearShift_timings[DN_BRAKE] =  15 ;
 gearShift_timings[DN_REBOUND] =  20 ;

 gearShift_timings[NT_CLUTCH_DELAY] =  20 ;
 gearShift_timings[NT_REBOUND_1_N] =  15 ;
 gearShift_timings[NT_REBOUND_2_N] =  15 ;
 gearShift_timings[NT_BRAKE_1_N] =  35 ;
 gearShift_timings[NT_BRAKE_2_N] =  35 ;
 gearShift_timings[NT_PUSH_1_N] =  22 ;
 gearShift_timings[NT_PUSH_2_N] =  25 ;
 gearShift_timings[NT_CLUTCH_1_N] =  300 ;
 gearShift_timings[NT_CLUTCH_2_N] =  300 ;


 gearShift_timings[DOWN_TIME_CHECK] =  500 ;
 gearShift_timings[UP_TIME_CHECK] =  500 ;
 gearShift_timings[MAX_TRIES] =  2 ;
}
