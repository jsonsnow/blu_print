//
//  PTCommandTSPL.h
//  PrinterCommand
//
//  Created by midmirror on 16/2/29.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDKDefine.h"

/**
 *  TSC-TSPL 指令集：大约62个生成指令的函数
 *  TSC-TSPL command set：about 62 functions which generated into command
 */
@interface PTCommandTSPL : NSObject

@property(strong,nonatomic,readwrite) NSMutableData *cmdData;

singletonH(PTCommandTSPL)

/**
 *  printer print self-test message.
 *  自检，打印打印机信息
 */
- (void)selfTest;

- (void)appendCommand:(NSString *)cmd;

/**
 *  setting print area size in paper.
 *  打印纸张范围大小
 */
- (void)setPrintAreaSizeWithWidth:(NSInteger)label_width
                           Height:(NSInteger)label_height;

/**
 *  setting gap distance during labels.
 *  设置标签纸的间距
 *
 *  @param distance 两张标签紙中间的垂直距离
 *  @param offset   垂直间距的偏移
 */
- (void)setGapWithDistance:(NSInteger)distance
                    Offset:(NSInteger)offset;

/**
 *  setting black line
 *  设置黑线
 *
 *  @param height 黑线的高度 0~25.4 mm
 *  @param offset 黑线偏移量 0~label length
 *  height,offset 为0,0表示连续标签
 */
- (void)setBlineWithHeight:(NSInteger)height
                    Offset:(NSInteger)offset;

/**
 *  paper feed with distance.
 *  走纸
 */
- (void)setOffsetWithDistance:(NSInteger)distance;

/**
 *  setting print sets and copies.
 *  打印数量
 *
 *  @param sets   多少份       how many sets of labels will be printed.
 *  @param copies 每份多少张    how many copies should be printed for each particular label set.
 */
- (void)printWithSets:(NSInteger)sets  Copies:(NSInteger)copies;

/**
 *  print text.
 *  打印文本， 已废弃
 */
- (void)printTextWithXPos:(NSInteger)x_pos
                     YPos:(NSInteger)y_pos
                     Font:(NSString *)font
                 Rotation:(NSInteger)rotation
          XMultiplication:(NSInteger)x_multiplication
          YMultiplication:(NSInteger)y_multiplication
                     Text:(NSString *)text;

/**
 *  打印文本
 *  Print text
 *
 *  @param x_pos    x 坐标
 *  @param y_pos    y 坐标
 *  @param fontSize 字体大小（16 20 24 28 32 40 48 56）
 *  @param rotation （0 1 2 3）
 *  @param text     要打印的文本
 */
- (void)appendTextWithXPos:(NSInteger)x_pos
                      YPos:(NSInteger)y_pos
                  FontSize:(NSInteger)fontSize
                  Rotation:(NSInteger)rotation
                      Text:(NSString *)text;

/**
 *  clean printer buffer.
 *  清除打印机缓冲区
 */
- (void)setCLS;

/**
 *  print barcode.
 *  打印一维条码
 *
 *  @param type     bar code type @[128,128M,EAN128,25,25C,39,29S,93,EAN13,EAN13+2,EAN13+5,EAN8,EAN8+5,CODA,POST,UPCA,UPCA+2,UPCA+5,UPCE,UPCE+2,UPCE+5,CPOST,MSI,MSIC,PLESSEY,ITF14,EAN14,11];
 *  @param readable 是否可读：0，不可读，1，可读 whether it is readable：0: unreadable; 1: readable
 *  @param rotation rotation：0，90，180，270
 *  @param narrow   窄元素 narrow element
 *  @param wide     宽元素 wide element
 */
- (void)printBarcodeWithXPos:(NSInteger)x_pos
                        YPos:(NSInteger)y_pos
                        Type:(NSString *)type
                      Height:(NSInteger)height
               HumanReadable:(NSInteger)readable
                    Rotation:(NSInteger)rotation
                      Narrow:(NSInteger)narrow
                        Wide:(NSInteger)wide
                  CodeNumber:(NSString *)codeNumber;

/**
 *  print QRCode
 *  打印二维条码
 */
- (void)printQRcodeWithXPos:(NSInteger)x_pos
                       YPos:(NSInteger)y_pos
                   EccLevel:(NSString *)ecc_level
                  CellWidth:(NSInteger)width
                       Mode:(NSString *)mode
                   Rotation:(NSInteger)rotation
                      Model:(NSString *)model
                       Mask:(NSString *)mask
                       Text:(NSString *)text;

/**
 *  print Bitmap
 *  打印位图
 *
 *  @param imageData   Bitmap data
 *  @param mode   位图模式：（0:OVERWRITE 1:OR 2:XOR）
 */
- (void)addBitmapWithXPos:(NSInteger)xpos
                     YPos:(NSInteger)ypos
                    width:(NSInteger)width
                   height:(NSInteger)height
                     Mode:(NSInteger)mode
                imageData:(NSData *)imageData;

#pragma mark BasicSetting 基本设定

/**
 *  setting print speed
 *  设置打印速度
 *
 */
- (void)setSpeed:(NSInteger)speed;

/**
 *  setting print density
 *  设置打印浓度
 *
 *  @param density 浓度 0~15 level
 */
- (void)setDensity:(NSInteger)density;

/**
 *  setting print direction and mirror.
 *  设置打印的方向和镜像
 *
 *  @param direction 方向，面对打印机，向自己方向出纸，0，左上角，1，右下角
 *  @param mirror    镜像，可选项 0 普通，1 镜像
 */
- (void)setDirection:(NSInteger)direction Mirror:(NSInteger)mirror;

/**
 *  setting print reference position
 *  设置标签参考起点
 *
 */
- (void)setReferenceXPos:(NSInteger)x_pos
                    YPos:(NSInteger)y_pos;

/**
 *  page 18.
 *  setting the code page of inernational character set.设置国际字符集
 7-bit code page name:
 USA: USA
 BRI: British
 GER: German
 FRE: French
 DAN: Danish
 ITA: Italian
 SPA: Spanish
 SWE: Swedish
 SWI: Swiss
 
 8-bit code page number:
 437: United States
 850: Multilingual
 852: Slavic
 860: Portuguese
 863: Canadian/French
 865: Nordic
 857: Turkish (TSPL2 printers only)
 
 Windows code page:
 1250: Central Europe (TSPL2 printers only)
 1252: Latin I (TSPL2 printers only)
 1253: Greek (TSPL2 printers only)
 1254: Turkish (TSPL2 printers only)
 *
 *  @param codepage 字符集代码
 */
- (void)setCodePage:(NSString *)codepage;

/**
 *  page 21.
 *  feed label with the specified length.设置标签进纸长度
 *
 *  @param feedLength (1~9999)
 */
- (void)setFeedLength:(NSInteger)feedLength;

/**
 *  feed label to the beginning of next label.设置进纸到下一标签起始处
 */
- (void)setFormFeed;

/** 回纸 */
- (void)setBackFeed:(NSInteger)distance;
- (void)setBackUP:(NSInteger)distance;

/**
 *  page 25.
 *  feed label until the internal sensor has determined the origin.设置标签定位到内部传感器确定的起点
 */
- (void)setHome;

/**
 *  page 28.
 *  control the sound frequency of the beeper.设置蜂鸣
 *
 *  @param level    0-9
 *  @param interval 1-4095
 */
- (void)setSoundWithLevel:(NSInteger)level
                 Interval:(NSInteger)interval;

/**
 *  page 29.
 *  activate the cutter to immediately cut the labels without back feeding the label.设置切纸
 */
- (void)setCut;

/**
 *  page 30.
 *  设置停止送纸
 */
- (void)setLimitFeed:(NSInteger)max_len;

/**
 *  page 32.
 *  draw a bar on the label format.在标签上画一条线
 */
- (void)printBarWithXPos:(NSInteger)x_pos
                    YPos:(NSInteger)y_pos
                   Width:(NSInteger)width
                  Height:(NSInteger)height;

/**
 *  page 39.
 *  draw rectangles on the label.在标签上绘制矩形
 *  @param thickness 线宽
 */
- (void)setBoxWithXStart:(NSInteger)x_start
                  YStart:(NSInteger)y_start
                    XEnd:(NSInteger)x_end
                    YEnd:(NSInteger)y_end
               Thickness:(NSInteger)thickness;

/** 在标签上绘制椭圆 */
- (void)setEllipseWithXStart:(NSInteger)x_start
                      YStart:(NSInteger)y_start
                       Width:(NSInteger)width
                      Height:(NSInteger)height
                   Thickness:(NSInteger)thickness;

/**
 *  page 41.
 *  draw a circle on the label.在标签上绘制圆形
 *
 *  @param diameter  直径
 *  @param thickness 线宽
 */
- (void)setCircleWithXStart:(NSInteger)x_start
                     YStart:(NSInteger)y_start
                   Diameter:(NSInteger)diameter
                  Thickness:(NSInteger)thickness;

/**
 *  page 43.
 *  clear a specified region in the image buffer.擦除图像缓冲区指定的区域
 */
- (void)setEraseWithXStart:(NSInteger)x_start
                    YStart:(NSInteger)y_start
                    XWidth:(NSInteger)x_width
                   YHeight:(NSInteger)y_height;

/**
 *  page 42.
 *  define the DataMatrix 2D bar code.Currently,only ECC200 error correction is supported.
 *  设置 DataMatrix 二维码，当前仅支持 ECC200 错误纠正
 *
 *  @param xm         [可选]，Module size，x6，x8
 *  @param row        [可选]，范围：10-144
 *  @param col        [可选]，范围：10-144
 *  @param expression 表达式
 */
- (void)setDmatrixWithExpression:(NSString *)expression
                            XPos:(NSInteger)x_pos
                            YPos:(NSInteger)y_pos
                           Width:(NSInteger)width
                          Height:(NSInteger)height
                              XM:(NSString *)xm
                             Row:(NSString *)row
                             Col:(NSString *)col;

/**
 *  page 44.
 *  define a 2D Maxicode.打印 Maxicode 二维码
 *
 *  @param mode    2,3,4,5
 *  @param iClass   [option],Class of Service ,3-digit number(for mode 2,3)
 *  @param country [option],Country code, 3-digit number (for mode 2,3)
 *  @param post    [option],
 Mode 2: (USA) 5-digit+ 4-digit number.
 Mode 3: (Canada) 6 alphanumeric post code included by double quotes.
 *  @param lm      Expression length (double quote is ignored) , 范围：1-138, (this parameter is just for mode 4 and 5.)
 */
- (void)setMaxicode:(NSString *)text
               XPos:(NSInteger)x_pos
               YPos:(NSInteger)y_pos
               Mode:(NSInteger)mode
              Class:(NSInteger)iClass
            Country:(NSInteger)country
               Post:(NSString *)post
                 LM:(NSInteger)lm;

/**
 *
 *  page 46.
 *  define a PDF417 2D barcode.
 
 [Option]
 
 P  Data compression method
 0: Auto encoding
 1: Binary mode
 
 E  Error correction level. Range: 0~8 Center pattern in barcode area
 0: The pattern will print upper left justified the area
 1: The pattern is printed middle of area
 
 Ux,y,c Human readable
 x: Human readable characters in the specified x-coordinate
 y: Human readable characters in the specified y-coordinate
 c: Maximum characters of human readable character per line
 
 W  Module width in dot. Range: 2~9
 H  Bar height in dot. Range: 4~99
 R  Maximum number of rows
 C  Maximum number of columns
 T  Truncation.
 0: Not truncated
 1: Truncated
 
 *  @param option 可选项
 */
- (void)printPDF417WithXPos:(NSInteger)x_pos
                       YPos:(NSInteger)y_pos
                      Width:(NSInteger)width
                     Height:(NSInteger)height
                     Rotate:(NSInteger)rotate
                     Option:(NSString *)option
                 Expression:(NSString *)expression;

/** page 50 */
- (void)printAztecWithXPos:(NSInteger)XPos
                      YPos:(NSInteger)YPos
                    rotate:(NSInteger)rotate
                      size:(NSInteger)size
                       ecp:(NSInteger)ecp
                       flg:(NSInteger)flg
                      menu:(NSInteger)menu
                     multi:(NSInteger)multi
                       rev:(NSInteger)rev
                 aztecData:(NSString *)aztecData;

/**
 *  page 52.
 *  print Bitmap format image.
 */
- (void)putBMPWithFilename:(NSString *)filename
                      XPos:(NSInteger)x_pos
                      YPos:(NSInteger)y_pos;

/**
 *  page 54.
 *  print PCX format images.
 */
- (void)putPCXWithFilename:(NSString *)filename
                      XPos:(NSInteger)x_pos
                      YPos:(NSInteger)y_pos;

/**
 *  page 63.
 *  reverse a region in image buffer.
 */
- (void)setReverseWithXStart:(NSInteger)x_start
                      YStart:(NSInteger)y_start
                      XWidth:(NSInteger)x_width
                     YHeight:(NSInteger)y_height;

- (void)getStatus;

#pragma mark Device Reconfiguration Commands

/**
 *  page 32.
 *  setting the counter number in the program and its increments.计数器设置
 *
 *  @param counterNumber 第几个计数器 which number of counter（0-50）
 *  @param step          计数间隔 counting interval    （-99999999 ~ 99999999）
 */
- (void)setCounterWithCounterNumber:(NSInteger)counterNumber
                               Step:(NSInteger)step;

- (void)setCutterON;
- (void)setCutterOFF;
- (void)setCutterBATCH;

/**
 *  set number of printing labels per cut
 *
 *  @param pieces (0 ~ 65535)
 */
- (void)setCutterPieces:(NSInteger)pieces;

- (void)setPARTIAL_CUTTER_OFF;
- (void)setPARTIAL_CUTTER_BATCH;

/**
 *  set number of printing labels per cut
 *
 *  @param pieces (0 ~ 65535)
 */
- (void)setPARTIAL_CUTTER_Pieces:(NSInteger)pieces;

- (void)setBackOFF;
- (void)setBackON;

/**
 *  This setting is used to enable/disable the KEY1/KEY2/KEY3 function.
 *
 *  @param index    KEY1,KEY2,KEY3
 *  @param switcher ON/OFF
 */
- (void)setKEY:(NSInteger)index Switch:(NSString *)switcher;

/**
 *  This setting is used to enable/disable the LED function.
 LED1 Power on/off
 LED2 Printer on-line/off-line
 LED3 Error/normal
 *
 *  @param index    LED1,LED2,LED3
 *  @param switcher ON/OFF
 */
- (void)setLED:(NSInteger)index Switch:(NSString *)switcher;

- (void)setPeelON;
- (void)setPeelOFF;

/**
 *  This command is used to enable/disable feeding of labels to gap/black mark position for tearing off.
 *  This setting will be saved in printer memory when turning off the power.
 */
- (void)setTearON;
- (void)setTearOFF;

- (void)setStriperON;
- (void)setStriperOFF;

/**
 *  This setting is used to enable/disable head open sensor.
 */
- (void)setHeadON;
- (void)setHeadOFF;

- (void)setRibbonON;
- (void)setRibbonOFF;

/**
 *  This setting defines communication parameters for printer serial port.
 *
 *  @param baud   24,48,96,19,38,57,115( 对应单位2400 bps,4800 bps,9600 bps,38400 bps,15200 bps)
 *  @param parity N,E,O(NO/Even/Odd parity check)
 *  @param data   7,8(bits Data)
 *  @param stop   1,2(stop bit)
 */
- (void)setCOM1WithBaud:(NSInteger)baud
                 Parity:(NSString *)parity
                   Data:(NSString *)data
                   Stop:(NSString *)stop;

/**
 *  This command will print one label and feed label gap to tear br position for tearing away.
 *  This setting will be saved in printer memory.
 *
 *  @param key OFF/ON/AUTO/<num>
 */
- (void)setPrintKey:(NSString *)key;

- (void)setReprintON;
- (void)setReprintOFF;

@end
