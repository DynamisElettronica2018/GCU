#ifndef GCURIO_H
#define GCURIO_H

#include "can.h"
#include "buzzer.h"

#define CODE_SET_TIME  0
#define CODE_REFRESH   1
#define CODE_SET_AAC   2

#define RIO_UPDATE_RATE_ms 166     //Time between two CAN mex with same data
//#define RIO_BETWEEN_TIME_ms 250      //Time between two CAN mex with different data

#define DEFAULT_DELAY       20
#define DEFAULT_UP_REBOUND  15
#define DEFAULT_UP_BRAKE    20
#define DEFAULT_UP_PUSH_1_2 115
#define DEFAULT_UP_PUSH_2_3 100
#define DEFAULT_UP_PUSH_3_4 100
#define DEFAULT_UP_PUSH_4_5 100
     //down
#define DEFAULT_CLUTCH      70
#define DEFAULT_DN_PUSH     100
#define DEFAULT_DN_BRAKE    15
#define DEFAULT_DN_REBOUND  20
     //neutral
#define DEFAULT_NT_CLUTCH_DELAY 20
#define DEFAULT_NT_REBOUND_1_N  15
#define DEFAULT_NT_REBOUND_2_N  15
#define DEFAULT_NT_BRAKE_1_N    35
#define DEFAULT_NT_BRAKE_2_N    35
#define DEFAULT_NT_PUSH_1_N     22
#define DEFAULT_NT_PUSH_2_N     25
#define DEFAULT_NT_CLUTCH_1_N   300
#define DEFAULT_NT_CLUTCH_2_N   300
     //Multiple tries
#define DEFAULT_DOWN_TIME_CHECK 500
#define DEFAULT_UP_TIME_CHECK   500
#define DEFAULT_MAX_TRIES       2

typedef enum {
     //Neutral 1->N
     NT_PUSH_1_N,
     NT_CLUTCH_1_N,
     NT_REBOUND_1_N,
     NT_BRAKE_1_N,
    //Neutral 2->N
     NT_PUSH_2_N,
     NT_CLUTCH_2_N,
     NT_REBOUND_2_N,
     NT_BRAKE_2_N,
    //Downshift
     DN_PUSH,
     CLUTCH,
     DN_REBOUND,
     DN_BRAKE,
    //Upshift gear specific
     UP_PUSH_1_2,
     UP_PUSH_2_3,
     UP_PUSH_3_4,
     UP_PUSH_4_5,
    //Up generics
     DELAY,
     UP_REBOUND,
     UP_BRAKE,
    //neutral
     NT_CLUTCH_DELAY,

     //Multiple tries
     DOWN_TIME_CHECK,
     UP_TIME_CHECK,
     MAX_TRIES,

     //Keep Last
     TIMES_LAST
     }time_id;

 typedef enum{
    //H2O
     H2O_DC,
     TH2O_ENGINE,
     TH2O_IN,
     TH2O_OUT,
    //Oil and Battery
     POIL,
     TOIL_IN,
     TOIL_OUT,
     BATTERY,
    //Fan and Fuel
     P_FUEL,
     FAN,
     INJ1,
     INJ2,
     //Keep Last
     DATA_LAST
 }efi_dataIds;

#define RIO_NUM_TIMES TIMES_LAST    //Number of times variables (enums)
#define RIO_NUM_EFI_DATA DATA_LAST    //Number of times variables (enums)

extern unsigned int gearShift_timings[RIO_NUM_TIMES];

void rio_init(void);

extern void rio_sendOneTime(time_id pos);

extern void rio_sendAllTimes(void);

extern void rio_sendTimes(void);

extern void rio_send(void);

#endif