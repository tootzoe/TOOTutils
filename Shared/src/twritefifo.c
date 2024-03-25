//
//  twritefifo.c
//  TOOTutils
//
//  Created by thor on 12/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



#include <sys/types.h>
 #include <sys/stat.h>
#include <sys/select.h>
#include <errno.h>
#include <memory.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "tfifo.h"


int testWriteFifo(const char * pathname)
{
    int fd;
     
   
    char buf[1024];
    
    int i = 0;
    
    const char *fifofn = pathname ;// "myfifo";
    
    
    fd = open(fifofn,  O_WRONLY  | O_NONBLOCK);
 
    
    if (fd == -1) {
        perror("open");
        return EXIT_FAILURE;
    }

    
    printf("Begin write....\n"   );
    for (i = 0 ; i < 6 ; i++) {
        size_t wsz;
        
        if (access(fifofn, W_OK) == 0){
           // printf("writable....\n"   );
            if(fd == -1){
                fd = open(fifofn,  O_WRONLY  | O_NONBLOCK);
                if (fd == -1) {
                    perror("open");
                    return EXIT_FAILURE;
                }
            }
            
        }else{
            printf("Not writable wait 1 second and retry....i = %d\n" , i   );
            fd = -1;
            sleep(1);
            if(i > 0) i --;
            continue;
        }
        
        memset( buf , i + 1 , sizeof(buf));
        if( i % 2 == 0){
            wsz  = sizeof(buf) / 2;
            if( wsz != write(fd , buf ,  wsz) ){
                perror("wirte err1");
                break;
            }
               
        }  else{
            wsz  = sizeof(buf)  ;
            if( wsz != write(fd , buf ,  wsz )){
                printf("written: %zul\n" ,wsz);
                if( errno == EAGAIN || errno == EWOULDBLOCK ){
                    printf("need write again.....\n");
                }else{
                    perror("wirte err2");
                    break;
                }
               
            }
        }
        
        
      //  sleep(2);
        
    }
    
    printf("i = %d\n"  , i);
 
    return  0;
}

















