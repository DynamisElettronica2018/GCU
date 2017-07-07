#include "gcu_rio.h"

char rio_sendingAll = FALSE;
int rio_timesCounter;

void rio_sendOneTime(time_id pos){
    rio_timesCounter = pos;
}

void rio_send(void)
{
    if(rio_timesCounter >= 0){
        Can_resetWritePacket();
        Can_addIntToWritePacket(CODE_SET);
        Can_addIntToWritePacket(rio_timesCounter);
        Can_addIntToWritePacket(gearShift_timings[rio_timesCounter]);
        Can_write(CAN_ID_TIMES);
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
