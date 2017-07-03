//
// Created by Aaron Russo on 26/01/16.
//

#ifndef DP8_DISPLAY_CONTROLLER_BASIC_H
#define DP8_DISPLAY_CONTROLLER_BASIC_H

#define TRUE 1
#define FALSE 0
#define SUPERPOSITION 2
#define LEFT 0
#define RIGHT 1



void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);

#endif //DP8_DISPLAY_CONTROLLER_BASIC_H