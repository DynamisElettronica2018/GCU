//
// Created by Aaron Russo on 01/03/16.
//

#include <stdio.h>
#include "basic.h"

void unsignedIntToString(unsigned int number, char *text) {
    emptyString(text);
    sprintf(text, "%u", number);
}

void signedIntToString(int number, char *text) {
    emptyString(text);
    sprintf(text, "%d", number);
}

void emptyString(char *myString) {
    myString[0] = '\0';
    /*for (i = 0; i < sizeof(myString); i += 1) {
        myString[i] = '\0';
    }*/
}

unsigned char getNumberDigitCount(unsigned char number) {
    if (number >= 100) {
        return 3;
    } else if (number >= 10) {
        return 2;
    } else {
        return 1;
    }
}
