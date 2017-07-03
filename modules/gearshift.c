//
// Created by Aaron Russo on 16/07/16.
//

#include "gearshift.h"

unsigned int gearShift_currentGear;
int gearShift_ticksCounter1, gearShift_ticksCounter2;
char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;
unsigned char gearShift_nextStepValue_A, gearShift_nextStepValue_B;

//extern unsigned int gearShift_timings[NUM_TIMES];

void GearShift_init(void) {
    gearShift_currentGear = 0;
    gearShift_isShiftingUp = FALSE;
    gearShift_isShiftingDown = FALSE;
    gearShift_isSettingNeutral = FALSE;
    gearShift_isUnsettingNeutral = FALSE;
    gearShift_ticksCounter1 = 0;
    gearShift_ticksCounter2 = 0;
    GearShift_loadDefaultTimings();
}

void GearShift_setCurrentGear(unsigned int gear) {
    if (gear <= 5) {
        gearShift_currentGear = gear;
    }
}

void GearShift_injectCommand(unsigned int command) {
    if (command == GEAR_COMMAND_NEUTRAL_DOWN || command == GEAR_COMMAND_NEUTRAL_UP) {
        GearShift_setNeutral(command);
    } else if (command == GEAR_COMMAND_DOWN || command == GEAR_COMMAND_UP) {
        GearShift_shift(command);
    } else if (command == RPM_LIMITER_ON) {
        Efi_setRPMLimiter();
    } else if (command == RPM_LIMITER_OFF) {
        Efi_unsetRPMLimiter();
    }
}

void GearShift_shift(unsigned int command) {
    //GearShift_loadDefaultTimings();                     //Non dovrebbe servire
    if (gearShift_currentGear == GEARSHIFT_NEUTRAL) {
        gearShift_isUnsettingNeutral = TRUE;
    }
    if (command == GEAR_COMMAND_UP) {
        GearShift_up();
    } else if (command == GEAR_COMMAND_DOWN) {
        GearShift_down();
    }
}

void GearShift_setNeutral(unsigned int command) {
    gearShift_isSettingNeutral = TRUE;
//    GearShift_loadNeutralTimings();
    if (command == GEAR_COMMAND_NEUTRAL_DOWN) {
        GearShift_down();
    } else if (command == GEAR_COMMAND_NEUTRAL_UP) {
        GearShift_up();
    }
}

void GearShift_up(void) {
    Can_writeInt(GCU_CLUTCH_ID, 3);//Debug
    if (!GearShift_isShifting()) {
        gearShift_isShiftingUp = TRUE;
        GearShift_setNextStep_A(STEP_UP_START);
        GearShift_nextStep_A();
    }
}

void GearShift_down(void) {
    Can_writeInt(GCU_CLUTCH_ID, 4);//Debug
    if (!GearShift_isShifting()) {
        gearShift_isShiftingDown = TRUE;
        GearShift_setNextStep_A(STEP_DOWN_START);
        GearShift_nextStep_A();
    }
}

char GearShift_isShifting(void) {
    return gearShift_isShiftingDown || gearShift_isShiftingUp;
}

void GearShift_setNextStep_A(unsigned char step) {
    gearShift_nextStepValue_A = step;
}

void GearShift_setNextStep_B(unsigned char step) {
    gearShift_nextStepValue_B = step;
}

//All shifting steps
/*
void GearShift_nextStep_A(void) {
    switch (gearShift_nextStepValue_A) {
        case STEP_UP_START:
            if (gearShift_isSettingNeutral) {
                Clutch_set(80);
            } else {
                Efi_setCut();
                Buzzer_Bip();
            }
            GearShift_setNextStep_A(STEP_UP_PUSH);
            GearShift_setMsTicks_A(gearShift_timings[STEP_UP_START]);
            break;
        case STEP_UP_PUSH:
            if (!gearShift_isSettingNeutral) {
                Efi_unsetCut();
            }
            GearShift_upPush();
            GearShift_setNextStep_A(STEP_UP_REBOUND);
            GearShift_setMsTicks_A(gearShift_timings[STEP_UP_PUSH]);
            break;
        case STEP_UP_REBOUND:
            if (gearShift_isSettingNeutral) {
                Clutch_release();
            }
            GearShift_rebound();
            GearShift_setNextStep_A(STEP_UP_BRAKE);
            GearShift_setMsTicks_A(gearShift_timings[STEP_UP_REBOUND]);
            break;
        case STEP_UP_BRAKE:
            GearShift_brake();
            GearShift_setNextStep_A(STEP_UP_END);
            GearShift_setMsTicks_A(gearShift_timings[STEP_UP_BRAKE]);
            break;
        case STEP_UP_END:
            GearShift_free();
            gearShift_isShiftingUp = FALSE;
            gearShift_isSettingNeutral = FALSE;
            gearShift_isUnsettingNeutral = FALSE;
            Can_writeInt(GCU_CLUTCH_ID, 33);//Debug
            break;
            //////////////////////////////////////////////////////////
        case STEP_DOWN_START:
            if (gearShift_isSettingNeutral) {
                Clutch_set(80);
            } else {
                if (!gearShift_isUnsettingNeutral) {
                    Clutch_set(60);
                }
                Efi_setBlip();
                Buzzer_Bip();
            }
            GearShift_setNextStep_A(STEP_DOWN_PUSH);
            GearShift_setMsTicks_A(gearShift_timings[STEP_DOWN_START]);
            break;
        case STEP_DOWN_PUSH:
            if (!gearShift_isSettingNeutral) {
                Efi_unsetBlip();
            }
            GearShift_downPush();
            GearShift_setNextStep_A(STEP_DOWN_REBOUND);
            GearShift_setMsTicks_A(gearShift_timings[STEP_DOWN_PUSH]);
            break;
        case STEP_DOWN_REBOUND:
            GearShift_rebound();
            GearShift_setNextStep_A(STEP_DOWN_BRAKE);
            GearShift_setMsTicks_A(gearShift_timings[STEP_DOWN_REBOUND]);
            break;
        case STEP_DOWN_BRAKE:
            Clutch_release();
            GearShift_brake();
            GearShift_setNextStep_A(STEP_DOWN_END);
            GearShift_setMsTicks_A(gearShift_timings[STEP_DOWN_BRAKE]);
            break;
        case STEP_DOWN_END:
            GearShift_free();
            gearShift_isShiftingDown = FALSE;
            gearShift_isSettingNeutral = FALSE;
            gearShift_isUnsettingNeutral = FALSE;
            Can_writeInt(GCU_CLUTCH_ID, 22);//Debug
            break;
        default:
            break;
    }
}
//*/

void GearShift_nextStep_A(void) {
    switch (gearShift_nextStepValue_A) {
        case STEP_UP_START:
            if (gearShift_isSettingNeutral) {
                Clutch_set(80);
            } else {
                Efi_setCut();
                Buzzer_Bip();
            }
            GearShift_setNextStep_A(STEP_UP_PUSH);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_START));
            break;
        case STEP_UP_PUSH:
            if (!gearShift_isSettingNeutral) {
                Efi_unsetCut();
            }
            GearShift_upPush();
            GearShift_setNextStep_A(STEP_UP_REBOUND);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_PUSH));
            break;
        case STEP_UP_REBOUND:
            if (gearShift_isSettingNeutral) {
                Clutch_release();
            }
            GearShift_rebound();
            GearShift_setNextStep_A(STEP_UP_BRAKE);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_REBOUND));
            break;
        case STEP_UP_BRAKE:
            GearShift_brake();
            GearShift_setNextStep_A(STEP_UP_END);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_UP_BRAKE));
            break;
        case STEP_UP_END:
            GearShift_free();
            gearShift_isShiftingUp = FALSE;
            gearShift_isSettingNeutral = FALSE;
            gearShift_isUnsettingNeutral = FALSE;
            Can_writeInt(GCU_CLUTCH_ID, 33);//Debug
            break;
            //////////////////////////////////////////////////////////
        case STEP_DOWN_START:
            if (gearShift_isSettingNeutral) {
                Clutch_set(80);
            } else {
                if (!gearShift_isUnsettingNeutral) {
                    Clutch_set(60);
                }
                Efi_setBlip();
                Buzzer_Bip();
            }
            GearShift_setNextStep_A(STEP_DOWN_PUSH);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_START));
            break;
        case STEP_DOWN_PUSH:
            if (!gearShift_isSettingNeutral) {
                Efi_unsetBlip();
            }
            GearShift_downPush();
            GearShift_setNextStep_A(STEP_DOWN_REBOUND);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_PUSH));
            break;
        case STEP_DOWN_REBOUND:
            GearShift_rebound();
            GearShift_setNextStep_A(STEP_DOWN_BRAKE);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_REBOUND));
            break;
        case STEP_DOWN_BRAKE:
            Clutch_release();
            GearShift_brake();
            GearShift_setNextStep_A(STEP_DOWN_END);
            GearShift_setMsTicks_A(Gearshift_get_time(STEP_DOWN_BRAKE));
            break;
        case STEP_DOWN_END:
            GearShift_free();
            gearShift_isShiftingDown = FALSE;
            gearShift_isSettingNeutral = FALSE;
            gearShift_isUnsettingNeutral = FALSE;
            Can_writeInt(GCU_CLUTCH_ID, 22);//Debug
            break;
        default:
            break;
    }
}


void GearShift_nextStep_B(void) {
    switch (gearShift_nextStepValue_B) {
        default:
            break;
    }
}

void GearShift_setMsTicks_A(unsigned int ticks) {
    gearShift_ticksCounter1 = (int) ticks + 1;
}

void GearShift_setMsTicks_B(unsigned int ticks) {
    gearShift_ticksCounter2 = (int) ticks + 1;
}

void GearShift_msTick(void) {
    gearShift_ticksCounter1 -= 1;
    if (gearShift_ticksCounter1 == 0) {
        GearShift_nextStep_A();
    } else if (gearShift_ticksCounter1 < 0) {
        gearShift_ticksCounter1 = 0;
    }

    gearShift_ticksCounter2 -= 1;
    if (gearShift_ticksCounter2 == 0) {
        GearShift_nextStep_B();
    } else if (gearShift_ticksCounter2 < 0) {
        gearShift_ticksCounter2 = 0;
    }
}

/*
void GearShift_loadDefaultTimings(void){
     //TODO: read from EEPROM
     gearShift_timings[STEP_UP_PUSH_DELAY] = TIME_UP_PUSH_DELAY;
    switch (gearShift_currentGear) {
        case 1:
            gearShift_timings[STEP_UP_PUSH] = TIME_UP_PUSH_1TO2;
            break;
        case 2:
            gearShift_timings[STEP_UP_PUSH] = TIME_UP_PUSH_2TO3;
            break;
        case 3:
            gearShift_timings[STEP_UP_PUSH] = TIME_UP_PUSH_3TO4;
            break;
        case 4:
            gearShift_timings[STEP_UP_PUSH] = TIME_UP_PUSH_4TO5;
            break;
        default:
            gearShift_timings[STEP_UP_PUSH] = TIME_UP_PUSH_2TO3;
            break;
    }
    gearShift_timings[STEP_UP_REBOUND] = TIME_UP_REBOUND;
    gearShift_timings[STEP_UP_BRAKE] = TIME_UP_BRAKE;
    gearShift_timings[STEP_DOWN_CLUTCH] = TIME_DOWN_CLUTCH;
    gearShift_timings[STEP_DOWN_PUSH] = TIME_DOWN_PUSH;
    gearShift_timings[STEP_DOWN_REBOUND] = TIME_DOWN_REBOUND;
    gearShift_timings[STEP_DOWN_BRAKE] = TIME_DOWN_BRAKE;
}
//*/

int Gearshift_get_time(shiftStep step)
{
     if(gearShift_isSettingNeutral == TRUE){
         switch(step){
              case STEP_UP_START:
                      return gearShift_timings[NT_CLUTCH_DELAY];
              case STEP_UP_PUSH:
                      return gearShift_timings[NT_PUSH_1_N];
              case STEP_UP_REBOUND:
                      return gearShift_timings[NT_REBOUND_1_N];
              case STEP_UP_BRAKE:
                      return gearShift_timings[NT_BRAKE_1_N];
//              case STEP_DOWN_CLUTCH:
//                      return gearShift_timings[UP_PUSH_1_2]; = TIME_NEUTRAL_DOWN_CLUTCH;
              case STEP_DOWN_PUSH:
                      return gearShift_timings[NT_PUSH_2_N];
              case STEP_DOWN_REBOUND:
                      return gearShift_timings[NT_REBOUND_2_N];
              case STEP_DOWN_BRAKE:
                      return gearShift_timings[NT_BRAKE_2_N];
         }
     }
     switch(step){
         case STEP_UP_START:
              return gearShift_timings[DELAY];
              break;
         //STEP_UP_PUSH_DELAY:
         case STEP_UP_PUSH:
              switch(gearShift_currentGear){
                  case 1:
                      return gearShift_timings[UP_PUSH_1_2];
                  case 2:
                      return gearShift_timings[UP_PUSH_2_3];
                  case 3:
                      return gearShift_timings[UP_PUSH_3_4];
                  case 4:
                      return gearShift_timings[UP_PUSH_4_5];
                  default:
                      return gearShift_timings[UP_PUSH_2_3];
              }
         case STEP_UP_REBOUND:
              return gearShift_timings[UP_REBOUND];
         case STEP_UP_BRAKE:
              return gearShift_timings[UP_BRAKE];
         case STEP_DOWN_START:
              return gearShift_timings[CLUTCH];
         //STEP_DOWN_CLUTCH,
         case STEP_DOWN_PUSH:
              return gearShift_timings[DN_PUSH];
         case STEP_DOWN_REBOUND:
              return gearShift_timings[DN_REBOUND];
         case STEP_DOWN_BRAKE:
              return gearShift_timings[DN_BRAKE];
     }
}

void GearShift_loadDefaultTimings(void) {}

/*
void GearShift_loadNeutralTimings(void) {
    gearShift_timings[STEP_UP_PUSH_DELAY] = TIME_NEUTRAL_UP_CLUTCH;
    gearShift_timings[STEP_UP_PUSH] = TIME_NEUTRAL_UP_PUSH;
    gearShift_timings[STEP_UP_REBOUND] = TIME_NEUTRAL_UP_REBOUND;
    gearShift_timings[STEP_UP_BRAKE] = TIME_NEUTRAL_UP_BRAKE;
    gearShift_timings[STEP_DOWN_CLUTCH] = TIME_NEUTRAL_DOWN_CLUTCH;
    gearShift_timings[STEP_DOWN_PUSH] = TIME_NEUTRAL_DOWN_PUSH;
    gearShift_timings[STEP_DOWN_REBOUND] = TIME_NEUTRAL_DOWN_REBOUND;
    gearShift_timings[STEP_DOWN_BRAKE] = TIME_NEUTRAL_DOWN_BRAKE;
}
//*/
/*
void GearShift_loadDefaultTimings(void) {
    gearShift_timings[STEP_UP_PUSH_DELAY] = gearShift_timings[ID_TIME_UP_PUSH_DELAY];
    gearShift_timings[STEP_UP_PUSH] = gearShift_timings[ID_TIME_UP_PUSH];
    gearShift_timings[STEP_UP_REBOUND] = gearShift_timings[ID_TIME_UP_REBOUND];
    gearShift_timings[STEP_UP_BRAKE] = gearShift_timings[ID_TIME_UP_BRAKE];
    gearShift_timings[STEP_DOWN_CLUTCH] = gearShift_timings[ID_TIME_DOWN_CLUTCH];
    gearShift_timings[STEP_DOWN_PUSH] = gearShift_timings[ID_TIME_DOWN_PUSH];
    gearShift_timings[STEP_DOWN_REBOUND] = gearShift_timings[ID_TIME_DOWN_REBOUND];
    gearShift_timings[STEP_DOWN_BRAKE] = gearShift_timings[ID_TIME_DOWN_BRAKE];
}

void GearShift_loadNeutralTimings(void) {
    gearShift_timings[STEP_UP_PUSH_DELAY] = gearShift_timings[ID_TIME_NEUTRAL_UP_CLUTCH];
    gearShift_timings[STEP_UP_PUSH] = gearShift_timings[ID_TIME_NEUTRAL_UP_PUSH];
    gearShift_timings[STEP_UP_REBOUND] = gearShift_timings[ID_TIME_NEUTRAL_UP_REBOUND];
    gearShift_timings[STEP_UP_BRAKE] = gearShift_timings[ID_TIME_NEUTRAL_UP_BRAKE];
    gearShift_timings[STEP_DOWN_CLUTCH] = gearShift_timings[ID_TIME_NEUTRAL_DOWN_CLUTCH];
    gearShift_timings[STEP_DOWN_PUSH] = gearShift_timings[ID_TIME_NEUTRAL_DOWN_PUSH];
    gearShift_timings[STEP_DOWN_REBOUND] = gearShift_timings[ID_TIME_NEUTRAL_DOWN_REBOUND];
    gearShift_timings[STEP_DOWN_BRAKE] = gearShift_timings[ID_TIME_NEUTRAL_DOWN_BRAKE];
}
 */