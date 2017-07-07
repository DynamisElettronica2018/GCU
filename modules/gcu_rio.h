#ifndef GCURIO_H
#define GCURIO_H

#include "can.h"

#define CAN_ID_TIMES    0b11100001000        //1800
#define CAN_ID_DATA     0b11100001001        //1801    //dati da EFI forward to rio

#define CODE_SET        0
#define CODE_REFRESH    1

#define DEFAULT_DELAY       100
#define DEFAULT_UP_REBOUND  100
#define DEFAULT_UP_BRAKE    100
#define DEFAULT_UP_PUSH_1_2 100
#define DEFAULT_UP_PUSH_2_3 100
#define DEFAULT_UP_PUSH_3_4 100
#define DEFAULT_UP_PUSH_4_5 100
     //down
#define DEFAULT_CLUTCH      200
#define DEFAULT_DN_PUSH     200
#define DEFAULT_DN_BRAKE    200
#define DEFAULT_DN_REBOUND  200
     //neutral
#define DEFAULT_NT_CLUTCH_DELAY 300
#define DEFAULT_NT_REBOUND_1_N  300
#define DEFAULT_NT_REBOUND_2_N  300
#define DEFAULT_NT_BRAKE_1_N    300
#define DEFAULT_NT_BRAKE_2_N    300
#define DEFAULT_NT_PUSH_1_N     300
#define DEFAULT_NT_PUSH_2_N     300
#define DEFAULT_NT_CLUTCH_1_N   300
#define DEFAULT_NT_CLUTCH_2_N   300
     //Multiple tries
#define DEFAULT_DOWN_TIME_CHECK 400
#define DEFAULT_UP_TIME_CHECK   400
#define DEFAULT_MAX_TRIES       400

#define RIO_NUM_TIMES 22    //Number of times variables (enums)

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
     NT_CLUTCH_2_N,

     //Multiple tries
     DOWN_TIME_CHECK,
     UP_TIME_CHECK,
     MAX_TRIES
     }time_id;

extern unsigned int gearShift_timings[RIO_NUM_TIMES];

extern void rio_sendOneTime(time_id pos);

extern void rio_sendAllTimes(void);

extern void rio_send(void);

#endif
