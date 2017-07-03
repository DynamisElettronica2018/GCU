#ifndef GCURIO_H
#define GCURIO_H

#include "can.h"

#define CAN_ID_TIMES    0b11100001000        //1800
#define CAN_ID_DATA     0b11100001001        //1801    //dati da EFI forward to rio

#define CODE_SET        0
#define CODE_REFRESH    1

#define NUM_TIMES 19    //Number of times variables (enums)

typedef enum {
     //Up
     DELAY,
     UP_REBOUND,
     UP_BRAKE,
     UP_PUSH_1_2,
     UP_PUSH_2_3,
     UP_PUSH_3_4,
     UP_PUSH_4_5,
     //down
     CLUTCH,
     DN_PUSH,
     DN_BRAKE,
     DN_REBOUND,
     //neutral
     NT_CLUTCH_DELAY,
     NT_REBOUND_1_N,
     NT_REBOUND_2_N,
     NT_BRAKE_1_N,
     NT_BRAKE_2_N,
     NT_PUSH_1_N,
     NT_PUSH_2_N,
     NT_CLUTCH_1_N,
     NT_CLUTCH_2_N
     }time_id;

extern unsigned int gearShift_timings[NUM_TIMES];

extern void sendOneTime(time_id pos);

extern void sendAllTimes(void);

#endif