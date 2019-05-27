//
//  PTEncode.h
//  WirelessPrinter
//
//  Created by midmirror on 16/7/27.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTEncode : NSObject

/** 编码 */
/** encoding */
+ (NSData *)encodeDataWithString:(NSString *)string;
/** 解码 */
/** decoding */
+ (NSString *)decodeStringWithData:(NSData *)data;

/** 支持多种编码 */
/** support various encoding */
+ (NSData *)encodeDataWithString:(NSString *)string encodingType:(CFStringEncodings)encodeType;
/** 支持多种解码 */
/** support various decoding */
+ (NSString *)decodeDataWithString:(NSData *)data encodingType:(CFStringEncodings)encodeType;

@end
