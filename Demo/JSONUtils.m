//
//  JSONUtils.m
//  WeAblum
//
//  Created by 张忠燕 on 2019/1/23.
//  Copyright © 2019 WeAblum. All rights reserved.
//

#import "JSONUtils.h"

@implementation JSONUtils

+ (nullable NSMutableArray *)arrayWithData:(nullable NSData *)data
{
    if ([data isKindOfClass:NSData.class]) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return [obj isKindOfClass:NSMutableArray.class]? obj: nil;
    }else {
        return nil;
    }
}

+ (nullable NSMutableArray *)arrayWithString:(nullable NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithData:data];
}

+ (nullable NSMutableDictionary *)dictWithData:(nullable NSData *)data
{
    if ([data isKindOfClass:NSData.class]) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return [obj isKindOfClass:NSMutableDictionary.class]? obj: nil;
    }else {
        return nil;
    }
}

+ (nullable NSMutableDictionary *)dictWithString:(nullable NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictWithData:data];
}


+ (nullable NSString *)toStringWithArray:(nullable NSArray *)array
{
    if ([array isKindOfClass:NSArray.class]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        return data? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]: nil;
    }else {
        return nil;
    }
}

+ (nullable NSString *)toStringWithDict:(nullable NSDictionary *)dict
{
    if ([dict isKindOfClass:NSDictionary.class]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        return data? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]: nil;
    }else {
        return nil;
    }
}

@end
