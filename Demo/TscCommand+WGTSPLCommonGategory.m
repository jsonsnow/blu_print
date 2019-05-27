//
//  TscCommand+WGTSPLCommonGategory.m
//  Demo
//
//  Created by chen liang on 2019/4/29.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand+WGTSPLCommonGategory.h"

@implementation TscCommand (WGTSPLCommonGategory)

- (void)addHome {
    NSString *homeStr = @"HOME\r\n";
    [self addStrToCommand:homeStr];
}

//空格是一个字母的宽度，数子也是字母的宽度，宽度为12个点
- (NSInteger)calculateStrWidth:(NSString *)phrase font:(NSString *)font xScale:(int)xScale yScale:(int)yScale {
    NSInteger width = 0;
    for (int i = 0; i < phrase.length; i++) {
        NSInteger characterWidth = 24;
        if ([font isEqualToString:@"TSS16.BF2"]) {
            characterWidth = 16;
        }
        characterWidth = characterWidth * xScale;
        int subStr = [phrase characterAtIndex:i];
        if (0x4E00 > subStr  || subStr > 0x9FA5) {
            characterWidth = characterWidth / 2;
        }
        width = width + characterWidth;
    }
    return  width;
}

- (NSInteger)calculateStrMaxHeight:(NSString *)phrase font:(NSString *)font xScale:(int)xScale yScale:(int)yScale {
    NSInteger height = 0;
    for (int i = 0; i < phrase.length; i++) {
        NSInteger characterWidth = 24;
        if ([font isEqualToString:@"TSS16.BF2"]) {
            characterWidth = 16;
        }
        characterWidth = characterWidth * xScale;
        int subStr = [phrase characterAtIndex:i];
        if (0x4E00 > subStr  || subStr > 0x9FA5) {
            characterWidth = characterWidth / 2;
        }
        if (characterWidth >= height) {
            height = characterWidth;
        }
    }
    return  height;
}

- (void)drawTextwithX:(int)x withY:(int)y withWidth:(int)width withFont:(NSString *)font withRotation:(int)rotation withXscal:(int)xScal withYscal:(int)yScal direction:(NSString *)direction withText:(NSString *)text {
    int itemX = (int)[self calculateStrMaxHeight:text font:font xScale:xScal yScale:yScal];
    //垂直绘制逻辑
    if ([direction isEqualToString:@"v"]) {
        for (int i = 0; i <  text.length; i++) {
            NSString *drawStr = [text substringWithRange:NSMakeRange(i, 1)];
            int temp_y = (itemX + 4) * i;
            [self addTextwithX:x withY:y + temp_y withFont:font withRotation:rotation withXscal:xScal withYscal:yScal withText:drawStr];
        }
        
    } else {
        NSInteger count = text.length;
        int lineCount = width / itemX;
        NSInteger line = count/lineCount + 1;
        for (int i = 0; i < line; i++) {
            NSString *subStr = nil;
            if (i != line - 1) {
                subStr = [text substringWithRange:NSMakeRange(lineCount * i, lineCount)];
            } else {
                subStr = [text substringWithRange:NSMakeRange(lineCount * i, count - lineCount * i)];
            }
            int temp_y = (itemX + 4) * i;
            [self addTextwithX:x withY:y + temp_y  withFont:font withRotation:0 withXscal:xScal withYscal:yScal withText:subStr];
        }
    }
}
@end
