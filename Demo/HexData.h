//
//  HexData.h
//  Manufacture
//
//  Created by mellow on 2016/12/19.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HexData : NSObject

+ (NSData *)dataWithHexString:(NSString *)hexString;
+ (NSString *)hexStringWithData:(NSData *)data;
+ (NSData *)dataWithURL:(NSURL *)url fileName:(NSString *)fileName;

@end
