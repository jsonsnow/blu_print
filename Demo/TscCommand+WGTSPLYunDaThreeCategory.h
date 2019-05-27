//
//  TscCommand+WGTSPLYunDaThreeCategory.h
//  Demo
//
//  Created by chen liang on 2019/4/29.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface TscCommand (WGTSPLYunDaThreeCategory)

- (void)yunda_three_commonData;

/**
 集
 eg: 市内包
 
 @param area 区域
 */
- (void)yunda_three_area_data:(NSString *)area;

/**
 签收联
 
 @param name 收件人名字
 @param phone 收件人手机号码
 */
- (void)yunda_three_addReceiverName:(NSString *)name phone:(NSString *)phone;

/**
 签收联
 
 @param address 收件人地址
 */
- (void)yunda_three_addReceiverAddress:(NSString *)address;


/**
 签收联
 
 @param name 发件人名字
 @param phone 发件人手机号码
 */
- (void)yunda_three_addSendName:(NSString *)name phone:(NSString *)phone;

/**
 签收联
 
 @param address 发件人地址
 */
- (void)yunda_three_addSendAdress:(NSString *)address;

- (void)yunda_three_addSignName:(NSString *)name;

/**
 签收联
 
 @param date 时间
 */
- (void)yunda_three_addSignDate:(NSString *)date;


/**
 签收联
 
 @param codeNumber 条码
 */
- (void)yunda_three_topBarCodeNumber:(NSString *)codeNumber;

/**
 签收联
 
 @param remark 备注信息
 */
- (void)yunda_three_remark_data:(NSString *)remark;

/**
 签收联
 
 @param qrCode 二维码
 */
- (void)yunda_three_top_qr_code:(NSString *)qrCode;

///下联数据
- (void)yunda_three_bottomCodeNumber:(NSString *)codeNumber;
- (void)yunda_three_bottomReceiverName:(NSString *)name phone:(NSString *)phone;
- (void)yunda_three_bottomaddReceiverAddress:(NSString *)address;

- (void)yunda_three_bottomAddSendName:(NSString *)name phone:(NSString *)phone;
- (void)yunda_three_bottomAddSendAdress:(NSString *)address;
- (void)yunda_three_bottom_qr_code:(NSString *)qrCode;
@end

NS_ASSUME_NONNULL_END
