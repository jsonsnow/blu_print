//
//  Bitmap.h
//  IOPhoneTest
//
//  Created by sdtpig on 8/25/09.
//  Copyright 2009 starmicronics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define RGBA 4
#define RGBA_8_BIT 8

typedef struct {
    unsigned char R, G, B, A;
} RGBAPixel;

@interface PTBitmapSTAR : NSObject {
	CGImageRef m_image;
	NSData *imageData;
	bool ditheringSupported;
}

- (id)initWithCGImage:(CGImageRef)image :(int)maxWidth :(bool)dithering;
- (void)dealloc;
- (NSData *)getImageDataForPrinting:(BOOL)compressionEnable;
- (NSData *)getGraphicsDataForPrinting:(BOOL)compressionEnable;
- (NSData *)getImageMiniDataForPrinting:(BOOL)compressionEnable pageModeEnable:(BOOL)pageModeEnable;
- (NSData *)getImageImpactPrinterForPrinting;


void ManipulateImagePixelData(CGImageRef inImage, void * imageData);
void ConvertToMonochromeSteinbertDithering(RGBAPixel * image, int32_t width, int32_t height, float intensity);
u_int32_t PixelIndex(u_int32_t x, u_int32_t y, u_int32_t width);
u_int8_t PixelBrightness(u_int8_t red, u_int8_t green, u_int8_t blue);

@end
