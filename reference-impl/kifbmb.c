#include "kifbmb.h"

kifbmb_return kifbmb_parse(void* data,uint32_t size){
    kifbmb_header* header = (kifbmb_header*)data;
    
    //validate the magic number
    if(header->magic != KIFMBM_MAGIC_VAL){
        return (kifmbm_return){false,0,0,0};
    }

    //validate the checksum
    uint8_t checksum = 0;
    for(int i = 0; i < size; i++){
        checksum += ((uint8_t*)data)[i];
    }
    if(checksum != 0){
        return (kifmbm_return){false,0,0,0};
    }
    
    return (kifmbm_return){true,header->width,header->height,(uint32_t*)(data + sizeof(kifbmb_header))};
}