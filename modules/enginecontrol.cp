#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/enginecontrol.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/enginecontrol.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 22 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 25 "c:/users/salvatore/desktop/git repo/gcu/modules/enginecontrol.h"
void EngineControl_init(void);

void EngineControl_keyOn(void);

void EngineControl_keyOff(void);

void EngineControl_start(void);

void EngineControl_stop(void);

void EngineControl_resetStartCheck(void);

char EngineControl_isStarting(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/enginecontrol.c"
unsigned char engineControl_isChecking;
unsigned char engineControl_startCheckCounter;

void EngineControl_init(void) {
  TRISD.B5  =  0 ;
  TRISG.B15  =  0 ;

  RG15_bit  =  1 ;
 engineControl_isChecking =  0 ;
 EngineControl_resetStartCheck();
 EngineControl_stop();
}


void EngineControl_keyOn(void) {
  RG15_bit  =  1 ;
}


void EngineControl_keyOff(void) {
  RG15_bit  =  0 ;
}

void EngineControl_start(void) {
  LATD5_biT  =  1 ;
}

void EngineControl_stop(void) {
  LATD5_biT  =  0 ;
}

void EngineControl_resetStartCheck(void) {
 engineControl_startCheckCounter = 0;
}

char EngineControl_isStarting(void) {
 if (engineControl_startCheckCounter <  4 ) {
 engineControl_startCheckCounter += 1;
 return  1 ;
 } else {
 return  0 ;
 }
}
