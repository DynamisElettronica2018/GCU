//
// Created by Aaron Russo on 17/08/16.
//

#ifndef FIRMWARE_SENSORS_H
#define FIRMWARE_SENSORS_H

#include "d_can.h"
#include "dspic.h"

#define PWM_SAFE_SAMPLES    400

#define FAN_CURRENT_Pin         AN5    //Analog 0 - tot
#define H2O_PUMP_CURRENT_Pin    AN4    //PWM
#define FUEL_PUMP_CURRENT_Pin   AN3    //PWM
//#define GCU_TEMP_Pin            AN2    //Analog 0.1 ~ 1.75 | -40° ~ 125°

#define BRIDGE_CURRENT_1_Pin    AN11
#define BRIDGE_CURRENT_2_Pin    AN12
//modificato per test invio corrente KST efi debug display
#define SERVO_CURRENT_3_Pin     AN2      //PWM //Mando il massimo da quando si è mosso

void Sensors_init(void);

void Sensors_tick(void);

void Sensors_read(void);

void Sensors_nextPin(void);

void Sensors_send(void);

void Sensors_sampleFanCurrent(unsigned int value);

void Sensors_sampleH2OPumpCurrent(unsigned int value);

void Sensors_sampleFuelPumpCurrent(unsigned int value);

void Sensors_sampleGCUTemp(unsigned int value);

#endif //FIRMWARE_SENSORS_H