#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/libs/dspic.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
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
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/libs/dspic.c"
const double INSTRUCTION_PERIOD = 4.0 /  80 ;
const unsigned int PRESCALER_VALUES[] = {1, 8, 64, 256};

void setAllPinAsDigital(void) {
 ADPCFG = 0xFFFF;
}

void setInterruptPriority(unsigned char device, unsigned char priority) {
 switch (device) {
 case  4 :
  IPC0bits.INT0IP  = priority;
 break;
 case  5 :
  IPC4bits.INT1IP  = priority;
 break;
 case  6 :
  IPC5bits.INT2IP  = priority;
 break;
 case  8 :
  IPC9bits.INT4IP  = priority;
 break;
 case  1 :
  IPC0bits.T1IP  = priority;
 break;
 case  2 :
  IPC1bits.T2IP  = priority;
 break;
 case  3 :
  IPC5bits.T4IP  = priority;
 break;
 default:
 break;
 }
}

void setExternalInterrupt(unsigned char device, char edge) {
 setInterruptPriority(device,  4 );
 switch (device) {
 case  4 :
  INTCON2.INT0EP  = edge;
  IFS0.INT0IF  =  0 ;
  IEC0.INT0IE  =  1 ;
 break;
 case  5 :
  INTCON2.INT1EP  = edge;
  IFS1.INT1IF  =  0 ;
  IEC1.INT1IE  =  1 ;
 break;
 case  6 :
  INTCON2.INT2EP  = edge;
  IFS1.INT2IF  =  0 ;
  IEC1.INT2IE  =  1 ;
 break;
 case  8 :
  INTCON2.INT4EP  = edge;
  IFS2.INT4IF  =  0 ;
  IEC2.INT4IE  =  1 ;
 default:
 break;
 }
}

void switchExternalInterruptEdge(unsigned char device) {
 switch (device) {
 case  4 :
 if ( INTCON2.INT0EP  ==  1 ) {
  INTCON2.INT0EP  =  0 ;
 } else {
  INTCON2.INT0EP  =  1 ;
 }
 break;
 case  5 :
 if ( INTCON2.INT1EP  ==  1 ) {
  INTCON2.INT1EP  =  0 ;
 } else {
  INTCON2.INT1EP  =  1 ;
 }
 break;
 case  6 :
 if ( INTCON2.INT2EP  ==  1 ) {
  INTCON2.INT2EP  =  0 ;
 } else {
  INTCON2.INT2EP  =  1 ;
 }
 break;
 case  8 :
 if ( INTCON2.INT4EP  ==  1 ) {
  INTCON2.INT4EP  =  0 ;
 } else {
  INTCON2.INT4EP  =  1 ;
 }
 default:
 break;
 }
}

char getExternalInterruptEdge(unsigned char device) {
 switch (device) {
 case  4 :
 return  INTCON2.INT0EP ;
 case  5 :
 return  INTCON2.INT1EP ;
 case  6 :
 return  INTCON2.INT2EP ;
 case  8 :
 return  INTCON2.INT4EP ;
 default:
 return 0;
 }
}

void clearExternalInterrupt(unsigned char device) {
 switch (device) {
 case  4 :
  IFS0.INT0IF  =  0 ;
 break;
 case  5 :
  IFS1.INT1IF  =  0 ;
 break;
 case  6 :
  IFS1.INT2IF  =  0 ;
 break;
 case  8 :
  IFS2.INT4IF  =  0 ;
 default:
 break;
 }
}

void setTimer(unsigned char device, double timePeriod) {
 unsigned char prescalerIndex;
 setInterruptPriority(device,  4 );

 prescalerIndex = getTimerPrescaler(timePeriod);
 switch (device) {
 case  1 :
  PR1  = getTimerPeriod(timePeriod, prescalerIndex);
  IEC0bits.T1IE  =  1 ;
 T1CON = 0x8004;


 break;
 case  2 :
  PR2  = getTimerPeriod(timePeriod, prescalerIndex);
  IEC0bits.T2IE  =  1 ;
  T2CONbits.TON  =  1 ;
  T2CONbits.TCKPS  = prescalerIndex;
 break;
 case  3 :
  PR4  = getTimerPeriod(timePeriod, prescalerIndex);
  IEC1bits.T4IE  =  1 ;
  T4CONbits.TON  =  1 ;
  T4CONbits.TCKPS  = prescalerIndex;
 break;
 }
}

void clearTimer(unsigned char device) {
 switch (device) {
 case  1 :
  IFS0bits.T1IF  =  0 ;
 break;
 case  2 :
  IFS0bits.T2IF  =  0 ;
 break;
 case  3 :
  IFS1bits.T4IF  =  0 ;
 break;
 }
}

void turnOnTimer(unsigned char device) {
 switch (device) {
 case  1 :
  T1CONbits.TON  =  1 ;
 break;
 case  2 :
  T2CONbits.TON  =  1 ;
 break;
 case  3 :
  T4CONbits.TON  =  1 ;
 break;
 }
}

void turnOffTimer(unsigned char device) {
 switch (device) {
 case  1 :
  T1CONbits.TON  =  0 ;
 break;
 case  2 :
  T2CONbits.TON  =  0 ;
 break;
 case  3 :
  T4CONbits.TON  =  0 ;
 break;
 }
}

unsigned int getTimerPeriod(double timePeriod, unsigned char prescalerIndex) {
 return (unsigned int) ((timePeriod * 1000000) / (INSTRUCTION_PERIOD * PRESCALER_VALUES[prescalerIndex]));
}

unsigned char getTimerPrescaler(double timePeriod) {
 unsigned char i;
 double exactTimerPrescaler;
 exactTimerPrescaler = getExactTimerPrescaler(timePeriod);
 for (i = 0; i < sizeof(PRESCALER_VALUES) / 2; i += 1) {
 if ((int) exactTimerPrescaler < PRESCALER_VALUES[i]) {
 return i;
 }
 }
 i -= 1;

 return i;
}

double getExactTimerPrescaler(double timePeriod) {
 return (timePeriod * 1000000) / (INSTRUCTION_PERIOD *  65535 );
}

void setupAnalogSampling(void) {
  ADCON1bits.SSRC  =  7 ;
  ADCON1bits.FORM  =  0 ;
  ADCON1bits.ADSIDL  =  0 ;
  ADCON2bits.CSCNA  =  1 ;
  ADCON2bits.BUFM  =  0 ;
  ADCON2bits.ALTS  =  0 ;
  ADCON3bits.ADRC  =  0 ;
  ADCHSbits.CH0NB  =  0 ;
  ADCHSbits.CH0NA  =  0 ;
  ADCHSbits.CH0SB  = 0;
  ADCHSbits.CH0SA  = 0;


  ADCON3bits.ADCS  = getMinimumAnalogClockConversion();
  ADCON3bits.SAMC  = 1;

  ADPCFG  = 0b1111111111111111;
  ADCSSL  = 0;

 setAutomaticSampling();
 setAnalogVoltageReference( 0 );
 unsetAnalogInterrupt();
 startSampling();
}

void turnOnAnalogModule() {
  ADCON1bits.ADON  =  1 ;
}

void turnOffAnalogModule() {
  ADCON1bits.ADON  =  0 ;
}

void startSampling(void) {
  ADCON1bits.SAMP  =  1 ;
}

unsigned int getAnalogValue(void) {
 return  ADCBUF0 ;
}

void setAnalogPIN(unsigned char pin) {
  ADPCFG  =  ADPCFG  & ~(int) ( 1  << pin);
  ADCSSL  =  ADCSSL  | ( 1  << pin);
}

void unsetAnalogPIN(unsigned char pin) {
  ADPCFG  =  ADPCFG  | ( 1  << pin);
  ADCSSL  =  ADCSSL  & ~(int) ( 1  << pin);
}

void setAnalogInterrupt(void) {
 clearAnalogInterrupt();
  IEC0bits.ADIE  =  1 ;
}

void unsetAnalogInterrupt(void) {
 clearAnalogInterrupt();
  IEC0bits.ADIE  =  0 ;
}

void clearAnalogInterrupt(void) {
  IFS0bits.ADIF  =  0 ;
}

void setAutomaticSampling(void) {
  ADCON1bits.ASAM  =  1 ;
}

void unsetAutomaticSampling(void) {
  ADCON1bits.ASAM  =  0 ;
}

void setAnalogVoltageReference(unsigned char mode) {
  ADCON2bits.VCFG  = mode;
}

void setAnalogDataOutputFormat(unsigned char adof) {
  ADCON1bits.FORM  = adof;
}

int getMinimumAnalogClockConversion(void) {
 return (int) (( 154  *  80 ) / 500.0);
}
