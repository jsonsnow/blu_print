//
//  PTLabelAppend.h
//  WirelessPrinter
//
//  Created by midmirror on 16/9/19.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <PrinterSDK/PrinterSDK.h>

/** 用于自定义添加新的模板参数，需要继承 PTLabel 类 */
@interface PTLabelAppend : PTLabel

// CIAONIAO遗留接口
@property(strong,nonatomic,readwrite) NSString *code_number;        // 编号
@property(strong,nonatomic,readwrite) NSString *sender;
@property(strong,nonatomic,readwrite) NSString *sender_contact;
@property(strong,nonatomic,readwrite) NSString *receiver;
@property(strong,nonatomic,readwrite) NSString *receiver_contact;
@property(strong,nonatomic,readwrite) NSString *collection;
@property(strong,nonatomic,readwrite) NSString *date;
@property(strong,nonatomic,readwrite) NSString *print_time;

// TianTian
@property(copy,nonatomic,readwrite) NSString *referred;
@property(copy,nonatomic,readwrite) NSString *referred_width;
@property(copy,nonatomic,readwrite) NSString *city;
@property(copy,nonatomic,readwrite) NSString *number;
@property(copy,nonatomic,readwrite) NSString *receiver_address1;
@property(copy,nonatomic,readwrite) NSString *receiver_address2;
@property(copy,nonatomic,readwrite) NSString *receiver_address3;
@property(copy,nonatomic,readwrite) NSString *waybill;
@property(copy,nonatomic,readwrite) NSString *sender_address1;
@property(copy,nonatomic,readwrite) NSString *sender_address2;
@property(copy,nonatomic,readwrite) NSString *sender_address3;
@property(copy,nonatomic,readwrite) NSString *product_types;
@property(copy,nonatomic,readwrite) NSString *quantity;
@property(copy,nonatomic,readwrite) NSString *weight;

@end
