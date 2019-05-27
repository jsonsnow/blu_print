//
//  HexData.m
//  Manufacture
//
//  Created by mellow on 2016/12/19.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import "HexData.h"

@implementation HexData

+ (NSData *)dataWithHexString:(NSString *)hexString
{
    NSString *pureHexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    pureHexString = [pureHexString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    Byte bytes[pureHexString.length/2];
    for(int i=0; i<pureHexString.length/2; i++)
    {
        int left  = [self intWithUnsignedChar:[pureHexString characterAtIndex:2*i]];
        int right = [self intWithUnsignedChar:[pureHexString characterAtIndex:2*i+1]];
        
        bytes[i] = left*16+right;  ///将转化后的数放入Byte数组里 //左边的数字乘16或者乘0x10
    }
    
    return [[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
}

+ (NSString *)hexStringWithData:(NSData *)data {
    
    NSString *hexString = [[[[NSString stringWithFormat:@"%@",data]
                             stringByReplacingOccurrencesOfString: @"<" withString: @""]
                            stringByReplacingOccurrencesOfString: @">" withString: @""]
                           stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    return hexString.uppercaseString;
}

+ (int)intWithUnsignedChar:(unichar)charValue
{
    int     intValue;
    
    if      (charValue >= '0' && charValue <= '9')   intValue = charValue-48; //// 0 的Ascll - 48
    else if (charValue >= 'A' && charValue <= 'F')   intValue = charValue-55; //// A 的Ascll - 65
    else if (charValue >= 'a' && charValue <= 'f')   intValue = charValue-87; //// a 的Ascll - 97
    else    intValue = charValue-87;
    
    return intValue;
}

+ (NSData *)dataWithURL:(NSURL *)url fileName:(NSString *)fileName {
    
    NSData *templateData;
    if ([[fileName componentsSeparatedByString:@"."].lastObject isEqualToString:@"hex"]) {
        // hex string 数据转为NSData直接发送
        NSString *hexString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        templateData = [HexData dataWithHexString:hexString];
    } else {
        // 字符串模板使用GB18030编码后发送
        NSString *template = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        templateData = [template dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    }
    return templateData;
}

@end
