#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/sensors.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/sensors.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu/libs/d_can.h"
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
#line 23 "c:/users/salvatore/desktop/git repo/gcu/modules/input-output/sensors.h"
void Sensors_init(void);

void Sensors_tick(void);

void Sensors_read(void);

void Sensors_nextPin(void);

void Sensors_send(void);

void Sensors_sampleFanCurrent(unsigned int value);

void Sensors_sampleH2OPumpCurrent(unsigned int value);

void Sensors_sampleFuelPumpCurrent(unsigned int value);

void Sensors_sampleGCUTemp(unsigned int value);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/sensors.c"
const unsigned char SENSORS[] = {
  5 ,
  4 ,
  3 ,
 GCU_TEMP_Pin
};

unsigned char sensors_pinIndex = 0;

unsigned int sensors_fanCurrent,
 sensors_H2OPumpCurrent,
 sensors_fuelPumpCurrent,
 sensors_GCUTemp;

unsigned int sensors_H2OSamples = 0,
 sensors_fuelPumpSamples = 0,
 sensors_maxRecordedH2OCurrent = 0,
 sensors_maxRecordedFuelPumpCurrent = 0;

void Sensors_init(void) {
 setupAnalogSampling();
 setAnalogPIN(SENSORS[sensors_pinIndex]);
 turnOnAnalogModule();
}

void Sensors_send(void) {
 Can_resetWritePacket();
 Can_addIntToWritePacket(sensors_fanCurrent);
 Can_addIntToWritePacket(sensors_fuelPumpCurrent);
 Can_addIntToWritePacket(sensors_GCUTemp);
 Can_addIntToWritePacket(sensors_H2OPumpCurrent);
 Can_write(GCU_SENSE_ID);
}

void Sensors_tick(void) {
 Sensors_read();
 Sensors_nextPin();
}

void Sensors_read(void) {
 unsigned int analogValue;
 analogValue = getAnalogValue();
 switch (SENSORS[sensors_pinIndex]) {
 case  5 :
 Sensors_sampleFanCurrent(analogValue);
 break;
 case  4 :
 Sensors_sampleH2OPumpCurrent(analogValue);
 break;
 case  3 :
 Sensors_sampleFuelPumpCurrent(analogValue);
 break;
 case GCU_TEMP_Pin:
 Sensors_sampleGCUTemp(analogValue);
 break;
 default:
 break;
 }
}

void Sensors_nextPin(void) {
 unsetAnalogPIN(SENSORS[sensors_pinIndex]);
 sensors_pinIndex += 1;
 if (sensors_pinIndex == sizeof(SENSORS)) {
 sensors_pinIndex = 0;
 }
 setAnalogPIN(SENSORS[sensors_pinIndex]);
}

void Sensors_sampleFanCurrent(unsigned int value) {
 sensors_fanCurrent = sensors_fanCurrent * 0.95 + value * 0.05;
}

void Sensors_sampleH2OPumpCurrent(unsigned int value) {
#line 92 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/sensors.c"
 sensors_H2OPumpCurrent = sensors_H2OPumpCurrent * 0.95 + value * 0.05;
}

void Sensors_sampleFuelPumpCurrent(unsigned int value) {
#line 107 "C:/Users/Salvatore/Desktop/git Repo/GCU/modules/input-output/sensors.c"
 sensors_fuelPumpCurrent = sensors_fuelPumpCurrent * 0.95 + value * 0.05;
}

void Sensors_sampleGCUTemp(unsigned int value) {
 sensors_GCUTemp = sensors_GCUTemp * 0.95 + value * 0.05;
}
