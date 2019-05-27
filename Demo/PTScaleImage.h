//
//  PTScaleImage.h
//  WirelessPrinter
//
//  Created by midmirror on 16/11/15.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PTScaleImage : NSObject

+ (UIImage *)scaleSourceImage:(UIImage *)image maxWidth:(CGFloat)maxWidth;

@end
