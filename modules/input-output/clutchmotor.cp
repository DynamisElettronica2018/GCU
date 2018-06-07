#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/clutchmotor.c"
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
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/clutchmotor.c"
unsigned int CLUTCHMOTOR_PWM_PERIOD_VALUE;
double CLUTCHMOTOR_PERCENTAGE_STEP;
unsigned int CLUTCHMOTOR_PWM_MAX_VALUE;
unsigned int CLUTCHMOTOR_PWM_MIN_VALUE;

 void timer2_interrupt() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
  IFS0bits.T2IF  = 0 ;
}

void ClutchMotor_init(void) {
 setTimer( 2 ,  0.020 );
 ClutchMotor_setupPWM();
}

void ClutchMotor_setupPWM(void) {
 OC8CON = 0x6;
 CLUTCHMOTOR_PWM_PERIOD_VALUE = getTimerPeriod( 0.020 ,  T2CONbits.TCKPS );

 CLUTCHMOTOR_PWM_MAX_VALUE = (unsigned int) (CLUTCHMOTOR_PWM_PERIOD_VALUE *
 ( 11  / 100.0));
 CLUTCHMOTOR_PWM_MIN_VALUE = (unsigned int) (CLUTCHMOTOR_PWM_PERIOD_VALUE *
 ( 5  / 100.0));
 CLUTCHMOTOR_PERCENTAGE_STEP = (CLUTCHMOTOR_PWM_MAX_VALUE - CLUTCHMOTOR_PWM_MIN_VALUE) / 100.0;
 OC8R = CLUTCHMOTOR_PWM_MIN_VALUE;
 ClutchMotor_setPosition(100);
}

void ClutchMotor_setPosition(unsigned char percentage) {
 unsigned int pwmValue;
 pwmValue = (unsigned int) ((percentage * CLUTCHMOTOR_PERCENTAGE_STEP) + CLUTCHMOTOR_PWM_MIN_VALUE);
 if (pwmValue > CLUTCHMOTOR_PWM_MAX_VALUE) {
 pwmValue = CLUTCHMOTOR_PWM_MAX_VALUE;
 } else if (pwmValue < CLUTCHMOTOR_PWM_MIN_VALUE) {
 pwmValue = CLUTCHMOTOR_PWM_MIN_VALUE;
 }
 OC8RS = pwmValue;
}
