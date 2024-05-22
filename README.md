# Kernel Image Format But More Betterer (KIFBMB)

Kernel Image Format But More Betterer (KIFBMB) is a simple raw image format made for fun.
It is an extension of [Kevin Alavik's KIF](https://kevinalavik.github.io/kif.html)

## Format Specification

The `KIFBMB` format follows a straightforward structure:

1. **Header**:
```C
typedef struct {
    uint32_t magic;         // just a magic number 
    uint32_t width,height ; // dimensions of the image
    uint8_t  checksum;      // basic checksum: all bytes in this file must add up to 0

} kifbmb_header;
```
the magic number is `0x69420666`
**note: all fields are in little endian**
1. **Pixel Data**: Following the header, the pixel data consists of 32-bit RGBA values for each pixel.

### Header
The header contains two `uint32_t`s representing the image width and height, respectively.

### Pixel Data
Each `uint32_t` after the header contains `RGBA` values for a single pixel. That's it.

## License
`KIFBMB` is distributed under the `GNU General Public License v3.0 (GPLv3)`. See the `LICENSE` file for more details.
