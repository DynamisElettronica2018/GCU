/*
  04/07/2018 ottobiano DPX
*/

#ifndef FIRMWARE_SENSORS_2_H
#define FIRMWARE_SENSORS_2_H

#include "can.h"
#include "dspic.h"

#define TEMP_SENSE_PIN 10

unsigned int getTempSensor();

void sendTempSensor(void);


#endif //FIRMWARE_SENSORS_2_H