#include "gcu_rio.h"

void sendOneTime(time_id pos)
{
    Can_resetWritePacket();
    Can_addIntToWritePacket(CODE_SET);
    Can_addIntToWritePacket(pos);
    Can_addIntToWritePacket(gearShift_timings[pos]);
    Can_write(CAN_ID_TIMES);
}

void sendAllTimes(void)
{
     int i;
     for(i = 0; i < NUM_TIMES; i++)
          sendOneTime(i);
}