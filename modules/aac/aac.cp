#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/aac/aac.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/aac/aac.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/aac/aac_defaults.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/clutchmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/gearmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/d_can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 26 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/can.h"
#line 27 "c:/users/salvatore/desktop/git repo/gcu/modules/aac/aac.h"
typedef enum{
 OFF,
 START,
 READY,
 START_RELEASE,
 RELEASING,
 RUNNING,
 STOPPING
}aac_states;


typedef enum{
 RAMP_START,
 RAMP_END,
 RAMP_TIME,

 RPM_LIMIT_1_2,
 RPM_LIMIT_2_3,
 RPM_LIMIT_3_4,
 SPEED_LIMIT_1_2,
 SPEED_LIMIT_2_3,
 SPEED_LIMIT_3_4
}aac_params;

typedef enum{
 MEX_ON,
 MEX_READY,
 MEX_GO,
 MEX_OFF,
}aac_notifications;


typedef enum{
 RPM,
 WHEEL_SPEED,
 APPS
}aac_values;

extern unsigned int gearShift_currentGear;

void aac_init(void);


void aac_execute(void);


void aac_checkAndPrepare(void);

void aac_stop(void);

void aac_loadDefaultParams(void);

void aac_updateParam(const aac_params id, const int value);

void aac_updateExternValue(const aac_values id, const int value);

int aac_getParam(const aac_params id);

int aac_getExternValue(const aac_values id);

void aac_forceState(const aac_states newState);

void aac_sendTimes(void);

void aac_sendOneTime(time_id pos);

void aac_sendAllTimes(void);
#line 3 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/aac/aac.c"
aac_states aac_currentState;
int aac_parameters[ 9 ];
int aac_externValues[ 3 ];
int aac_dtRelease;
char aac_sendingAll =  0 ;
int aac_timesCounter;
#line 15 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/aac/aac.c"
float aac_clutchStep;
float aac_clutchValue;


void aac_init(void){
 aac_currentState = OFF;
 aac_loadDefaultParams();
}

void aac_execute(void){
 switch (aac_currentState) {
 case START:
 Efi_setRPMLimiter();

 Can_writeByte( 0b11111110000 , MEX_READY);
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
 aac_dtRelease = aac_parameters[RAMP_TIME] /  25 ;
 aac_clutchStep = ((float)(aac_parameters[RAMP_START] - aac_parameters[RAMP_END]) *  25 ) / (float)aac_parameters[RAMP_TIME];
 aac_currentState = RELEASING;
 return;
 case RELEASING:

 aac_clutchValue = aac_clutchValue - aac_clutchStep;
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

 if(gearShift_currentGear == 4){
 aac_stop();
 return;
 }

 if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
 && aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
 GearShift_up();
 }
 return;
 case STOPPING:
 aac_currentState = OFF;
 Can_writeByte( 0b11111110000 , MEX_OFF);
 return;

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
 Can_addIntToWritePacket( 2 );
 Can_addIntToWritePacket(aac_timesCounter);
 Can_addIntToWritePacket(aac_parameters[aac_timesCounter]);
 if(Can_write( 0b11100001101 ) < 0)
 Buzzer_Bip();
 aac_timesCounter -= 1;
 if(!aac_sendingAll || aac_timesCounter < 0){
 aac_sendingAll =  0 ;
 aac_timesCounter = -1;
 }
 }
}

void aac_sendAllTimes(void)
{
 if(!aac_sendingAll){
 aac_timesCounter =  9 ;
 aac_sendingAll =  1 ;
 }
}

void aac_loadDefaultParams(void){


 aac_parameters[RAMP_START] =  70 ;
 aac_parameters[RAMP_END] =  0 ;
 aac_parameters[RAMP_TIME] =  250 ;
 aac_parameters[RPM_LIMIT_1_2] =  11300 ;
 aac_parameters[RPM_LIMIT_2_3] =  11300 ;
 aac_parameters[RPM_LIMIT_3_4] =  11300 ;
 aac_parameters[SPEED_LIMIT_1_2] =  47 ;
 aac_parameters[SPEED_LIMIT_2_3] =  65 ;
 aac_parameters[SPEED_LIMIT_3_4] =  80 ;

}

void aac_updateParam(const aac_params id, const int value){
 if(id <  9 )
 aac_parameters[id] = value;
}

void aac_stop(void){
 if(aac_currentState != OFF)
 aac_currentState = STOPPING;
}

void aac_updateExternValue(const aac_values id, const int value){
 if(id <  3 )
 aac_externValues[id] = value;
}

int aac_getParam(const aac_params id){
 if(id <  9 )
 return aac_parameters[id];
 return -1;
}

int aac_getExternValue(const aac_params id){
 if(id <  3 )
 return aac_externValues[id];
 return -1;
}
