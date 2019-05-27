//
//  PTCommandCPCLSlim.h
//  WirelessPrinter
//
//  Created by midmirror on 16/8/30.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTCommandCPCL : NSObject

@property(strong,nonatomic,readwrite) NSMutableData * _Nonnull cmdData;

- (void)appendCommand:(NSString * _Nonnull)cmd;

- (void)appendCommandData:(NSData * _Nonnull)data;

/**
 获取打印机状态 get printer status.
 */
- (void)cpclGetPaperStatus;

/**
 开关打印状态回调
 turn on/off print status callback.

 @param flag on/off
 */
- (void)cpclTurnOnPrintStatusCallBack:(BOOL)flag;

/**
 打开下划线
 Turn on underline
 */
- (void)cpclUnderlineON;

/**
 关闭下划线
 Turn off underline
 */
- (void)cpclUnderlineOFF;
- (void)cpclUtilitySession;

/** 行模式指令前缀 Command prefix of line mode */
- (void)cpclLineMode;
- (void)cpclReWindOFF;


/**
 *   设置纸张类型 Set the paper type
 *
 *  @param type      (0~5)
 0:连续纸 continuous paper
 1：标签纸 Label paper
 2：后黑标 Back black mark
 3：前黑标 Front black mark
 4：3寸黑标 3 inch black mark
 5：2寸黑标 2 inch black mark
 */
- (void)cpclPaperTypeWithType:(NSInteger )type;

- (void)cpclLabelWithOffset:(NSInteger)offset
                       hRes:(NSInteger)hRes
                       vRes:(NSInteger)vRes
                     height:(NSInteger)height
                   quantity:(NSInteger)quantity;

- (void)cpclBarcode:(NSString * _Nonnull)type
              width:(NSInteger)width
              ratio:(NSInteger)ratio
             height:(NSInteger)height
                  x:(NSInteger)x
                  y:(NSInteger)y
            barcode:(NSString * _Nonnull)barcode;

- (void)cpclBarcodeVertical:(NSString * _Nonnull)type
                      width:(NSInteger)width
                      ratio:(NSInteger)ratio
                     height:(NSInteger)height
                          x:(NSInteger)x
                          y:(NSInteger)y
                    barcode:(NSString * _Nonnull)barcode;

- (void)cpclBarcodeQRcodeWithXPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                            model:(NSInteger)model
                        unitWidth:(NSInteger)unitWidth;

- (void)cpclBarcodeQRcodeVerticalWithXPos:(NSInteger)xPos
                                     yPos:(NSInteger)yPos
                                    model:(NSInteger)model
                                unitWidth:(NSInteger)unitWidth;

- (void)cpclBarcodeQRcodeData:(NSString * _Nonnull)data config:(NSString * _Nonnull)config;

- (void)cpclBarcodeQRcodeEnd;

- (void)cpclBarcodeTextWithFont:(NSInteger)font
                       fontSize:(NSInteger)fontSize
                         offset:(NSInteger)offset;

- (void)cpclBarcodeTextWithTrueTypeFont:(NSInteger)font
                                 xScale:(NSInteger)xScale
                                 yScale:(NSInteger)yScale
                                 offset:(NSInteger)offset;

- (void)cpclBarcodeTextOff;

/**
 *   绘制矩形 Draw rectangle
 *
 *  @param xPos      (0~65535)
 *  @param yPos      (0~65535)
 *  @param xEnd      (0~65535)
 *  @param yEnd      (0~65535)
 *  @param thickness (0~65535)
 */
- (void)cpclBoxWithXPos:(NSInteger)xPos
                   yPos:(NSInteger)yPos
                   xEnd:(NSInteger)xEnd
                   yEnd:(NSInteger)yEnd
              thickness:(NSInteger)thickness;

- (void)cpclCenterWithRange:(NSInteger)range;

- (void)cpclCenter;

- (void)cpclCompressedGraphicsWithImageWidth:(NSInteger)imageWidth
                                 imageHeight:(NSInteger)imageHeight
                                           x:(NSInteger)x
                                           y:(NSInteger)y
                                  bitmapData:(NSData * _Nonnull)bitmapData;

- (void)cpclConcatStartWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos;
- (void)cpclConcatVerticalStartWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos;

/** 字段拼接 Field combination */
- (void)cpclConcatTextWithFont:(NSInteger)font
                      fontSize:(NSInteger)fontSize
                        offset:(NSInteger)offset
                          text:(NSString * _Nonnull)text;

- (void)cpclConcatScaleTextWithScaledFont:(NSInteger)scaledFont
                                   xScale:(NSInteger)xScale
                                   yScale:(NSInteger)yScale
                                   offset:(NSInteger)offset
                                     text:(NSString * _Nonnull)text;

- (void)cpclConcatScaleTextVerticalWithScaledFont:(NSInteger)scaledFont
                                           xScale:(NSInteger)xScale
                                           yScale:(NSInteger)yScale
                                           offset:(NSInteger)offset
                                             text:(NSString * _Nonnull)text;

- (void)cpclConcatTextWithFontGroup:(NSInteger)fontGroup
                             offset:(NSInteger)offset
                               text:(NSString * _Nonnull)text;

- (void)cpclConcatEnd;
- (void)cpclPrint;
/** 反向打印 Reverse print */
- (void)cpclPoPrint;

/**
 反白框

 @param xPos 起点的x坐标
 @param yPos 起点的y坐标
 @param xEnd 终点的x坐标
 @param yEnd 终点的y坐标
 @param thickness 框的高度
 */
- (void)cpclInverseLineWithXPos:(NSInteger)xPos
                           yPos:(NSInteger)yPos
                           xEnd:(NSInteger)xEnd
                           yEnd:(NSInteger)yEnd
                      thickness:(NSInteger)thickness;

- (void)cpclLeft:(NSInteger)range;

- (void)cpclLeft;

- (void)cpclLineWithXPos:(NSInteger)xPos
                    yPos:(NSInteger)yPos
                    xEnd:(NSInteger)xEnd
                    yEnd:(NSInteger)yEnd
               thickness:(NSInteger)thickness;

- (void)cpclMoveWithRight:(NSInteger)right up:(NSString * _Nonnull)up;
- (void)cpclMultiLineStartWithLineHeight:(NSInteger)lineHeight;
- (void)cpclMultiLineEnd;
- (void)cpclPageWidth:(NSInteger)pageWidth;
- (void)cpclRight:(NSInteger)right;
- (void)cpclRight;
- (void)cpclRotate:(NSInteger)degrees;
- (void)cpclScaleText:(NSString * _Nonnull)scaledFont
               xScale:(NSInteger)xScale
               yScale:(NSInteger)yScale
                    x:(NSInteger)x
                    y:(NSInteger)y
                 text:(NSString * _Nonnull)text;

- (void)cpclScaleTextVertical:(NSString * _Nonnull)scaledFont
                       xScale:(NSInteger)xScale
                       yScale:(NSInteger)yScale
                            x:(NSInteger)x
                            y:(NSInteger)y
                         text:(NSString * _Nonnull)text;

- (void)cpclScaleToFit:(NSString * _Nonnull)scaleFont
                 width:(NSInteger)width
                height:(NSInteger)height
                     x:(NSInteger)x
                     y:(NSInteger)y
                  text:(NSString * _Nonnull)text;

/**
 设置字体加粗
 Set the font bold
 
 @param boldness 加粗值 0 不加粗 : bold value, 0 is not bold
 */
- (void)cpclSetBold:(NSInteger)boldness;

/**
 设置字间距
 Set character spacing

 @param spacing 字间距 character spacing
 */
- (void)cpclSetSpacing:(NSInteger)spacing;

/**
 设置字体放大倍数
 Set font magnification multiple

 @param width 宽度放大系数 magnification multiple of width
 @param height 高度放大系数 magnification multiple of height
 */
- (void)cpclSetMagWithWidth:(NSInteger)width height:(NSInteger)height;
- (void)cpclTempMove:(NSInteger)right up:(NSInteger)up;

/** 
 自动换行 Word wrap
 */
- (void)cpclAutoTextWithRotate:(NSInteger)rotate
                          font:(NSInteger)font
                      fontSize:(NSInteger)fontSize
                             x:(NSInteger)x
                             y:(NSInteger)y
                         width:(NSInteger)width
                   lineSpacing:(NSInteger)lineSpacing
                          text:(NSString * _Nonnull)text;


/**
 打印居中文本
 Print center text

 @param rotate 旋转角度 : rotation angle
 @param font 字号 暂时支持 1 2 3 4 8 55  :font size, temporarily supports 1 2 3 4 8 55
 @param fontSize 字体大小 : font size
 @param x 起点x坐标 : x-coordinate of start point
 @param y 起点y坐标 : y-coordinate of start point
 @param width 文本框宽度 : width of textbox
 @param text 文字内容 : content of text
 */
- (void)cpclCenterTextWithRotate:(NSInteger)rotate
                            font:(NSInteger)font
                        fontSize:(NSInteger)fontSize
                               x:(NSInteger)x
                               y:(NSInteger)y
                           width:(NSInteger)width
                            text:(NSString * _Nonnull)text;

/**
 打印文字
 Print text
 
 @param rotate 文字旋转角度 : rotation angle of text
 @param font 字体编号 : font number
 @param fontSize 字体大小 暂不可用 : font size, cannot be used temporarily
 @param x 起点x坐标 :  x-coordinate of start point
 @param y 起点y坐标 : y-coordinate of start point
 @param text 文字内容 : content of text
 */
- (void)cpclTextWithRotate:(NSInteger)rotate
                      font:(NSInteger)font
                  fontSize:(NSInteger)fontSize
                         x:(NSInteger)x
                         y:(NSInteger)y
                      text:(NSString * _Nonnull)text;

// 暂不支持 Reverse
//- (void)cpclTextWithRotate:(NSInteger)rotate
//              trueTypeFont:(NSInteger)trueTypeFont
//                    xScale:(NSInteger)xScale
//                    yScale:(NSInteger)yScale
//                         x:(NSInteger)x
//                         y:(NSInteger)y
//                      text:(NSString * _Nonnull)text;
//
//- (void)cpclTextWithRotate:(NSInteger)rotate
//                 fontGroup:(NSInteger)fontGroup
//                         x:(NSInteger)x
//                         y:(NSInteger)y
//                      text:(NSString * _Nonnull)text;

//反白
- (void)cpclTextReverseWithFont:(NSInteger)font
                       fontSize:(NSInteger)fontSize
                              x:(NSInteger)x
                              y:(NSInteger)y
                           text:(NSString * _Nonnull)text;
// 反白 加粗 Reverse  bold
/**
 | Font | Chinese   | ASCII character (English, number, etc.) |
 | Font | 中文   | ASCII字符（英文，数字等） |
 | ---- | ----- | --------------- |
 | 1    | 24*24 | 9*17            |
 | 2    | 24*24 | 8*16            |
 | 3    | 20*20 | 10*20           |
 | 4    | 32*32 | 16*32           |
 | 8    | 24*24 | 12*24           |
 | 55   | 16*16 | 8*16            |
 
 rotate: 0 90 180 270

 */
- (void)appendTextWithFont:(NSInteger)font
                    rotate:(NSInteger)rotate
                  fontSize:(NSInteger)fontSize
                   reverse:(BOOL)reverse
                      bold:(NSInteger)bold
                         x:(NSInteger)x
                         y:(NSInteger)y
                      text:(NSString * _Nonnull)text;

/***************** Line Print Commands *******************/

- (void)cpclLineMargin:(NSInteger)offset;
- (void)cpclSetPositionWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos;
- (void)cpclSetPositionWithXPos:(NSInteger)xPos;
- (void)cpclSetPositionWithYPos:(NSInteger)yPos;
- (void)cpclLineFeed;
- (void)cpclContrast:(NSInteger)value;
- (void)cpclFeed:(NSInteger)amount;
- (void)cpclLabel;
- (void)cpclMulti:(NSInteger)quantity;
- (void)cpclNoPace;
- (void)cpclPace;
- (void)cpclPostFeed:(NSInteger)amount;
- (void)cpclPreFeed:(NSInteger)amount;
- (void)cpclReverse:(NSInteger)amount;
- (void)cpclSetFeed:(NSInteger)length skip:(NSInteger)skip;
- (void)cpclSpeed:(NSInteger)value;

//Take the paper to the next label
- (void)cpclForm;
- (void)cpclTone:(NSInteger)value;
- (void)cpclTurn:(NSInteger)degrees;
- (void)cpclFormFeed;

/****************** Utility and Diagnostic Commands ****************/
- (void)cpclAbort;
- (void)cpclOnFeed_Feed;
- (void)cpclOnFeed_Reprint;
- (void)cpclOnFeed_Ignore;
- (void)cpclReRun;
- (void)cpclWait:(NSInteger)duration;
- (void)cpclSetLabelPositionWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos;
- (void)cpclSetLabelPositionWithXPos:(NSInteger)xPos;
- (void)cpclSetLabelPositionWithYPos:(NSInteger)yPos;

@end
