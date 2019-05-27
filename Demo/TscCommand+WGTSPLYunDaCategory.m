//
//  TscCommand+WGTSPLYunDaCategory.m
//  Demo
//
//  Created by chen liang on 2019/4/29.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand+WGTSPLYunDaCategory.h"
#import "WGPrintHeaderFile.h"
#import "TscCommand+TSPLCategory.h"
#import "TscCommand+WGTSPLCommonGategory.h"

@implementation TscCommand (WGTSPLYunDaCategory)

#pragma mark -- commond data
- (void)yunda_commonData {
    [self yunda_config_data];
    [self yunda_sign_box_line];
    [self yunda_stub_box_line];
}

- (void)yunda_config_data {
    [self addSize:100 :180];
    [self addGapWithM:0 withN:0];
    [self addDirection:1];
    [self addReference:0 :0];
    [self addHome];
    [self addQueryPrinterStatus:ON];
    [self addCls];
    //[self addBox:0 :8 :800 :1440 :8];
}

//签收box line
- (void)yunda_sign_box_line {
    [self addBar:0 :MM_TO_DOT(17) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:MM_TO_DOT(83) :0 :1 :MM_TO_DOT(17)];
    
    [self addBar:MM_TO_DOT(78) :MM_TO_DOT(17) :1 :MM_TO_DOT(15)];
    [self addBar:0 :MM_TO_DOT(17 + 15) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15 + 12) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    
    [self addBar:MM_TO_DOT(18) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22) :1 :MM_TO_DOT(17)];
    [self addBar:MM_TO_DOT(78) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22) :1 :MM_TO_DOT(17)];
}

//存根box line
- (void)yunda_stub_box_line {
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10) :MM_TO_DOT(YUN_DA_PAGE_WIDTH - 22) :1];
    [self addBar:0 :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 10) :MM_TO_DOT(YUN_DA_PAGE_WIDTH) :1];
    [self addBar:MM_TO_DOT(78) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14) :1: MM_TO_DOT(20)];
}

#pragma mark -- 派件联
/// 集
- (void)yunda_area_data:(NSString *)area {
    [self addTextwithX:MM_TO_DOT(2) withY:MM_TO_DOT(17 + 15 + 2) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:2 withYscal:2 withText:@"集"];
    [self addTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 1) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:3 withYscal:3 withText:area];
}

/// 收 person data
- (void)yunda_addReceiverName:(NSString *)name phone:(NSString *)phone {
    [self addTextwithX:MM_TO_DOT(1) withY:MM_TO_DOT(17 + 15 + 10 + 4) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:2 withYscal:2 withText:@"收"];
    NSString *text = [NSString stringWithFormat:@"%@   %@", name, phone];
    [self addTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 1) withFont:YUN_DA_SMALL_FONT withRotation:0 withXscal:2 withYscal:2 withText:text];
}

/// 收 revevier address data
- (void)yunda_addReceiverAddress:(NSString *)address {
    //[self drawTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 6) withWidth:MM_TO_DOT(90) withFont:YUN_DA_SMALL_FONT withRotation:0 withXscal:2 withYscal:2 withText:address];
}

/// 寄 send person data
- (void)yunda_addSendName:(NSString *)name phone:(NSString *)phone {
    [self addTextwithX:MM_TO_DOT(1) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 4) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:2 withYscal:2 withText:@"寄"];
    NSString *text = [NSString stringWithFormat:@"%@   %@", name, phone];
    [self addTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 0.5) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:text];
}

/// 寄 send perseon address
- (void)yunda_addSendAdress:(NSString *)address {
    //[self drawTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 5) withWidth:MM_TO_DOT(90) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:address];
}

/// 条码
- (void)yunda_topBarCodeNumber:(NSString *)codeNumber {
    [self add1DBarcode:MM_TO_DOT(10) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 2) :@"128" :MM_TO_DOT(14) :1 :0 :MM_TO_DOT(0.5) :MM_TO_DOT(2.5) :codeNumber];
}


- (void)yunda_addSignDate:(NSString *)date {
   // [self drawTextwithX:0 withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 1) withWidth:MM_TO_DOT(18) withFont:YUN_DA_SMALL_FONT withRotation:0 withXscal:1 withYscal:1 withText:date];
}

/// 备注
- (void)yunda_remark_data:(NSString *)remark {
    //[self drawTextwithX:MM_TO_DOT(19) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 2) withWidth:MM_TO_DOT(58) withFont:YUN_DA_SMALL_FONT withRotation:0 withXscal:1 withYscal:1 withText:remark];
}

/// 二维码
- (void)yunda_top_qr_code:(NSString *)qrCode {
    [self addQRCode:MM_TO_DOT(79) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 1) :@"X" :6 :@"Auto" :0 :qrCode];
}


#pragma mark -- 存根联数据
- (void)yunda_bottomCodeNumber:(NSString *)codeNumber {
     [self add1DBarcode:MM_TO_DOT(41) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 3) :@"128" :MM_TO_DOT(7) :1 :0 :MM_TO_DOT(0.4) :MM_TO_DOT(1) :codeNumber];
}

- (void)yunda_bottomReceiverName:(NSString *)name phone:(NSString *)phone {
    [self addTextwithX:MM_TO_DOT(1) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 2) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:2 withYscal:2 withText:@"收"];
    NSString *text = [NSString stringWithFormat:@"%@   %@", name, phone];
    [self addTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 1) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:text];
}

- (void)yunda_bottomaddReceiverAddress:(NSString *)address {
    // [self drawTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 4) withWidth:MM_TO_DOT(70) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:address];
}

- (void)yunda_bottomAddSendName:(NSString *)name phone:(NSString *)phone {
    [self addTextwithX:MM_TO_DOT(1) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 2) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:2 withYscal:2 withText:@"寄"];
    NSString *text = [NSString stringWithFormat:@"%@   %@", name, phone];
    [self addTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 1) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:text];
}

- (void)yunda_bottomAddSendAdress:(NSString *)address {
    //[self drawTextwithX:MM_TO_DOT(10) withY:MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 6) withWidth:MM_TO_DOT(90) withFont:YUN_DA_BIG_FONT withRotation:0 withXscal:1 withYscal:1 withText:address];
}

- (void)yunda_bottom_qr_code:(NSString *)qrCode {
    [self addQRCode:MM_TO_DOT(79) :MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 1) :@"X" :6 :@"Auto" :0 :qrCode];
}
@end
