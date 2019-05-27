//
//  TscCommand+TSPLCategory.m
//  Demo
//
//  Created by chen liang on 2019/4/22.
//  Copyright © 2019 smarnet. All rights reserved.
//



#import "TscCommand+TSPLCategory.h"
#import "WGPrintHeaderFile.h"
#import "TscCommand+WGTSPLCommonGategory.h"

@implementation TscCommand (TSPLCategory)


- (NSString *)normalFontType {
    return @"TSS24.BF2";
}

- (int)zhongTong_MM_TO_DOT:(int)pot {
    return pot * 8;
}

- (void)zhongTong_CommandData {
    NSString *font = [self normalFontType];
    TscCommand *cmd = self;
    [cmd addSize:100 :180];
    [cmd addGapWithM:0 withN:0];
    [cmd addDirection:1];
    [cmd addReference:0 :0];
    [cmd addHome];
    [cmd addQueryPrinterStatus:ON];
    [cmd addCls];
    [cmd addBox:0 :8 :800 :1440 :8];
    
    [cmd addBar:0 :MM_TO_DOT(9) :800 :2];
    [cmd addBar:0 :MM_TO_DOT(9 + 15) :800 :2];
    [cmd addBar:600 :MM_TO_DOT(24) :2 :MM_TO_DOT(12)];
    
    //地址栏
    [cmd addBar:0 :MM_TO_DOT(36) :800 :2];
    [cmd addBar:64 :MM_TO_DOT(36) :2 :240];
    [cmd addBar:0 :MM_TO_DOT(39 + 18) :800 :2];
    
    [cmd addBar:0 :MM_TO_DOT(36 + 18 + 12) :800 :2];
    [cmd addBar:0 :MM_TO_DOT(36 + 18 + 12 + 25) :800 :2];
    [cmd addBar:320 :MM_TO_DOT(36 + 18 + 12 + 25) :2 :MM_TO_DOT(18)];
    
    [cmd addBar:0 :MM_TO_DOT(36 + 18 + 12 + 25 + 18) :800 :8];
    [cmd addBar:0 :MM_TO_DOT(39 + 18 + + 12 + 25 + 18 + 14) :800 :2];
    [cmd addBar:64 :MM_TO_DOT(36 + 18 + 12 + 25 + 18 + 14) :2 :MM_TO_DOT(30 + 25)];
    [cmd addBar:0 :MM_TO_DOT(36 + 18 + 12 + 25 + 18 + 14 + 18) :800 :2];
    [cmd addBar:0 :MM_TO_DOT(36 + 18 + 12 + 25 + 18 + 14 + 18 + 12) :800 :2];
    
    [self addSignPersonTemplate];
    [self addWarningMsg];
    
    [cmd addTextwithX:26 withY:330 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"收"];
    [cmd addTextwithX:26 withY:370 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"货"];
    [cmd addTextwithX:26 withY:440 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"寄"];
    [cmd addTextwithX:26 withY:480 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"货"];
    
    [cmd addTextwithX:26 withY:1040 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"收"];
    [cmd addTextwithX:26 withY:1070 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"货"];
    [cmd addTextwithX:26 withY:1120 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"寄"];
    [cmd addTextwithX:26 withY:1160 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"货"];
}

- (void)addSignPersonTemplate {
     NSString *font = @"TSS24.BF2";
    [self addTextwithX:328 withY:736 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"签收人："];
    [self addTextwithX:328 withY:864 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:@"时间："];
}

- (void)addWarningMsg {
    NSString *font = @"TSS16.BF2";
    NSString *label1 = @"您对此单的签收，代表您已验收。确认商";
    NSString *label2 = @"品信息无误，包装完好，没有划痕，磕碰";
    NSString *label3 = @"等表面质量问题。";
    [self addTextwithX:26 withY:736 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:label1];
    [self addTextwithX:26 withY:760 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:label2];
    [self addTextwithX:26 withY:784 + 40 withFont:font withRotation:0 withXscal:1 withYscal:1 withText:label3];
}

- (void)zhongTong_addReceiverName:(NSString *)name phone:(NSString *)phone {
    NSString *text = [NSString stringWithFormat:@"%@ %@", name, phone];
    [self addTextwithX:72 withY:312 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: text];
}

- (void)zhongTong_addReceiverAddress:(NSString *)address {
    [self addTextwithX:72 withY:352 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: address];
}

- (void)zhongTong_addSendName:(NSString *)name phone:(NSString *)phone {
    NSString *text = [NSString stringWithFormat:@"%@ %@", name, phone];
    [self addTextwithX:72 withY:440 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: text];
}

- (void)zhongTong_addSendAdress:(NSString *)address {
    [self addTextwithX:72 withY:472 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: address];
}

- (void)zhongTong_TopBarCodeNumber:(NSString *)codeNumber {
     [self add1DBarcode:96 :544 + 40 :@"128" :120 :1 :0 :5 :400 :codeNumber];
}

- (void)zhongTong_addSignName:(NSString *)name {
    
}

- (void)zhongTong_addSignDate:(NSString *)date {
    
}

- (void)zhongTong_BottomCodeNumber:(NSString *)codeNumber {
    [self add1DBarcode:96 :867 + 40 :@"128" :72 :1 :0 :3 :240 :codeNumber];
}

- (void)zhongTong_BottomReceiverName:(NSString *)name phone:(NSString *)phone {
    NSString *text = [NSString stringWithFormat:@"%@ %@", name, phone];
    [self addTextwithX:72 withY:1016 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: text];
}

- (void)zhongTong_BottomaddReceiverAddress:(NSString *)address {
     [self addTextwithX:72 withY:1056 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: address];
}

- (void)zhongTong_bottomAddSendName:(NSString *)name phone:(NSString *)phone {
    NSString *text = [NSString stringWithFormat:@"%@ %@", name, phone];
    [self addTextwithX:72 withY:1128 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: text];
}

- (void)zhongTong_bottomAddSendAdress:(NSString *)address {
     [self addTextwithX:72 withY:1168 + 40 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText: address];
}

- (void)zhongTong_addRemarkStr:(NSString *)str {
    
}
@end
