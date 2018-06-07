#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/efi.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/efi.h"
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
#line 23 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/efi.h"
void Efi_init(void);

void Efi_setCut(void);

void Efi_unsetCut(void);

void Efi_setBlip(void);

void Efi_unsetBlip(void);

void Efi_setRPMLimiter(void);

void Efi_unsetRPMLimiter(void);

void Efi_setRPMLimiter_CAN(unsigned int limit);

void Efi_unsetRPMLimiter_CAN(unsigned int limit);
#line 6 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/efi.c"
void Efi_init(void) {
  TRISD2_bit  =  0 ;
  TRISD3_bit  =  0 ;
  TRISD4_bit  =  0 ;
  RD4_bit  = 0;
 Efi_unsetBlip();
 Efi_unsetCut();
 Efi_unsetRPMLimiter();
}

void Efi_setCut(void) {
  RD3_bit  =  0 ;
}

void Efi_unsetCut(void) {
  RD3_bit  =  1 ;
}

void Efi_setBlip(void) {
  RD2_bit  =  0 ;
}

void Efi_unsetBlip(void) {
  RD2_bit  =  1 ;
}

void Efi_setRPMLimiter(void){
  RD4_bit  =  0 ;
}

void Efi_unsetRPMLimiter(void){
  RD4_bit  =  1 ;
}
