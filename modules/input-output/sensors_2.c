/*
  04/07/2018 ottobiano DPX
*/


#include "sensors_2.h"

unsigned int getTempSensor()
{
     unsigned int analogValue = 0;
     unsigned int voltTempSensor = 0;
    unsigned int tempSensor = 0;
    analogValue = ADC1_Read(TEMP_SENSE_PIN);
    voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
    tempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
    return tempSensor;
}

void sendTempSensor(void)
{
     unsigned int temp = 0;
     temp = getTempSensor();
    Can_resetWritePacket();
    Can_addIntToWritePacket(temp);
    Can_write(GCU_DEBUG_1_ID);
}

