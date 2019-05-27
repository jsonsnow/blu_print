//
//  CGImage+Extensions.h
//  mPrinter
//
//  Created by Andy Muldowney on 7/5/13.
//  Copyright (c) 2013 mPrinter, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DitheringManager: NSObject

+ (CGImageRef)ditheringImage:(CGImageRef)srcImg;
+ (NSData *)ditheringWithFloydSteinberg:(CGImageRef)srcImg;
+ (void)dump:(CGImageRef)srcImg;

@end
