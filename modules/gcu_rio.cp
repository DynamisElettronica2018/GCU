#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gcu_rio.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
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
#line 3 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/gcu_rio.c"
char rio_sendingAll =  0 ;
int rio_timesCounter;
int timer1_rioEfiCounter;
int rio_efiData[ DATA_LAST ];
int rio_canId;

void rio_init(void){
 rio_canId = CAN_ID_DATA_1;
}

void rio_sendOneTime(time_id pos){
 rio_timesCounter = pos;
}

void rio_sendTimes(void)
{
 if(rio_timesCounter >= 0){
 Can_resetWritePacket();
 Can_addIntToWritePacket( 0 );
 Can_addIntToWritePacket(rio_timesCounter);
 Can_addIntToWritePacket(gearShift_timings[rio_timesCounter]);
 if(Can_write(CAN_ID_TIMES) < 0)
 Buzzer_Bip();
 rio_timesCounter -= 1;
 if(!rio_sendingAll || rio_timesCounter < 0){
 rio_sendingAll =  0 ;
 rio_timesCounter = -1;
 }
 }
}

void rio_sendAllTimes(void)
{
 if(!rio_sendingAll){
 rio_timesCounter =  TIMES_LAST ;
 rio_sendingAll =  1 ;
 }
}

void rio_send(void){
 switch(rio_canId){
 case CAN_ID_DATA_1:
 Can_resetWritePacket();
 Can_addIntToWritePacket(rio_efiData[H2O_DC]);
 Can_addIntToWritePacket(rio_efiData[TH2O_ENGINE]);
 Can_addIntToWritePacket(rio_efiData[TH2O_IN]);
 Can_addIntToWritePacket(rio_efiData[TH2O_OUT]);
 Can_write(rio_canId);
 rio_canId = CAN_ID_DATA_2;
 break;
 case CAN_ID_DATA_2:
 Can_resetWritePacket();
 Can_addIntToWritePacket(rio_efiData[POIL]);
 Can_addIntToWritePacket(rio_efiData[TOIL_IN]);
 Can_addIntToWritePacket(rio_efiData[TOIL_OUT]);
 Can_addIntToWritePacket(rio_efiData[BATTERY]);
 Can_write(rio_canId);
 rio_canId = CAN_ID_DATA_3;
 break;
 case CAN_ID_DATA_3:
 Can_resetWritePacket();
 Can_addIntToWritePacket(rio_efiData[P_FUEL]);
 Can_addIntToWritePacket(rio_efiData[FAN]);
 Can_addIntToWritePacket(rio_efiData[INJ1]);
 Can_addIntToWritePacket(rio_efiData[INJ2]);
 Can_write(rio_canId);
 rio_canId = CAN_ID_DATA_1;
 break;
 }
}
