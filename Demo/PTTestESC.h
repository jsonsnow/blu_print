//
//  PTTestESC.h
//
//  Created by midmirror on 15/12/18.
//  Copyright © 2015年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PrinterSDK/PrinterSDK.h>

@interface PTTestESC : NSObject

- (void)testPrintMaxByte:(int)number;
- (NSString *)getCurrentTime:(NSString *)title;

- (void)printEnglishText;
- (void)printSimplifiedChineseText;
- (void)printBarcode;
- (void)printBitmap;
- (NSData *)printElectronicSheet;
- (void)printReceipt3;
- (void)printQRcode;
- (void)printTraditionalModeCode;
- (void)printJapanText;
- (void)printKoreanText;

- (void)printWithTemplate;

- (void)drawLineAndRectangle;

- (NSData *)textJustifiatopn;

@end
