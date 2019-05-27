//
//  PTBitmap+GrayLevel.h
//  PrinterSDK
//
//  Created by ldc on 2017/12/8.
//  Copyright © 2017年 Mellow. All rights reserved.
//

#import "PTBitmap.h"
#import <UIKit/UIKit.h>

@interface PTBitmap (GrayLevel)

/**
 Get grayscale data of image , gray = red*0.29891 + green*0.58661 + blue*0.11448
 获取图像的灰度数据, gray = red*0.29891 + green*0.58661 + blue*0.11448
 
 @param image 图片 image
 @return 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 */
+ (NSData *)graylevel256Datas:(UIImage *)image;

/**
 Get grayscale data of image , gray = red*0.29891 + green*0.58661 + blue*0.11448
 获取图像的灰度数据, gray = red*0.29891 + green*0.58661 + blue*0.11448
 
 @param image 图片 image
 @param needReverse 是否反转灰度值 0->255 254->1
 @return 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 */
+ (NSData *)graylevel256Datas:(UIImage *)image reverse:(BOOL)needReverse;

/**
 Get image from grayscale photo
 从灰度图片数据获取图像
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @return 图片 image
 */
+ (UIImage *)imageWithGraylevel256Data:(NSData *)data width:(NSUInteger)width;

/**
 grayscale data sharpen
 灰度数据锐化
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @return 经过锐化的256阶灰度数据 sharpening 256-level grayscale data
 */
+ (NSData *)sharpenGraylevel256Data:(NSData *)data width:(NSUInteger)width;

/**
 Get the data with thermal compensation processing
 获取经过热补偿处理的数据
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @return 处理结果数据 data of processing result
 */
+ (NSData *)historyCompensateGraylevel256Data:(NSData *)data width:(NSUInteger)width;

/**
 return to the data of black and white image
 返回黑白图像数据
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值 grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @return 黑白图像数据，每个字节代表一个像素，每个字节的值为0或255，0黑色 255白色/data of black and white image, each byte indicates one pixel, the value of each byte is 0 or 255, 0 is black, 255 is white
 */
+ (NSData *)binaryDataOneBytePerPixelGraylevel256Data:(NSData *)data width:(NSUInteger)width;

/**
 grayscale data obtained by importing image into the device grayscale space
 将图片导入设备灰度空间获取的灰度数据
 
 @param image 图片
 @return 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 */
+ (NSData *)systemGraylevel256Datas:(UIImage *)image;

@end

//打印机相关图像处理算法
@interface PTBitmap(Printer)

/**
 Get the data of black and white image by average grayscale
 根据平均灰度值获取黑白处理的数据
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @return 处理后的数据，每一位代表一个像素，如果宽度不是8的倍数，会在右边缘加上空白点 1黑色 0白色/processed data, each indicates one pixel, if width is not the multiple of 8, it will add blank at the right edge, 1 is black, 0 is white
 */
+ (NSData *)binaryDataOneBitPerPixelGraylevel256Data:(NSData *)data width:(NSUInteger)width;

/**
 Get the data of black and white image
 获取黑白处理的数据

 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @param valve 阀值，根据这个值决定灰度值是黑色或白色,如果灰度值小于阀值，则被认为是黑色，否则白色/valve,determine that a grayscale pixel is black or white. if a grayscale is less than valve, the pixel is considered black,otherwise white.
 @return 处理后的数据，每一位代表一个像素，如果宽度不是8的倍数，会在右边缘加上空白点 1黑色 0白色/processed data, each indicates one pixel, if width is not the multiple of 8, it will add blank at the right edge, 1 is black, 0 is white
 */
+ (NSData *)binaryDataOneBitPerPixelGraylevel256Data:(NSData *)data width:(NSUInteger)width valve:(NSUInteger)valve;

/**
 Get the dithering image data
 获取抖动的图像数据
 
 @param data 灰度数据，每个字节代表每个像素的256阶灰度值/grayscale data, each byte indicates 256-level grayscale value of each pixel
 @param width 图片宽度 image width
 @return 抖动处理后的数据，每一位代表一个像素，如果宽度不是8的倍数，会在右边缘加上处理的像素点 1黑色 0白色/processed dithering data, each indicates one pixel, if width is not the multiple of 8, it will add blank at the right edge, 1 is black, 0 is white
 */
+ (NSData *)ditheredBinaryDataOneBitPerPixelGraylevel256Data:(NSData *)data width:(NSUInteger)width;

+ (NSData *)meiKaLePrinterData:(NSData *)graylevel256Data;

@end
