//
// Created by Aaron Russo on 18/07/16.
//

#ifndef FIRMWARE_EEPROM_H
#define FIRMWARE_EEPROM_H

void EEPROM_writeInt(unsigned int address, unsigned int value);

unsigned int EEPROM_readInt(unsigned int address);

void EEPROM_writeArray(unsigned int address, unsigned int *values);

void EEPROM_readArray(unsigned int address, unsigned int *values);

#endif //FIRMWARE_EEPROM_H
