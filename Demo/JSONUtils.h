//
//  JSONUtils.h
//  WeAblum
//
//  Created by 张忠燕 on 2019/1/23.
//  Copyright © 2019 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONUtils : NSObject

+ (nullable NSMutableArray *)arrayWithData:(nullable NSData *)data;

+ (nullable NSMutableArray *)arrayWithString:(nullable NSString *)string;

+ (nullable NSMutableDictionary *)dictWithData:(nullable NSData *)data;

+ (nullable NSMutableDictionary *)dictWithString:(nullable NSString *)string;

+ (nullable NSString *)toStringWithArray:(nullable NSArray *)array;

+ (nullable NSString *)toStringWithDict:(nullable NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
