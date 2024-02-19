# Kernel Image Format (KIF)

Kernel Image Format (KIF) is a simple format designed for encoding small icons and logos, typically used in boot screens, system icons, and other similar contexts within kernel development. This format is based on simple ASCII text, making it easy to integrate into kernel codebases.

For further explanation and details, visit [KIF Documentation](https://kevinalavik.github.io/kif.html).

## Format Specification

The KIF format follows a straightforward structure:

1. **Header**: The first part of the image data contains the width and height of the image separated by a space, followed by a newline character.
2. **Pixel Data**: Following the header, the pixel data consists of RGB values for each pixel, represented as integers separated by spaces. Each row of pixels ends with a newline character.

## Alpha Support

We are currently working on adding alpha support to the KIF format to enable transparency in images. Stay tuned for updates on this feature!

## Usage

To use the KIF format in your project, simply include the `kif.h` header file and implement the `draw_image` function according to your system's requirements. Please note that you'll need to provide your own `putpixel` function to draw pixels on your display device. Be sure to update line 43 in the `draw_image` function to call your custom pixel-drawing function.

## Format Overview
The Kernel Image Format (KIF) uses a simple ASCII text format without relying on magic numbers or complex specifications.

### Header
The file format consists of a header section followed by pixel data. The header contains two integers separated by a space representing the image width and height, respectively.

### Pixel Data
Each line after the header contains RGB values for a single pixel. RGB values are represented as integers in the range 0-255. Each line contains three space-separated integers representing the red, green, and blue values of a pixel.

#### Example
Consider the following example of a 3x3 image:
```
3 3
255 0 0       
0 255 0
0 0 255
255 255 0
255 0 255
0 255 255
128 128 128
0 0 0
255 255 255
```
    
This represents a 3x3 image where each row represents the RGB values of pixels in the image

## License

KernelImageFormat is distributed under the GNU General Public License v3.0 (GPLv3). See the `LICENSE` file for more details.
