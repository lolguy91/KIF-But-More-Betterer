#ifndef __KIFMBM_H__
#define __KIFMBM_H__
#include <stdint.h>
#define KIFMBM_MAGIC_VAL 0x69420666

typedef struct _kifmbm_header {
    uint32_t magic;         // just a magic number
    uint32_t width,height ; // dimensions of the image
    uint8_t  checksum;      // basic checksum: all bytes in this file must add up to 0
} kifmbm_header;

typedef struct _kifmbm_return {
    bool success;
    uint32_t width,height;
    uint32_t*     data;
} kifmbm_return;

kifmbm_return kifbmb_parse(void* data, uint32_t size);

#endif // __KIFMBM_H__