//
//  EskimoSays.c
//  TOOTutils
//
//  Created by thor on 12/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



#include "EskimoSays.h"




static SomeCLibCallbacks sCallbacks;

extern void SomeCLibSetup(const SomeCLibCallbacks * callbacks) {
    sCallbacks = *callbacks;
}

extern void SomeCLibTest(void) {
    sCallbacks.printGreeting("Cruel ......");
}


 
