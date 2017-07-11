#include "gcu_rio.h"

char rio_sendingAll = FALSE;
int rio_timesCounter;
int rio_efiDataCounter = DATA_LAST - 1;
int timer1_rioEfiCounter;
int rio_efiData[RIO_NUM_EFI_DATA];
int rio_canId;

void rio_sendOneTime(time_id pos){
    rio_timesCounter = pos;
}

void rio_sendTimes(void)
{
    if(rio_timesCounter >= 0){
        Can_resetWritePacket();
        Can_addIntToWritePacket(CODE_SET);
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
    Can_resetWritePacket();
    Can_addIntToWritePacket(rio_efiData[rio_efiDataCounter - 3]);
    Can_addIntToWritePacket(rio_efiData[rio_efiDataCounter - 2]);
    Can_addIntToWritePacket(rio_efiData[rio_efiDataCounter - 1]);
    Can_addIntToWritePacket(rio_efiData[rio_efiDataCounter]);
    Can_write(rio_canId);
    rio_efiDataCounter -= 4;
    if(rio_efiDataCounter < 3){
        timer1_rioEfiCounter = RIO_UPDATE_RATE_ms - RIO_BETWEEN_TIME_ms * ((DATA_LAST / 4) - 1);
        rio_efiDataCounter = DATA_LAST - 1;
        rio_canId = CAN_ID_DATA_3;
    }
    else{
        timer1_rioEfiCounter = RIO_BETWEEN_TIME_ms;
        switch(rio_canId){
            case CAN_ID_DATA_3:
                rio_canId = CAN_ID_DATA_2;
                break;
            case CAN_ID_DATA_2:
                rio_canId = CAN_ID_DATA_1;
                break;
        }
    }
}