//
//  tfifo.c
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
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "tfifo.h"



int createFifoFile(const char* pathname)
{
    int fd;
    int n;
    fd_set set;
    ssize_t bytes;
    size_t total_bytes;
    char buf[1024];
    int doBreak = 0;
    
    const char *fifofn = pathname ;// "myfifo";
    
    mkfifo(fifofn, 0666  /* O_RDWR  | O_NONBLOCK*/);
     
    fd = open(fifofn,  O_RDWR  | O_NONBLOCK);
 
    
    if (fd == -1) {
        perror("open");
        return EXIT_FAILURE;
    }

    FD_ZERO(&set);
    FD_SET(fd, &set);

    printf(" c code, Create %s ok....ready for writing....\n" , fifofn);
    
    for (;;) {
        n = select(fd+1, &set, NULL, NULL, NULL);
        if (!n)
            continue;
        
        if (n == -1) {
            perror("select");
            return EXIT_FAILURE;
        }
        
        if (FD_ISSET(fd, &set)) {
            printf("Descriptor %d is ready.\n", fd);
            total_bytes = 0;
            for (;;) {
                bytes = read(fd, buf, sizeof(buf));
               // printf("r b : %ld\n" , bytes);
                if(bytes == 0){
                    continue;
                }else   if (bytes > 0) {
                    total_bytes += (size_t)bytes;
                     fifoWavByteArrArrived((const uint8_t*)buf, (int32_t)bytes);
                   // toottestfun(bytes);
                    //////////test
//                    if(bytes == 2) {
//                        doBreak = 1;
//                        break;}
                    ///////// end test
                } else {
                    if (errno == EWOULDBLOCK || errno == EAGAIN ) {
                        /* Done reading */
                        printf("done reading (%lu bytes)\n", total_bytes);
                        break;
                    } else  {
                      perror("read ");
                        unlink(fifofn) ; // delete fifo file
                        return EXIT_FAILURE;
                    }
                }
            }
        }
        
        if(doBreak > 0) break;
    }
    
    unlink(fifofn) ; // delete fifo file
    close(fd);
    
    printf("Fifo exited and unlink fifo....\n");

    return EXIT_SUCCESS;
}
