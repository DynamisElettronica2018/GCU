#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/buzzer.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
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
#line 17 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/buzzer.c"
unsigned int buzzer_ticks = 0, buzzer_bipTicks;

 void timer4_interrupt() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {
  IFS1bits.T4IF  = 0 ;
 Buzzer_tick();
}

void Buzzer_init(void) {
  TRISG13_bit  =  0 ;
  RG13_bit  = 0;
 setTimer( 3 ,  0.0005 );
 setInterruptPriority( 3 ,  5 );
 buzzer_bipTicks = (int)( 1  /  0.0005 );
}

void Buzzer_tick(void) {
 if (buzzer_ticks > 0) {
 buzzer_ticks -= 1;
  RG13_bit  = ! RG13_bit ;
 }
 else
  RG13_bit  = 0;
}

void Buzzer_Bip(void) {
 buzzer_ticks = buzzer_bipTicks;
}
