//
//  TscCommand+TSPLCategory.h
//  Demo
//
//  Created by chen liang on 2019/4/22.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface TscCommand (TSPLCategory)



//以下方法未中通快递快速创建方法
//共用数据
- (void)zhongTong_CommandData;

- (void)zhongTong_addReceiverName:(NSString *)name phone:(NSString *)phone;
- (void)zhongTong_addReceiverAddress:(NSString *)address;

- (void)zhongTong_addSendName:(NSString *)name phone:(NSString *)phone;
- (void)zhongTong_addSendAdress:(NSString *)address;

- (void)zhongTong_addSignName:(NSString *)name;
- (void)zhongTong_addSignDate:(NSString *)date;

- (void)zhongTong_TopBarCodeNumber:(NSString *)codeNumber;

///下联数据
- (void)zhongTong_BottomCodeNumber:(NSString *)codeNumber;
- (void)zhongTong_BottomReceiverName:(NSString *)name phone:(NSString *)phone;
- (void)zhongTong_BottomaddReceiverAddress:(NSString *)address;

- (void)zhongTong_bottomAddSendName:(NSString *)name phone:(NSString *)phone;
- (void)zhongTong_bottomAddSendAdress:(NSString *)address;

- (void)zhongTong_addRemarkStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
