//
//  tfifo.h
//  TOOTutils
//
//  Created by thor on 12/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



#ifndef tfifo_h
#define tfifo_h

#include <stdio.h>




int createFifoFile(const char* pathname);
int testWriteFifo(const char * pathname);


void fifoWavByteArrArrived(const uint8_t *dat , int32_t len);

void toottestfun(uint32_t x);




#endif /* tfifo_h */
