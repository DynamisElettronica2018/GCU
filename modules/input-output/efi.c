


#include "efi.h"

void Efi_init(void) {
    DOWNCUT_Direction = OUTPUT;
    UPCUT_Direction = OUTPUT;
    RPM_LIMITER_Direction = OUTPUT;
    RPM_LIMITER_Pin = 0;
    Efi_unsetBlip();
    Efi_unsetCut();
    Efi_unsetRPMLimiter();
}

void Efi_setCut(void) {
    UPCUT_Pin = SET_CUT;
}

void Efi_unsetCut(void) {
    UPCUT_Pin = UNSET_CUT;
}

void Efi_setBlip(void) {
    DOWNCUT_Pin = SET_CUT;
}

void Efi_unsetBlip(void) {
    DOWNCUT_Pin = UNSET_CUT;
}

void Efi_setRPMLimiter(void){
    RPM_LIMITER_Pin = SET_RPM_LIMITER;
}

void Efi_unsetRPMLimiter(void){
    RPM_LIMITER_Pin = UNSET_RPM_LIMITER;
}

/*void Efi_setRPMLimiter_CAN(unsigned int limit){
    Can_resetWritePacket();
    Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
    Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_CLUTCH_ID);
}

void Efi_unsetRPMLimiter_CAN(unsigned int limit){
    Can_resetWritePacket();
    Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
    Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_CLUTCH_ID);
}*/