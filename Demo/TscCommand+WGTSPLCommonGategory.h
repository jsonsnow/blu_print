//
//  TscCommand+WGTSPLCommonGategory.h
//  Demo
//
//  Created by chen liang on 2019/4/29.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface TscCommand (WGTSPLCommonGategory)

- (void)addHome;

///自动换行绘制命令
- (void)drawTextwithX:(int)x withY:(int)y withWidth:(int)width withFont:(NSString *)font withRotation:(int)rotation withXscal:(int)xScal withYscal:(int)yScal direction:(NSString *)direction withText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
