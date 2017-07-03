//
// Created by Aaron Russo on 17/08/16.
//

#include "sensors.h"

const unsigned char SENSORS[] = {
        FAN_CURRENT_Pin,
        H2O_PUMP_CURRENT_Pin,
        FUEL_PUMP_CURRENT_Pin,
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
        case FAN_CURRENT_Pin:
            Sensors_sampleFanCurrent(analogValue);
            break;
        case H2O_PUMP_CURRENT_Pin:
            Sensors_sampleH2OPumpCurrent(analogValue);
            break;
        case FUEL_PUMP_CURRENT_Pin:
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
    /*if (sensors_H2OSamples < PWM_SAFE_SAMPLES) {
        sensors_H2OSamples += 1;
        if (value > sensors_maxRecordedH2OCurrent) {
            sensors_maxRecordedH2OCurrent = value;
        }
    } else {
        sensors_H2OPumpCurrent = sensors_maxRecordedH2OCurrent;
        sensors_H2OSamples = 0;
        sensors_maxRecordedH2OCurrent = 0;
    }*/

    sensors_H2OPumpCurrent = sensors_H2OPumpCurrent * 0.95 + value * 0.05;
}

void Sensors_sampleFuelPumpCurrent(unsigned int value) {
    /*if (sensors_fuelPumpSamples < PWM_SAFE_SAMPLES) {
        sensors_fuelPumpSamples += 1;
        if (value > sensors_maxRecordedFuelPumpCurrent) {
            sensors_maxRecordedFuelPumpCurrent = value;
        }
    } else {
        sensors_fuelPumpCurrent = sensors_maxRecordedFuelPumpCurrent;
        sensors_fuelPumpSamples = 0;
        sensors_maxRecordedFuelPumpCurrent = 0;
    }*/

    sensors_fuelPumpCurrent = sensors_fuelPumpCurrent * 0.95 + value * 0.05;
}

void Sensors_sampleGCUTemp(unsigned int value) {
    sensors_GCUTemp = sensors_GCUTemp * 0.95 + value * 0.05;
}