#include "gcu_rio.h"

char rio_sendingAll = FALSE;
int rio_timesCounter;
int timer1_rioEfiCounter;
int rio_efiData[RIO_NUM_EFI_DATA];
int rio_canId;

void rio_init(void){
    rio_canId = CAN_ID_DATA_1;
}

void rio_sendOneTime(time_id pos){
    rio_timesCounter = pos;
}

void rio_sendTimes(void)
{
    if(rio_timesCounter >= 0){
        Can_resetWritePacket();
        Can_addIntToWritePacket(CODE_SET_TIME);
        Can_addIntToWritePacket(rio_timesCounter);
        Can_addIntToWritePacket(gearShift_timings[rio_timesCounter]);
        if(Can_write(CAN_ID_TIMES) < 0)
            Buzzer_Bip();
        rio_timesCounter -= 1;
        if(!rio_sendingAll || rio_timesCounter < 0){
            rio_sendingAll = FALSE;
            rio_timesCounter = -1;
        }
    }
}

void rio_sendAllTimes(void)
{
    if(!rio_sendingAll){
        rio_timesCounter = RIO_NUM_TIMES;
        rio_sendingAll = TRUE;
    }
}

void rio_send(void){
    switch(rio_canId){
        case CAN_ID_DATA_1:
            Can_resetWritePacket();
            Can_addIntToWritePacket(rio_efiData[H2O_DC]);
            Can_addIntToWritePacket(rio_efiData[TH2O_ENGINE]);
            Can_addIntToWritePacket(rio_efiData[TH2O_IN]);
            Can_addIntToWritePacket(rio_efiData[TH2O_OUT]);
            Can_write(rio_canId);
            rio_canId = CAN_ID_DATA_2;
            break;
        case CAN_ID_DATA_2:
            Can_resetWritePacket();
            Can_addIntToWritePacket(rio_efiData[POIL]);
            Can_addIntToWritePacket(rio_efiData[TOIL_IN]);
            Can_addIntToWritePacket(rio_efiData[TOIL_OUT]);
            Can_addIntToWritePacket(rio_efiData[BATTERY]);
            Can_write(rio_canId);
            rio_canId = CAN_ID_DATA_3;
            break;
        case CAN_ID_DATA_3:
            Can_resetWritePacket();
            Can_addIntToWritePacket(rio_efiData[P_FUEL]);
            Can_addIntToWritePacket(rio_efiData[FAN]);
            Can_addIntToWritePacket(rio_efiData[INJ1]);
            Can_addIntToWritePacket(rio_efiData[INJ2]);
            Can_write(rio_canId);
            rio_canId = CAN_ID_DATA_1;
            break;
    }
}