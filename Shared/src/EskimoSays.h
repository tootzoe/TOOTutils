//
//  EskimoSays.h
//  TOOTutils
//
//  Created by thor on 12/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



#ifndef EskimoSays_h
#define EskimoSays_h

#include <stdio.h>





////////////////////////
/// from : https://forums.swift.org/t/best-way-to-call-a-swift-function-from-c/9829/3
///
 
struct SomeCLibCallbacks {
    void (* _Nonnull printGreeting)(const char * _Nonnull modifier);
};
typedef struct SomeCLibCallbacks SomeCLibCallbacks;

extern void SomeCLibSetup(const SomeCLibCallbacks * _Nonnull callbacks);

extern void SomeCLibTest(void);






#endif /* EskimoSays_h */
