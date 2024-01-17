#ifndef KIF_H_
#define KIF_H_

#include <limine.h>
#include <stdint.h>
#include <display/vga.h> // Change this to your VGA handler, to draw pixels

void draw_image(struct limine_file* image);

#endif // KIF_H_
