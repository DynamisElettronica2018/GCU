#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/d_signalled.c"
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
#line 22 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/d_signalled.c"
void dSignalLed_init(void) {
  TRISG14_bit  =  0 ;
 dSignalLed_unset( 0 );
}

void dSignalLed_switch(unsigned char led) {
 switch (led) {
 case  0 :
  RG14_bit  = ! RG14_bit ;
 break;
 }
}

void dSignalLed_set(unsigned char led) {
 switch (led) {
 case  0 :
  RG14_bit  =  1 ;
 break;
 }
}

void dSignalLed_unset(unsigned char led) {
 switch (led) {
 case  0 :
  RG14_bit  =  0 ;
 break;
 }
}
