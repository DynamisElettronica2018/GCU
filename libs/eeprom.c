//
// Created by Aaron Russo on 18/07/16.
//

#include "eeprom.h"

void EEPROM_writeInt(unsigned int address, unsigned int value) {
    unsigned int currentValue;
    currentValue = EEPROM_read(address);
    if (currentValue != value) {
        EEPROM_write(address, value);
    }
}

unsigned int EEPROM_readInt(unsigned int address) {
    return EEPROM_read(address);
}

void EEPROM_writeArray(unsigned int address, unsigned int *values) {
    unsigned int i;
    for (i = 0; i < sizeof(values); i += 1) {
        EEPROM_writeInt(address, values[i]);
    }
}

void EEPROM_readArray(unsigned int address, unsigned int *values) {
    unsigned int i;
    for (i = 0; i < sizeof(values); i += 1) {
        values[i] = EEPROM_read(address + i);
    }
}