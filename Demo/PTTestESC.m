//
//  PTTestPrint.m
//
//  Created by midmirror on 15/12/18.
//  Copyright © 2015年 midmirror. All rights reserved.
//

#import "PTTestESC.h"
#import <PrinterSDK/PrinterSDK.h>
//#import "iOSPrinterDemo-Swift.h"
//#import "NSData+CommandConvert.h"
#import "HexData.h"
#import "PTScaleImage.h"
//#import "PrinterSDK.framework/PrinterSDK/p"

#define C_SET_BITMAP_MODE(n1,n2) [NSString stringWithFormat:@"ESC '*' '!' %d %d", (n1), (n2)];

@interface PTTestESC ()

@property(strong,nonatomic,readwrite) NSMutableArray *cmdQueue;

@property(strong,nonatomic,readwrite) NSMutableString *mutableStr;

@property(strong,nonatomic,readwrite) NSMutableData *mutableData;

@end

@implementation PTTestESC

//test BLE max bytes
- (void)testPrintMaxByte:(int)number
{
    char data[number];
    for (int i=0; i<number; i++) {
        int remainder = i%26;
        data[i] = (char)('A' + remainder);
    }
    NSString *letterString = [[NSString alloc] initWithBytes:data length:number encoding:NSUTF8StringEncoding];
    
    NSData *textData = [letterString dataUsingEncoding:NSUTF8StringEncoding];
    Byte byte[] = {0x0a};
    NSMutableData *textMutableData = [[NSMutableData alloc] initWithData:textData];
    [textMutableData appendBytes:byte length:1];
    
    NSLog(@"sendData.length:%lu",(unsigned long)textMutableData.length);
    
   // [PrinterPort sendWithData:textMutableData];
}

- (NSString *)getCurrentTime:(NSString *)title
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:nowDate];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@",title,currentTime];
    
    return timeString;
    
}

- (void)printEnglishText
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd appendText:@"7.3 beta 3 adds interactive iOS and OS X playgrounds that allow you to click, drag, type, and otherwise interact with the user interfaces you code into your playground. These interfaces react just as they would within a full application. Interactive playgrounds help you to quickly prototype and build your applications, and simply provide another great way to interact with your code.\n\n" mode:ESCTextNormal];
    [cmd appendText:@"Any view or view controller that is assigned to the" mode:ESCTextNormal];
    [cmd appendText:@"liveView(Underline) " mode:ESCTextUnderline];
    [cmd appendText:@"property of the " mode:ESCTextNormal];
    [cmd appendText:@"XCPlaygroundPage(Double Width) " mode:ESCTextDoubleWidth];
    [cmd appendText:@"is automatically made interactive, and since it runs within a playground you get all the usual playground results. You can experiment with gesture recognizers, see how" mode:ESCTextNormal];
    [cmd appendText:@"UITableView(Double Height) " mode:ESCTextDoubleHeight];
    [cmd appendText:@"creates and dequeues cells as you scroll, or interact with a complex 3D scene 汉印 in SceneKit.\n" mode:ESCTextNormal];
    
   // [PrinterPort sendWithData:[cmd getCommandData]];
    
}

- (void)printSimplifiedChineseText
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd appendText:@"人与人的差距根本不在智商，而是在思维的高度上。整天纠缠于鸡毛蒜皮，就会忽略那些大的人生命题。决定人生上限的，往往不是能力，而是做人做事的格局。视野多高，就会获得什么层次的回报。 格局，注定结局" mode:ESCTextNormal];
    [cmd appendText:@"没有特别说明的时，若是打印机中文，一般指的是简体中文" mode:ESCTextUnderline];
    [cmd appendText:@"不想做的事情一开始就要拒绝。如果一开始没有拒绝，后来就难了。人总是试图保持在别人心目中的一致形象。我们承诺过的事情，总会尽力去完成，不然就会产生心理压力，失信于人。正所谓轻诺者寡信。所以不想做的事情，一定从一开始就拒绝，不喝酒就一口都别喝。" mode:ESCTextDoubleWidth];
    [cmd appendText:@"在迷惑的时候，往往有许多心结缠着，这通常是由于自己钻牛角尖，一意孤行，听不进人家的逆耳忠言所致。不改变这种思维，只会越来越糟。所以，永远都不要太自以为是，不要太习惯于自己的想法，太习惯于当然的结论。所谓“穷则通，通则变”，思维一换，往往“柳暗花明又一村”" mode:ESCTextDoubleHeight];
    //[PrinterPort sendWithData:[cmd getCommandData]];
}

- (void)printBarcode
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    //    [cmd transmitPaperSonsorStatus];
    //    [cmd setPageMode];
    [cmd appendBarcode:ESCBarcodeB_UPCA data:@"075678164125" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_UPCE data:@"01227000009" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_EAN13 data:@"6901028075831" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_EAN8 data:@"04210009" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_CODE39 data:@"123456789" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_ITF data:@"123456789012" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_CODEBAR data:@"A40156B" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_CODE93 data:@"TEST93" justification:0 width:2 height:40 hri:2];
    [cmd appendBarcode:ESCBarcodeB_CODE128 data:@"{BS/N:{C14427016A" justification:0 width:2 height:40 hri:2];
    
    //[PrinterPort sendWithData:[cmd getCommandData]];
}

- (void)printBitmap
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    //初始化打印机
    [cmd initializePrinter];
    
    //设置对齐方式
    [cmd setJustification:0];
    
    UIImage *logoImage = [UIImage imageNamed:@"hy1-text.png"];
    
    [cmd appendRasterImage:logoImage.CGImage mode:PTBitmapModeDithering compress:PTBitmapCompressModeNone];
    
    [cmd printAndReturnStandardMode];
    
    //[PrinterPort sendWithData:[cmd getCommandData]];
    
    
}


- (void)printBarcode2D
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd appendMaxiCodeData:@"Maxicode" mode:50];
    [cmd appendPDF417Data:@"PDF417" row:3 column:15 width:2 rowHeight:6 eccMode:48 eccLevel:48 option:0];
    //    [cmd setPageMode];
    //    [cmd appendLineWithXPos:20 yPos:20 xEnd:50 yEnd:50 mode:2];
    //    [cmd appendRectWithXPos:30 yPos:30 xEnd:60 yEnd:60 mode:2];
    //    [cmd setStandardMode];
    
    //[PrinterPort sendWithData:[cmd getCommandData]];
}

- (void)printReceipt2
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd appendCommandData:[PTEncode encodeDataWithString:@"We met at the wrong time, but separated at the right time. The most urgent is to take the most beautiful scenery; the deepest wound was the most real emotions." encodingType:kCFStringEncodingBig5]];
    [cmd setHorizontalTab];
    [cmd appendCommandData:[PTEncode encodeDataWithString:@"123456\r\n" encodingType:kCFStringEncodingGB_18030_2000]];
    
    [cmd appendCommandData:[PTEncode encodeDataWithString:@"Lance" encodingType:kCFStringEncodingGB_18030_2000]];
    [cmd setHorizontalTab];
    [cmd setHorizontalTab];
    [cmd setHorizontalTab];
    [cmd appendCommandData:[PTEncode encodeDataWithString:@"123456\r\n" encodingType:kCFStringEncodingGB_18030_2000]];
    //[PrinterPort sendWithData:[cmd getCommandData]];
}

- (void)printReceipt3
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    
    //初始化打印机
    [cmd initializePrinter];
    //设置对齐方式
    [cmd setJustification:10];
    //设置行距
    //    [cmd setLineSpacing:10];
    //    UIImage *logoImage= [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/logo_sto" ofType:@"png"]];
    UIImage *logoImage = [UIImage imageNamed:@"hy1-text.png"];
    //    //打印像素图位图
    [cmd appendRasterImage:logoImage.CGImage mode:PTBitmapModeDithering compress:PTBitmapCompressModeLZO];
    //获得所有指令拼接数据
    NSData *sendData = [cmd getCommandData];
    //发送打印数据
   // [PrinterPort sendWithData:sendData];
}

- (NSData *)printElectronicSheet
{
    
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd appendText:@"LWCH PRINTER\n\n" mode:ESCTextDoubleWidth];
    
    NSMutableString *companyMessage = [[NSMutableString alloc] init];
    [companyMessage appendString:@"2F,8#,Gaoqi Nan Shi'er Road\n"];
    [companyMessage appendString:@"(Aide Industiral Park)\n"];
    [companyMessage appendString:@"Xiamen,China 361006\n\n"];
    [companyMessage appendString:@"Tel:+(86)-(0)592-5885993,5756958\n"];
    [companyMessage appendString:@"Website:http://www.baidu.com\n"];
    [companyMessage appendString:@"Website:http://www.baidu.com\n\n"];
    
    [cmd appendText:companyMessage mode:ESCTextNormal];
    
    NSMutableString *receiptText = [[NSMutableString alloc] init];
    [receiptText appendString:@"------------------------------\n"];
    [receiptText appendString:@"           NO.1008            \n"];
    [receiptText appendString:[self getCurrentTime:@"Time"]];
    [receiptText appendString:@"\n"];
    [receiptText appendString:@"------------------------------\n"];
    [receiptText appendString:@"MPT-II          1      $700.00\n"];
    [receiptText appendString:@"MPT-III         1      $700.00\n"];
    [receiptText appendString:@"LPQ58           1      $800.00\n"];
    [receiptText appendString:@"BLE1            1      $800.00\n"];
    [receiptText appendString:@"BLE123          1      $900.00\n"];
    [receiptText appendString:@"POS80A          1      $900.00\n"];
    [receiptText appendString:@"POS80B          1      $950.00\n"];
    [receiptText appendString:@"POS80C          1      $950.00\n"];
    [receiptText appendString:@"SMP-R381        1      $850.00\n"];
    [receiptText appendString:@"SMP-R385        1      $850.00\n"];
    [receiptText appendString:@"SMP-R386        1      $850.00\n"];
    [receiptText appendString:@"MPT-II          1      $700.00\n"];
    [receiptText appendString:@"MPT-III         1      $700.00\n"];
    [receiptText appendString:@"LPQ58           1      $800.00\n"];
    [receiptText appendString:@"BLE-14          1      $800.00\n"];
    [receiptText appendString:@"BLE-23          1      $900.00\n"];
    [receiptText appendString:@"POS80A          1      $900.00\n"];
    [receiptText appendString:@"POS80B          1      $950.00\n"];
    [receiptText appendString:@"POS80C          1      $950.00\n"];
    [receiptText appendString:@"SMP-R381        1      $850.00\n"];
    [receiptText appendString:@"SMP-R385        1      $850.00\n"];
    [receiptText appendString:@"SMP-R386        1      $850.00\n"];
    [receiptText appendString:@"------------------------------\n\n"];
    [receiptText appendString:@"Total                $18500.00\n"];
    [receiptText appendString:@"-------------------------------\n\n"];
    
    [cmd appendText:receiptText mode:ESCTextNormal];
    
    int barcodeType         = 0;
    int barcodeAligment     = 0;
    int barcodeNumberAround = 2;
    int barcodeWidth        = 3;
    int barcodeHeight       = 30;
    
    [cmd appendBarcode:barcodeType data:@"075678164125" justification:barcodeAligment width:barcodeWidth height:barcodeHeight hri:barcodeNumberAround];
    [cmd appendQRCodeData:@"Hello World" justification:0 leftMargin:0 eccLevel:48 model:50 size:10];
    
    [cmd escRequestTransmissionOfResponseOrStatus];
    NSMutableString *copyright = [[NSMutableString alloc] init];
    [copyright appendString:[self getCurrentTime:@"Time"]];
    [copyright appendString:@"\n"];
    [copyright appendString:@"WirelessPrinter: V1.4.0\n"];
    [copyright appendString:@"Copyright 2016 WirelessPrinter.\n"];
    [copyright appendFormat:@" All rights reserved\n\n\n\n"];
    [cmd appendText:copyright mode:ESCTextNormal];
    return [cmd getCommandData];
   // [PrinterPort sendWithData:[cmd getCommandData]];
}


- (void)printQRcode
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    // 进入页模式，打印两条并排二维码
    [cmd transmitPaperSonsorStatus];
    [cmd initializePrinter];
    [cmd setPageMode];
    [cmd pageSetPrintAreaWithXPos:0 yPos:0 width:300 height:350];
    
    [cmd pageSetPrintDirection:0];
    [cmd setAbsolutePosition:10];
    [cmd pageSetAbsoluteYPos:10];
    [cmd appendQRCodeData:@"hello world" justification:0 leftMargin:10 eccLevel:48 model:49 size:5];
    
    [cmd pageSetPrintDirection:0];
    [cmd setAbsolutePosition:140];
    [cmd pageSetAbsoluteYPos:10];
    [cmd appendQRCodeData:@"hello world" justification:0 leftMargin:100 eccLevel:48 model:49 size:5];
    
    [cmd printAndReturnStandardMode];
    [cmd cancelPrint];
    
   // [PrinterPort sendWithData:[cmd getCommandData]];
}

- (NSData *)textJustifiatopn {
     PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    [cmd setJustification:0];
    [cmd appendText:@"做壹個真實的自己，把壹顆凡俗的心，安置在最簡單的欲望裏，壹粥壹飯，壹茶壹水。假設，人生如戲全靠演技，那就別為了那些不屬於妳的觀眾，去演繹不擅長的人生。美好壹天從做真實的自己開始" mode:ESCTextNormal];
    [cmd setJustification:1];
    [cmd appendText:@"居中对齐" mode:ESCTextNormal];
    [cmd setJustification:2];
    [cmd appendText:@"做壹個真實的自己，把壹顆凡俗的心，安置在最簡單的欲望裏，壹粥壹飯，壹茶壹水。假設，人生如戲全靠演技，那就別為了那些不屬於妳的觀眾，去演繹不擅長的人生。美好壹天從做真實的自己開始" mode:ESCTextNormal];
    [cmd printAndFeedLines:3];
    return cmd.getCommandData;
}
- (void)printTraditionalModeCode
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    //cmd setJustification:<#(NSInteger)#>
    cmd.encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
    [cmd appendText:@"中國輸入測識" mode:ESCTextBold];
    [cmd appendText:@"做壹個真實的自己，把壹顆凡俗的心，安置在最簡單的欲望裏，壹粥壹飯，壹茶壹水。假設，人生如戲全靠演技，那就別為了那些不屬於妳的觀眾，去演繹不擅長的人生。美好壹天從做真實的自己開始！" mode:ESCTextNormal];
    [cmd appendText:@"每壹個人都具有特殊能力的電路，但大多數人因為不知道，所以無法充分利用，就好像懷重寶而不知其在；只要能發掘出這項秘藏的能力，人類的能力將會完全大改觀，也能展現出超乎常人的能力" mode:ESCTextDoubleHeight];
    [cmd appendText:@"壹個人的人生幸福，只靠道德方面的努力是不夠的，我們必須經常描繪自己將來的幸福形象，並依靠萬能的潛意識來幫忙實現。潛意識壹旦接受事情後，就會想盡辦法去實現它，之後妳只要安心等待,就可以了" mode:ESCTextDoubleWidth];
    [cmd appendText:@"不應當急於求成，應當去熟悉自己的研究對象，鍥而不舍，時間會成全壹切。凡事開始最難，然而更難的是何以善終" mode:ESCTextUnderline];
    //[PrinterPort sendWithData:[cmd getCommandData]];
    
}

- (void)printJapanText
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    cmd.encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingShiftJIS);
    //    [cmd setKanjiMode];
    //    [cmd setKanjiWithReverse:YES doubleWidth:YES doubleHeight:YES underline:YES];
    [cmd appendText:@"人々の間のギャップは、IQではなく、思考の高さにあります。 一日中絡み合った一日は、その大きな命命題を無視します。 能力の上限ではなく、人生のパターンを決定する。 どのように視野の高さは、どのレベルの戻り値を得るでしょう。 終了する予定のパターン" mode:ESCTextNormal];
    [cmd appendText:@"混乱の時に、頻繁に自分の角のために曲がっている多くの心臓の結び目があり、耳のアドバイスのために人々に耳を傾けないでください。 このような考え方を変えないで、悪化するだけです。 そう、決してあまりにも独善的ではなく、あまりにも自分の考えに慣れていない、もちろん結論に慣れている。 いわゆる 貧乏人のパス、一般的な変化は、変更を考え、しばしば ビスタ" mode:ESCTextNormal];
   // [PrinterPort sendWithData:[cmd getCommandData]];
    
}

- (void)printKoreanText
{
    PTCommandESC *cmd = [[PTCommandESC alloc] init];
    [cmd initializePrinter];
    cmd.encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_KR);
    [cmd appendText:@"혼란의 때, 종종 자신의 뿔로 인해 구부러진, 많은 심장 매듭이 있으며, 귀의 충고로 인해 사람들의 말을 듣지 마십시오. 이런 생각을 바꾸지 마라. 그러므로 너무 독선적 인 사람은 결코 자신의 생각에 너무 익숙하지 않아야합니다. 물론 결론에 너무 익숙해 져야합니다. 소위 빈약 한 패스, 일반적인 변화, 변화를 생각하면서, 종종 비스타" mode:ESCTextNormal];
    [cmd appendText:@"사람들 사이의 격차는 IQ가 아니라 사고의 고비에 있습니다. 사소한 일에 얽혀있는 하루 종일, 그 큰 인생 제안을 무시할 것입니다. 삶의 상 한계를 결정하고, 종종 능력이 아니라 삶의 패턴을 결정하십시오. 시야가 얼마나 높은지, 어떤 수준의 수익을 얻을 것인가. 끝날 운명의 패턴" mode:ESCTextNormal];
    //[PrinterPort sendWithData:[cmd getCommandData]];
}

- (void)drawLineAndRectangle {
    
#pragma mark --这个方法内的所用的字符串均为GB18030编码
    PTCommandESC *cmd = [PTCommandESC new];
    [cmd initializePrinter];
    [cmd setPageMode];
    [cmd pageSetPrintAreaWithXPos:0 yPos:0 width:0x0280 height:0x05a0];
    [cmd pageSetPrintDirection:3];
    
    [cmd setAbsolutePosition:0x016a];
    [cmd pageSetAbsoluteYPos:0x0030];
    [cmd setCharacterSize:0x11];
    [cmd appendCommandData:[HexData dataWithHexString:@"B1 B1 BE A9 BD F5 C2 DA B9 FA BC CA CE EF C1 F7 CD D0 D4 CB B5 A5"]];
    
    [cmd setAbsolutePosition:0x0001];
    [cmd pageSetAbsoluteYPos:0x0048];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"BB F5 BA C5 A3 BA BC C3 C4 CF 31 37 31 31 31 37 2D B1 B1 BE A9 30 30 31 2D 31 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 32 30 31 37 C4 EA 31 31 D4 C2 31 37 C8 D5"]];
    
    [cmd setAbsolutePosition:0x0440];
    [cmd pageSetAbsoluteYPos:0x0048];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"C6 B1 BA C5 A3 BA 31 30 30 35 30 33 34 34 36"]];
    
    [cmd appendRectangleWithLineWidth:0x02 xPos:0 yPos:0x0050 width:0x0500 height:0x01e0];
    [cmd setAbsolutePosition:0x0010];
    [cmd pageSetAbsoluteYPos:0x0078];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"CA D5 20 BB F5 20 C8 CB 20 20 20 20 20 20 32 34 35 20 20 20 20 20 20 20 20 B5 E7 20 BB B0 20 20 20 20 20 20 20 20 20 32 34 35 32 32 34 35 20 20 20 20 20 20 20 20 20 20 20 BB F5 20 C3 FB 20 20 20 20 20 20 20 20 20 20 32 20 20 20 20 20 20 20 20 20 D6 D8 20 C1 BF 20 20 20 20 20 20 20 20 20 20 20 30"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x0080 xEnd:0x0500 yEnd:0x0080];
    [cmd setAbsolutePosition:0x0010];
    [cmd pageSetAbsoluteYPos:0x00a8];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"B7 A2 20 BB F5 20 C8 CB 20 20 20 20 20 20 32 34 35 32 20 20 20 20 20 20 20 B5 E7 20 BB B0 20 20 20 20 20 20 20 20 20 20 34 35 32 34 20 20 20 20 20 20 20 20 20 20 20 20 BC FE 20 CA FD 20 20 20 20 20 20 20 20 20 20 31 20 20 20 20 20 20 20 20 20 20 CC E5 20 BB FD 20 20 20 20 20 20 20 20 20 20 30"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x00b0 xEnd:0x0500 yEnd:0x00b0];
    [cmd setAbsolutePosition:0x0010];
    [cmd pageSetAbsoluteYPos:0x00d8];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"20 CC E1 20 B8 B6 20 20 20 20 CF D6 20 B8 B6 20 20 BB D8 B5 A5 B8 B6 20 20 20 BB F5 BF EE BF DB 20 20 20 B7 B5 20 BF EE 20 20 20 B4 FA CA D5 BB F5 BF EE 20 20 20 20 CA D6 D0 F8 B7 D1 20 20 20 20 20 20 20 D4 CB BB F5 B7 D1 20 20 20 20 20 20 20 B1 A3 BC DB 20 20 20 20 20 20 20 20 20 D6 D0 D7 AA B7 D1"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x00e0 xEnd:0x0500 yEnd:0x00e0];
    [cmd setAbsolutePosition:0x0010];
    [cmd pageSetAbsoluteYPos:0x0108];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"20 20 20 32 20 20 20 20 20 20 20 20 30 20 20 20 20 20 20 30 20 20 20 20 20 20 20 30 20 20 20 20 20 20 20 20 30 20 20 20 20 20 20 20 20 35 20 20 20 20 20 20 20 20 20 20 20 BB D8 A3 BA 31 20 20 20 20 20 20 20 20 20 20 30 20 20 20 20 20 20 20 20 20 20 20 30 20 20 20 20 20 20 20 20 20 20 20 30"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x0110 xEnd:0x0500 yEnd:0x0110];
    [cmd setAbsolutePosition:0x0010];
    [cmd pageSetAbsoluteYPos:0x0138];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"20 BB E1 D4 B1 BA C5 20 20 20 20 20  20 20 20 20 20 20 20 20 20 20 20 20 20 20 D5 CB 20 BA C5 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 B5 BD D5 BE BA CF BC C6 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 37"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x0140 xEnd:0x0500 yEnd:0x0140];
    [cmd setAbsolutePosition:0x0008];
    [cmd pageSetAbsoluteYPos:0x0168];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"CE AF CD D0 B5 A5 BA C5 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 BB D8 B5 A5 D2 AA C7 F3 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 BD BB BB F5 B7 BD CA BD 20 20 20 20 20 20 20 20 20 20 20 20 20 20 D7 D4 CC E1"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x0170 xEnd:0x0500 yEnd:0x0170];
    [cmd setAbsolutePosition:0x0008];
    [cmd pageSetAbsoluteYPos:0x0198];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"CD D0 D4 CB B5 D8 D6 B7 20 20 20 B3 C7 BB B7 B3 C7 A3 BA 20 CE E5 B7 BD A3 BA 20 CE F7 B2 BF A3 BA 20 C9 F1 C1 FA B7 E1 20 20 35 36 32 30 39 36 38 39 2F 38 37 35 36 31 39 30 33 20 20 20 20 20 20 20 20 20 20 BF CD BB A7 C7 A9 C3 FB"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x01a0 xEnd:0x0500 yEnd:0x01a0];
    [cmd setAbsolutePosition:0x0008];
    [cmd pageSetAbsoluteYPos:0x01c8];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"B5 BD BB F5 B5 D8 D6 B7 20 20 20 BC C3 C4 CF CA D0 C0 CF CD CD C6 FB C5 E4 B3 C7 B1 B1 C3 C5 33 23 20 20 30 35 33 31 2D 38 32 35 33 33 38 38 30"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0 yPos:0x01d0 xEnd:0x0500 yEnd:0x01d0];
    [cmd setAbsolutePosition:0x0388];
    [cmd pageSetAbsoluteYPos:0x01f8];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"B1 B8 20 D7 A2"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0x0370 yPos:0x0208 xEnd:0x0500 yEnd:0x0208];
    [cmd setAbsolutePosition:0x0388];
    [cmd pageSetAbsoluteYPos:0x0220];
    [cmd setCharacterSize:0];
    [cmd appendCommandData:[HexData dataWithHexString:@"B2 D9 D7 F7 D4 B1 A3 BA B1 B1 BE A9 31 30 3A 34 30 3A 33 37"]];
    
    [cmd setAbsolutePosition:0x0004];
    [cmd pageSetAbsoluteYPos:0x01f0];
    [cmd setCharacterFont:0x01];
    [cmd appendCommandData:[HexData dataWithHexString:@"CD D0 D4 CB C8 CB D0 EB D6 AA A3 BA"]];
    
    [cmd appendLineWithLineWidth:2 xPos:0x0080 yPos:0x0050 xEnd:0x0080 yEnd:0x01d0];
    [cmd appendLineWithLineWidth:2 xPos:0x00d0 yPos:0x00b0 xEnd:0x00d0 yEnd:0x0110];
    [cmd appendLineWithLineWidth:2 xPos:0x0120 yPos:0x0050 xEnd:0x0120 yEnd:0x0170];
    [cmd appendLineWithLineWidth:2 xPos:0x01a0 yPos:0x0050 xEnd:0x01a0 yEnd:0x0170];
    [cmd appendLineWithLineWidth:2 xPos:0x01f0 yPos:0x00b0 xEnd:0x01f0 yEnd:0x0110];
    [cmd appendLineWithLineWidth:2 xPos:0x0290 yPos:0x0050 xEnd:0x0290 yEnd:0x0110];
    [cmd appendLineWithLineWidth:2 xPos:0x0320 yPos:0x0050 xEnd:0x0320 yEnd:0x01a0];
    [cmd appendLineWithLineWidth:2 xPos:0x03c8 yPos:0x0050 xEnd:0x03c8 yEnd:0x01a0];
    [cmd appendLineWithLineWidth:2 xPos:0x0460 yPos:0x0050 xEnd:0x0460 yEnd:0x0110];
    [cmd appendLineWithLineWidth:2 xPos:0x0370 yPos:0x01d0 xEnd:0x0370 yEnd:0x0230];
    [cmd appendLineWithLineWidth:2 xPos:0x03c8 yPos:0x01d0 xEnd:0x03c8 yEnd:0x0208];
    
    [cmd printAndReturnStandardMode];
    NSData *data = [cmd getCommandData];
    //[PrinterPort sendWithData:data];
}

- (void)printWithTemplate {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/ESC_drawLine" ofType:@"hex"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [HexData dataWithHexString:str];
   // [PrinterPort sendWithData:data];
}




@end








