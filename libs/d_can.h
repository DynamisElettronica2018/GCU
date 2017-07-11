//
// Created by Aaron Russo on 03/07/16.
//

#ifndef DP8_DISPLAY_CONTROLLER_DD_CAN_H
#define DP8_DISPLAY_CONTROLLER_DD_CAN_H

#include "can.h"

/*
                MASCHERE RICEZIONE
SW     xx1xxxxxxxx     da EFI pi˘ SW_RIO_GEAR_BRK_STEER_ID mandato da rio
       110xxxxxx1x     dagli altri

GCU    xx1xxxxxxxx     RXB0     da EFI pi˘ SW_RIO_GEAR_BRK_STEER_ID mandato da entrambi
       110xxxxx0xx     RXB1     dagli altri

EBB    x1x0x001101     RXB0     batteria ed ebbtarget
       10100000000     RXB1     brake

IMPLEMENTARE CANerror, che livello di complessit‡? quali errori?

*/

#define SW_RIO_GEAR_BRK_STEER_ID      0b10100000000 //1280
#define RIO_IR_PITOT_CL_ID    0b11001111011 //dec 1659
#define RIO_SOSP_ID           0b10100000001 //dec 1281
#define RIO_AUX_ID            0b11011101011 //dec 1771

#define GCU_SENSE_ID          0b11011001110 //dec 1742
#define GCU_CLUTCH_ID         0b11000010111 //dec 1559
#define GCU_MOTOR_ID          0b11000110110 //dec 1590
#define GCU_KILL_ID           0b11010001110 //dec 1678
#define GCU_AUX_ID            0b11011011110 //dec 1758

#define SW_CLUTCH_ID          0b11000000001 //dec 1537
#define SW_FIRE_ID            0b11011000000 //dec 1728
#define SW_EBB_ID             0b11001001101 //dec 1613
#define SW_LAUNCH_ID          0b11010011001 //dec 1689
#define SW_COMMAND_ID         0b11010101100 //dec 1708
#define SW_AUX_ID             0b11011110000 //dec 1776

#define EBB_ID                0b11001100110 //dec 1638
#define EBB_AUX_ID            0b11011111010 //dec 1786

#define EFI_HALL_ID           0b01100000111 //dec 775
#define EFI_GEAR_ID           0b01100001000 //dec 776
#define EFI_APPS_TPS_ID       0b01100001001 //dec 777
#define EFI_MAP_LAMBDA_ID     0b01100001010 //dec 778
#define EFI_FUEL_RPM_ID       0b01100001011 //dec 779
#define EFI_FAULT_DIAG_ID     0b01100001100 //dec 780
#define EFI_OIL_BATT_ID       0b01100001101 //dec 781
#define EFI_H2O_ID            0b01100001110 //dec 782
#define EFI_MIXED_ID          0b01100001111 //dec 783

#define LAP_ID                0b11000100110 //dec 1574
#define LAP_AUX_ID            0b11011010010 //dec 1746

#define CAN_COMMAND_GCU_IS_ALIVE                99
#define CAN_COMMAND_CHANGE_SHIFT_TIMING         100
#define CAN_COMMAND_SAVE_SHIFT_TIMINGS          101
#define CAN_COMMAND_CONFIRM_SHIFT_TIMING_CHANGE 102
#define CAN_COMMAND_CONFIRM_SHIFT_TIMING_SAVE   103


#endif //DP8_DISPLAY_CONTROLLER_DD_CAN_H