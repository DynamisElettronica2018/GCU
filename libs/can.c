//
// Created by Aaron Russo on 03/07/16.
//

#include "can.h"

/*
BRP =  1, 2, 4 se rispettivamente Fck = 20 40 80 MHz
Steering Wheel  dsPIC30F6012A CAN1 80MHz
*/

/*
 * Come usare la libreria CAN
 *
 * Per mandare interi
 * > Can_writeInt(indirizzo, valore);
 *
 * Per mandare byte
 * > Can_writeByte(indirizzo, valore);
 *
 * Per mandare pacchetti (esempio int + byte)
 * > Can_resetWritePacket();
 * > Can_addIntToWritePacket(valore);
 * > Can_addByteToWritePacket(valore);
 * > Can_write(indirizzo);
 */

//#define CAN_PACKET_SIZE 8

unsigned char can_dataOutBuffer[CAN_PACKET_SIZE];
unsigned int can_dataOutLength = 0;
unsigned int can_txPriority = CAN_PRIORITY_MEDIUM;
unsigned int can_err = 0;

void Can_init() {
    unsigned int Can_Init_flags = 0;
    Can_Init_flags = _CAN_CONFIG_STD_MSG &             // standard identifier 11 bit
                     _CAN_CONFIG_DBL_BUFFER_ON &       // double buffer mode MODIFICABILE
                     _CAN_CONFIG_MATCH_MSG_TYPE &
                     _CAN_CONFIG_LINE_FILTER_ON &      // wake up by line
                     _CAN_CONFIG_SAMPLE_THRICE &       // for robustness
                     _CAN_CONFIG_PHSEG2_PRG_ON;        // these last two are linked to sync
    CAN1Initialize(2, 4, 3, 4, 2, Can_Init_flags);          // SJW,BRP,PHSEG1,PHSEG2,PROPSEG
    CAN1SetOperationMode(_CAN_MODE_CONFIG, 0xFF);

    CAN1SetMask(_CAN_MASK_B1, 0b00100000000, _CAN_CONFIG_MATCH_MSG_TYPE & _CAN_CONFIG_STD_MSG);
    CAN1SetFilter(_CAN_FILTER_B1_F1, 0b00100000000, _CAN_CONFIG_STD_MSG);
    CAN1SetFilter(_CAN_FILTER_B1_F2, 0b00100000000, _CAN_CONFIG_STD_MSG);

    CAN1SetMask(_CAN_MASK_B2, 0b11100000100, _CAN_CONFIG_MATCH_MSG_TYPE & _CAN_CONFIG_STD_MSG);
    CAN1SetFilter(_CAN_FILTER_B2_F1, 0b11000000000, _CAN_CONFIG_STD_MSG);

    CAN1SetOperationMode(_CAN_MODE_NORMAL, 0xFF);

    Can_initInterrupt();
    Can_setWritePriority(CAN_PRIORITY_MEDIUM);
}

void Can_read(unsigned long int *id, char dataBuffer[], unsigned int *dataLength, unsigned int *inFlags) {
    if (Can_B0hasBeenReceived()) {
        Can_clearB0Flag();
        Can1Read(id, dataBuffer, dataLength, &inFlags);
    }
    else if (Can_B1hasBeenReceived()) {
        Can_clearB1Flag();
        Can1Read(id, dataBuffer, dataLength, &inFlags);
    }
}

void Can_writeByte(unsigned long int id, unsigned char dataOut) {
    Can_resetWritePacket();
    Can_addByteToWritePacket(dataOut);
    Can_write(id);
}

void Can_writeInt(unsigned long int id, int dataOut) {
    Can_resetWritePacket();
    Can_addIntToWritePacket(dataOut);
    Can_write(id);
}

void Can_addIntToWritePacket(int dataOut) {
    Can_addByteToWritePacket((unsigned char) (dataOut >> 8));
    Can_addByteToWritePacket((unsigned char) (dataOut & 0xFF));
}

void Can_addByteToWritePacket(unsigned char dataOut) {
    can_dataOutBuffer[can_dataOutLength] = dataOut;
    can_dataOutLength += 1;
}

void Can_write(unsigned long int id) {
    unsigned int sent, i;
    do {
        sent = CAN1Write(id, can_dataOutBuffer, can_dataOutLength, Can_getWriteFlags());
        i += 1;
    } while ((sent == 0) && (i < CAN_RETRY_LIMIT));
    if (i == CAN_RETRY_LIMIT) {
        can_err++;
    }
}

void Can_setWritePriority(unsigned int txPriority) {
    can_txPriority = txPriority;
}

void Can_resetWritePacket(void) {
    for (can_dataOutLength = 0; can_dataOutLength < CAN_PACKET_SIZE; can_dataOutLength += 1) {
        can_dataOutBuffer[can_dataOutLength] = 0;
    }
    can_dataOutLength = 0;
}

unsigned int Can_getWriteFlags(void) {
    return CAN_DEFAULT_FLAGS & can_txPriority;
}

unsigned char Can_B0hasBeenReceived(void) {
    return CAN_INTERRUPT_ONB0_OCCURRED == 1;
}

unsigned char Can_B1hasBeenReceived(void) {
    return CAN_INTERRUPT_ONB1_OCCURRED == 1;
}

void Can_clearB0Flag(void) {
    CAN_INTERRUPT_ONB0_OCCURRED = 0;
}

void Can_clearB1Flag(void) {
    CAN_INTERRUPT_ONB1_OCCURRED = 0;
}

void Can_clearInterrupt(void) {
    CAN_INTERRUPT_OCCURRED = 0;
}

void Can_initInterrupt(void) {
    //@formatter:off
    INTERRUPT_PROTECT(IEC1BITS.C1IE = 1);
    INTERRUPT_PROTECT(C1INTEBITS.RXB0IE = 1); //An interrupt is generated everytime that a message passes through the mask in buffer 0
    INTERRUPT_PROTECT(C1INTEBITS.RXB1IE = 1); //Suddividere gli ID da ricevere nei due buffer
//@formatter:on
            }