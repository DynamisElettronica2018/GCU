//
// Created by Aaron Russo on 01/08/16.
//

#ifndef FIRMWARE_EFI_H
#define FIRMWARE_EFI_H

#include "dspic.h"

#define UPCUT_Pin RD3_bit
#define DOWNCUT_Pin RD2_bit
#define RPM_LIMITER_Pin RD4_bit

#define UPCUT_Direction TRISD3_bit
#define DOWNCUT_Direction TRISD2_bit
#define RPM_LIMITER_Direction TRISD4_bit

#define SET_CUT 0
#define UNSET_CUT 1
#define SET_RPM_LIMITER 0
#define UNSET_RPM_LIMITER 1

void Efi_init(void);

void Efi_setCut(void);

void Efi_unsetCut(void);

void Efi_setBlip(void);

void Efi_unsetBlip(void);

void Efi_setRPMLimiter(void);

void Efi_unsetRPMLimiter(void);

#endif //FIRMWARE_EFI_H