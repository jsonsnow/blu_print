//
//  Template.h
//  BluetoothDemo
//
//  Created by midmirror on 16/10/28.
//  Copyright © 2016年 Mellow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Template : NSObject

+ (NSData *)printZhongJiTemplate_CPCL;
+ (NSData *)printZhongJiTemplate_TSPL;
+ (NSData *)printTianTianTemplate;
+ (NSData *)printShenTongTemplate;
+ (NSData *)printZhongTongTemplate;
+ (NSData *)printKuaiDaTemplate_CPCL;

//+ (NSData *)printselfTest;

@end
