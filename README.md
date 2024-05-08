# Kernel Image Format But More Betterer (KIFBMB)

Kernel Image Format But More Betterer (KIFBMB) is a simple format designed for encoding small icons and logos, typically useful for boot screens, system icons, and other similar contexts within OS development.

## Format Specification

The KIFBMB format follows a straightforward structure:

1. **Header**:
```C
typedef struct {
    uint32_t magic;         // just a magic number 
    uint32_t width,height ; // dimensions of the image
    uint8_t  checksum;      // basic checksum: all bytes in this file must add up to 0

} kifbmb_header;
```
the magic number is `0x69420666`
1. **Pixel Data**: Following the header, the pixel data consists of 32-bit RGBA values for each pixel.

### Format Overview
The Kernel Image Format But More Betterer (KIFBMB) is just a simple-ass binary image format.
The file format consists of a header section followed by pixel data.

### Header
The header contains two 32-bit integers representing the image width and height, respectively.

### Pixel Data
Each uint32_t after the header contains RGBA values for a single pixel. That is fucking it.

## License
KernelImageFormat is distributed under the GNU General Public License v3.0 (GPLv3). See the `LICENSE` file for more details.
