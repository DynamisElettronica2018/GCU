#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/gearmotor.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/gearmotor.h"
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
#line 26 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/gearmotor.h"
void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/gearmotor.c"
void GearMotor_init(void) {
  TRISB0_bit  =  0 ;
  TRISC1_bit  =  0 ;
  TRISB1_bit  =  0 ;
 GearMotor_release();
}

void GearMotor_turnLeft(void) {
  LATB0_bit  = 0;
  LATC1_bit  = 1;
  LATB1_bit  = 1;
}

void GearMotor_turnRight(void) {
  LATB0_bit  = 1;
  LATC1_bit  = 0;
  LATB1_bit  = 1;
}

void GearMotor_brake(void) {
  LATB0_bit  = 0;
  LATC1_bit  = 0;
  LATB1_bit  = 1;
}

void GearMotor_release(void) {
  LATB1_bit  = 0;
}
