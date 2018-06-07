#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/stoplight.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/stoplight.h"
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
#line 17 "c:/users/salvatore/desktop/git repo/gcu/modules/stoplight.h"
void StopLight_init(void);

void StopLight_setupPWM(void);

void StopLight_setBrightness(unsigned char percentage);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/stoplight.c"
unsigned int STOPLIGHT_PWM_PERIOD_VALUE;
double STOPLIGHT_PERCENTAGE_STEP;
unsigned int STOPLIGHT_PWM_VALUE;

void StopLight_init(void) {
 StopLight_setupPWM();
}

void StopLight_setupPWM(void) {
 OC7CON = 0x6;
 STOPLIGHT_PWM_PERIOD_VALUE = getTimerPeriod( 0.020 ,  T2CONbits.TCKPS );
 STOPLIGHT_PWM_VALUE = (unsigned int) (STOPLIGHT_PWM_PERIOD_VALUE *
 ( 95  / 100.0));
 OC7R = STOPLIGHT_PWM_VALUE;
 OC7RS = STOPLIGHT_PWM_VALUE;
}

void StopLight_setBrightness(unsigned char percentage) {
 unsigned int pwmValue;
 pwmValue = (unsigned int) (STOPLIGHT_PWM_PERIOD_VALUE * (percentage / 100.0));
 if (pwmValue > 100) {
 pwmValue = (unsigned int) STOPLIGHT_PWM_PERIOD_VALUE;
 } else if (pwmValue < 0) {
 pwmValue = 1;
 }
 OC7RS = pwmValue;
}
