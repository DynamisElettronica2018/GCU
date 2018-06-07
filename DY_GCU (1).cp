#line 1 "C:/Users/ElettroDynamisPRC/Google Drive/REPARTO ELETTRONICA 2017/GCU/DY_GCU_AUSTRIA_2017/DY_GCU.c"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 16 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 177 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
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
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/d_signalled.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 26 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/eeprom.h"







void EEPROM_writeInt(unsigned int address, unsigned int value);

unsigned int EEPROM_readInt(unsigned int address);

void EEPROM_writeArray(unsigned int address, unsigned int *values);

void EEPROM_readArray(unsigned int address, unsigned int *values);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/gearmotor.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 26 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/gearmotor.h"
void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/clutchmotor.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 16 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/clutchmotor.h"
void ClutchMotor_init(void);

void ClutchMotor_setupPWM(void);

void ClutchMotor_setPosition(unsigned char percentage);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/efi.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 23 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/efi.h"
void Efi_init(void);

void Efi_setCut(void);

void Efi_unsetCut(void);

void Efi_setBlip(void);

void Efi_unsetBlip(void);

void Efi_setRPMLimiter(void);

void Efi_unsetRPMLimiter(void);

void Efi_setRPMLimiter_CAN(unsigned int limit);

void Efi_unsetRPMLimiter_CAN(unsigned int limit);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/buzzer.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 17 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/sensors.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/d_can.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/can.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/d_signalled.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/d_can.h"
#line 60 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/can.h"
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
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 22 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/sensors.h"
void Sensors_init(void);

void Sensors_tick(void);

void Sensors_read(void);

void Sensors_nextPin(void);

void Sensors_send(void);

void Sensors_sampleFanCurrent(unsigned int value);

void Sensors_sampleH2OPumpCurrent(unsigned int value);

void Sensors_sampleFuelPumpCurrent(unsigned int value);

void Sensors_sampleGCUTemp(unsigned int value);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/clutch.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/clutchmotor.h"
#line 14 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/clutch.h"
void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

void Clutch_setBiased(unsigned char value);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/enginecontrol.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/d_signalled.h"
#line 30 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/enginecontrol.h"
void EngineControl_init(void);

void EngineControl_keyOn(void);

void EngineControl_keyOff(void);

void EngineControl_start(void);

void EngineControl_stop(void);

void EngineControl_resetStartCheck(void);

char EngineControl_isStarting(void);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gearshift.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/gearmotor.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/efi.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/buzzer.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/clutch.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/d_can.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gcu_rio.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/can.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/buzzer.h"
#line 41 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gcu_rio.h"
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
#line 17 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gearshift.h"
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
#line 71 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gearshift.h"
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
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/stoplight.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/basic.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/dspic.h"
#line 17 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/stoplight.h"
void StopLight_init(void);

void StopLight_setupPWM(void);

void StopLight_setBrightness(unsigned char percentage);
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gcu_rio.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/aac/aac.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/aac/aac_defaults.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/clutch.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/gearshift.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/input-output/efi.h"
#line 1 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/libs/can.h"
#line 27 "c:/users/elettrodynamisprc/google drive/reparto elettronica 2017/gcu/dy_gcu_austria_2017/modules/aac/aac.h"
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
#line 23 "C:/Users/ElettroDynamisPRC/Google Drive/REPARTO ELETTRONICA 2017/GCU/DY_GCU_AUSTRIA_2017/DY_GCU.c"
int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;






 extern aac_states aac_currentState;
 extern int aac_externValues[ 3 ];
 extern int aac_parameters[ 9  ];

 extern int aac_timesCounter;
 int timer1_aac_counter = 0;



extern int rio_efiData[ DATA_LAST ];
extern int timer1_rioEfiCounter;

unsigned int gearShift_timings[ TIMES_LAST ];
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

void GCU_isAlive(void) {
 Can_resetWritePacket();
 Can_addIntToWritePacket((unsigned int) 99 );
 Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));

 Can_addIntToWritePacket(0);
 Can_addIntToWritePacket(0);
 Can_write( 0b11000010111 );

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

 aac_init();


 setTimer( 1 , 0.001);
#line 83 "C:/Users/ElettroDynamisPRC/Google Drive/REPARTO ELETTRONICA 2017/GCU/DY_GCU_AUSTRIA_2017/DY_GCU.c"
 setInterruptPriority( 1 ,  4 );

}

void main() {
 init();
 Buzzer_Bip();

 while (1) {

 Delay_ms(1000);
 bello += 1;
 }
}


 void timer1_interrupt() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
  IFS0bits.T1IF  = 0 ;
 GearShift_msTick();
 Sensors_tick();
 timer1_counter0 += 1;
 timer1_counter1 += 1;
 timer1_counter2 += 1;
 timer1_counter3 += 1;
 timer1_counter4 += 1;




 if (timer1_counter0 > 25) {
 if (!EngineControl_isStarting()) {
 EngineControl_stop();

 }
 timer1_counter0 = 0;
 }
 if (timer1_counter1 >= 20) {
 GCU_isAlive();
 timer1_counter1 = 0;
 }


 if (timer1_counter2 >= 1000) {
 dSignalLed_switch( 0 );
 Sensors_send();
 timer1_counter2 = 0;
 }

 if (timer1_counter3 >= 10) {
 rio_sendTimes();

 aac_sendTimes();

 timer1_counter3 = 0;
 }

 if (timer1_counter4 >=  166 ) {

 rio_send();
 timer1_counter4 = 0;
 }


 timer1_aac_counter += 1;
 if(timer1_aac_counter ==  25 ){
 aac_execute();
 timer1_aac_counter = 0;
 }


}

 void CAN_Interrupt() iv IVT_ADDR_C1INTERRUPT {
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


 switch (id) {
 case  0b01100001000 :
 GearShift_setCurrentGear(firstInt);
 break;

 case  0b11011000000 :
 EngineControl_resetStartCheck();
 EngineControl_start();
 break;

 case  0b10100000000 :

 if (Clutch_get() != 100
 &&(firstInt ==  100 
 || firstInt ==  50 
 || firstInt ==  200 ))
 aac_stop();

 GearShift_injectCommand(firstInt);
 break;

 case  0b01100001011 :

 aac_updateExternValue(WHEEL_SPEED, thirdInt / 10);
 aac_updateExternValue(RPM, fourthInt);

 break;

 case  0b11000000001 :

 if(dataBuffer[0] >  10 ){


 if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {

 Clutch_setBiased(dataBuffer[0]);

 }

 }

 break;

 case  0b11100001000 :
 switch(firstInt){
 case  0 :
 gearShift_timings[secondInt] = thirdInt;
 rio_sendOneTime(secondInt);
 break;
 case  1 :
 rio_sendAllTimes();

 aac_sendAllTimes();

 break;

 case  2 :
 aac_parameters[secondInt] = thirdInt;
 aac_sendOneTime(secondInt);

 default:
 break;
 }
 break;

 case  0b01100001101 :
 rio_efiData[POIL] = firstInt;
 rio_efiData[TOIL_IN] = secondInt;
 rio_efiData[TOIL_OUT] = thirdInt;
 rio_efiData[BATTERY] = fourthInt;
 break;

 case  0b01100001110 :
 rio_efiData[H2O_DC] = firstInt;
 rio_efiData[TH2O_ENGINE] = secondInt;
 rio_efiData[TH2O_IN] = thirdInt;
 rio_efiData[TH2O_OUT] = fourthInt;
 break;

 case  0b01100001111 :
 rio_efiData[P_FUEL] = firstInt;
 rio_efiData[FAN] = secondInt;
 rio_efiData[INJ1] = thirdInt;
 rio_efiData[INJ2] = fourthInt;
 break;

 case  0b11011110000 :

 dSignalLed_switch( 1 );
 if(aac_currentState == OFF


 ){
 aac_currentState = START;
 }
 else if(aac_currentState == READY){
 aac_currentState = START_RELEASE;
 }

 else
 aac_stop();

 break;

 default:
 break;
 }
}
