//
//  PublicDefine.h
//
//  Created by midmirror on 15/12/20.
//  Copyright © 2015年 midmirror. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

/*
 用于生成一个单例
 */

// @interface
//#define singletonH(className) \
//+ (className *)share;
//
//// @implement
//#define singletonM(className) \
//static className *instance; \
//+ (className *)share \
//{ \
//static dispatch_once_t once; \
//dispatch_once(&once, ^{ \
//instance = [[self alloc] init]; \
//}); \
//return instance; \
//}

#define singletonH(className) \
+ (className *)share;

// @implement
#define singletonM(className) \
static className *instance = nil; \
+ (className *)share \
{ \
if (instance == nil) { \
instance = [[className alloc] init]; \
} \
return instance; \
}
//真机调试不输出的解决办法
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#endif /* PublicDefine_h */
