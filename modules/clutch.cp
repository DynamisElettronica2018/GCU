#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/clutch.c"
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
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/clutch.c"
unsigned char Clutch_currentValue = 0;

void Clutch_insert(void) {
 Clutch_set(100);
}

void Clutch_release(void) {
 Clutch_set(0);
}

void Clutch_set(unsigned char percentage) {
 unsigned char actualPercentage = 0;
 if (percentage > 100) {
 actualPercentage = 100;
 } else {
 actualPercentage = percentage;
 }
 ClutchMotor_setPosition(100 - actualPercentage);
 Clutch_currentValue = actualPercentage;
}

unsigned char Clutch_get(void) {
 return Clutch_currentValue;
}

void Clutch_setBiased(unsigned char value){
 int actual_value;
 if(value >=  95 )
 Clutch_set(value);
 else{
 actual_value = ( 70  * value) / 100;
 Clutch_set(actual_value);
 }
}
