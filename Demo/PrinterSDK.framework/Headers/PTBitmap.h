//
//  PTBitmap.H
//
//  Created by midmirror on 15/12/22.
//  Copyright © 2015年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "SDKDefine.h"

/**
 *  简单处理32位像素的宏。为了得到红色通道的值，需要先得到前8位。为了得到其它的颜色通道值，需要进行位移截取。
 *  Simply process the macro of 32-bit pixel. To get the value of red channel, get former 8 bits at first. To get the value of other channels, make the interception for motion.
 *
 */
#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )

/**
 *  Photo compression algorithm supported by MPT-8: ZPL2 compression algorithm, TIFF compression algorithm, other models please choose NULL.
 *  MPT-8 支持的图片压缩算法:ZPL2压缩算法，TIFF 压缩算法,其他机型选择 NUll
 */
typedef NS_ENUM(NSInteger,PTBitmapCompressMode) {
    
    PTBitmapCompressModeNone = 0,
    PTBitmapCompressModeZPL2 = 16,
    PTBitmapCompressModeTIFF = 32,
    PTBitmapCompressModeLZO = 48
};

typedef NS_ENUM(NSInteger, PTBitmapMode) {
    //转为黑白二值图像，适用于黑白图片
    PTBitmapModeBinary = 0,
    PTBitmapModeDithering = 1,
    PTBitmapModeColumn = 2
};

/**
 *  Bitmap processing: generate black and white image or visual grayscale image after dithering
 *  位图处理：生成黑白二值图片或者抖动后的视觉灰度图片
 */
@interface PTBitmap : NSObject

/**
 Data negation processing
 数据取反处理 eg：TSPL的位图处理需要取反

 @param data 输入数据 input data
 @return 取反输出数据 data negation
 */
+ (NSData *)negativeData:(NSData *)data;

/**
 Generate data of printing image for the printer
 生成打印机打印图片数据

 @param image 图片/image
 @param mode 生成的位图数据类型 简单的黑白二值化或者抖动处理/type of generated bitmap data; simple black and white image or dithering
 @param compress 数据压缩类型/type of data compression
 @return 提供给打印机使用的图片数据/image data provided to the printer
 */
+ (NSData *)getImageData:(CGImageRef)image mode:(PTBitmapMode)mode compress:(PTBitmapCompressMode)compress;

+ (NSData *)generateColumnData:(CGImageRef)sourceBitmap;

@end
