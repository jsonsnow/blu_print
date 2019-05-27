//
//  PTLabel.h
//  WirelessPrinter
//
//  Created by midmirror on 16/9/19.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  使用电子面单模板，只需要填充相应的表单数据，即可发送打印出一张面单。
 *  注意： 1. 当使用模板打印时，您必须填充我们提供的模板使用范例中所填充的所有表单项。
 2. 如果有空数据项，比如申明价值为空，则传入@""空字符串。
 3. 不同的模板，所要填充的数据项是不同的，具体以我们的范例为准。
 */
/**
 *  By using electronic waybill template, only filling in it accordingly can send and print it out。
 *  Note： 1. When using template to print, you should fill in all the blanks as the template sample showed
 2.If there is null data, e.g. claiming value is null, please input null character string @"".
 3.The data to fill in differs depending on the template, please subject to the sample showed.
 */
@interface PTLabel : NSObject

@property(strong,nonatomic,readwrite) NSString *express_company;    // 快递公司

@property(strong,nonatomic,readwrite) NSString *delivery_number;    // 运单号
@property(strong,nonatomic,readwrite) NSString *order_number;       // 订单号

@property(strong,nonatomic,readwrite) NSString *distributing;       // 集散地
@property(strong,nonatomic,readwrite) NSString *barcode;            // 条形码
@property(strong,nonatomic,readwrite) NSString *barcode_text;       // 条形码下方的字符
@property(strong,nonatomic,readwrite) NSString *qrcode;             // 二维码
@property(strong,nonatomic,readwrite) NSString *qrcode_text;        // 二维码下方的字符

@property(strong,nonatomic,readwrite) NSString *receiver_name;      // 收件人 名字
@property(strong,nonatomic,readwrite) NSString *receiver_phone;     // 收件人 电话
@property(strong,nonatomic,readwrite) NSString *receiver_address;   // 收件人 地址
@property(strong,nonatomic,readwrite) NSString *receiver_message;   // 收件人 信息

@property(strong,nonatomic,readwrite) NSString *sender_name;        // 发件人 名字
@property(strong,nonatomic,readwrite) NSString *sender_phone;       // 发件人 电话
@property(strong,nonatomic,readwrite) NSString *sender_address;     // 发件人 地址
@property(strong,nonatomic,readwrite) NSString *sender_message;     // 发件人 信息

@property(strong,nonatomic,readwrite) NSString *article_name;       // 物品名
@property(strong,nonatomic,readwrite) NSString *article_weight;     // 物品重量

@property(strong,nonatomic,readwrite) NSString *amount_declare;     // 申明价值
@property(strong,nonatomic,readwrite) NSString *amount_paid;        // 到付金额
@property(strong,nonatomic,readwrite) NSString *amount_paid_advance;// 预付金额

- (NSData *)dataWithSourceFile:(NSString *)filePath;
- (NSData *)dataWithTSPL;
- (NSData *)getTemplateData:(NSString *)source labelDict:(NSDictionary *)labelDict orderDetails:(NSArray *)orderDetails;
- (NSData *)getTemplateData:(NSString *)source labelDict:(NSDictionary *)labelDict;
+ (NSData *)getPaperStauts; // 获取纸张状态

@end
