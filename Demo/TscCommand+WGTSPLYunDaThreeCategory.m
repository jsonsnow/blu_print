//
//  TscCommand+WGTSPLYunDaThreeCategory.m
//  Demo
//
//  Created by chen liang on 2019/4/29.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "TscCommand+WGTSPLYunDaThreeCategory.h"
#import "TscCommand+WGTSPLCommonGategory.h"
#import "WGPrintHeaderFile.h"

@implementation TscCommand (WGTSPLYunDaThreeCategory)

#pragma mark -- box line
- (void)yunda_three_commonData {
    [self yunda_three_config_data];
    [self yunda_three_delivery_box_line];
    [self yunda_three_recevier_box_line];
    [self yunda_three_send_box_line];
}

- (void)yunda_three_config_data {
    [self addSize:YUN_DA_THREE_PAGE_WIDTH :YUN_DA_THREE_PAGE_HEIGHT];
    [self addGapWithM:0 withN:0];
    [self addDirection:0];
    [self addReference:0 :0];
    [self addHome];
    [self addQueryPrinterStatus:ON];
    [self addCls];
    //[self addBox:0 :8 :800 :1440 :8];
}

- (void)yunda_three_delivery_box_line {
    [self addBar:0 :MM_TO_DOT(47) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(47 + 11) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(47 + 11 + 8) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(47 + 11 + 8 + 11) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(47 + 11 + 8 + 11 + 10) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:MM_TO_DOT(5) :MM_TO_DOT(47) :1 :MM_TO_DOT(11 + 8 + 11)];
    [self addBar:MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :MM_TO_DOT(47) :1 :MM_TO_DOT(11 + 8 + 11 + 10)];
}

- (void)yunda_three_recevier_box_line {
    [self addBar:0 :MM_TO_DOT(92 + 10) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(92 + 10 + 11) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(92 + 10 + 11 + 11) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:MM_TO_DOT(5) :MM_TO_DOT(92 + 10) :1 :MM_TO_DOT(22)];
    [self addBar:MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :MM_TO_DOT(92 + 10) :1 :MM_TO_DOT(22)];
}

- (void)yunda_three_send_box_line {
    [self addBar:0 :MM_TO_DOT(127 + 10) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:0 :MM_TO_DOT(127 + 10 + 11) :MM_TO_DOT(YUN_DA_THREE_PAGE_WIDTH - 3) :1];
    [self addBar:MM_TO_DOT(36) :MM_TO_DOT(127 + 10) :1 :MM_TO_DOT(11)];
}

@end
