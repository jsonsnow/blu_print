//
//  PTScaleImage.m
//  WirelessPrinter
//
//  Created by midmirror on 16/11/15.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import "PTScaleImage.h"

@implementation PTScaleImage

+ (UIImage *)scaleSourceImage:(UIImage *)image maxWidth:(CGFloat)maxWidth
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat maxHeight;
    if (width > maxWidth)
    {
        maxHeight = (height * maxWidth)/width;
        return [self scaleSourceImage:image width:maxWidth height:maxHeight];
    }
    else
    {
        return image;
    }
}

+ (UIImage *)scaleSourceImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
