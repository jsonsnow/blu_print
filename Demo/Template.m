//
//  Template.m
//  BluetoothDemo
//
//  Created by midmirror on 16/10/28.
//  Copyright © 2016年 Mellow. All rights reserved.
//

#import "Template.h"
#import <PrinterSDK/PrinterSDK.h>
#import "PTLabelAppend.h"
#import "PTScaleImage.h"

@implementation Template

+ (NSData *)printZhongJiTemplate_CPCL {
    
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
    
    // 数据绑定
    
//    label.barcode           = @"923487229304192348320394";
//    label.barcode_text      = @"9234 8722 9304 1923 4832 0394";
//    label.sender_name       = @"李三峰";
//    label.sender_phone      = @"15012345678";
//    label.sender_address    = @"湖北省黄冈市黄州区";
//    label.receiver_name     = @"尼古拉斯-赵四";
//    label.receiver_phone    = @"18877773333";
//    label.receiver_address  = @"上海市 青浦区 华徐公路3029";
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"BARCODE"]           = @"923487229304192348320394";
    dict[@"BARCODE_TEXT"]      = @"9234 8722 9304 1923 4832 0394";
    dict[@"SENDER_NAME"]            = @"李三峰";
    dict[@"SENDER_PHONE"]      = @"15012345678";
    dict[@"SENDER_ADDRESS"]    = @"湖北省黄冈市黄州区";
    dict[@"RECEIVER_NAME"]          = @"尼古拉斯-赵四";
    dict[@"RECEIVER_PHONE"]    = @"18877773333";
    dict[@"RECEIVER_ADDRESS"]  = @"上海市 青浦区 华徐公路3029";
    
    // 从服务器获取到新模板后保存到本地，读取为字符串。（要注意文本的编码类型，建议保存为无 BOM 的 UTF-8）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/CPCL_ZhongJi" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *order1 = @"女士鞋子(36码) 数量:3";
    NSString *order2 = @"女士鞋子(36码) 数量:3";
    NSString *order3 = @"女士鞋子(36码) 数量:3";
    NSString *order4 = @"女士鞋子(36码) 数量:3";
    NSString *order5 = @"女士鞋子(36码) 数量:3";
    // 结合模板和绑定的数据。生成打印数据发送打印机, Json 数据可以传 Dictionary 进去，字典中的 key 必须和模板中的 key 一致
    NSData *data = [label getTemplateData:source labelDict:dict orderDetails:@[order1,order2,order3,order4,order5]];
    
    return data;
}



+ (NSData *)printZhongJiTemplate_TSPL {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/TSPL_ZhongJi" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
//    label.collection        = @"25 元";
//    label.code_number       = @"021D-123-789";
//    label.barcode           = @"AFC7150124715012424";
//    label.distributing      = @"黑龙江齐齐哈尔集散";
//    label.receiver          = @"齐齐哈尔木鱼";
//    label.receiver_contact  = @"15605883677 0571-53992320";
//    label.receiver_address  = @"黑龙江齐齐哈尔市建华区文化大街42号齐齐哈尔大学计算机工程学院001班";
//    label.sender            = @"浙江杭州行者";
//    label.sender_contact    = @"18000989090 0571-53992320";
//    label.sender_address    = @"浙江省杭州市余杭区文一西路1001号阿里巴巴淘宝城5号办公楼5号小邮局";
//    label.qrcode            = @"扫码有惊喜";
//    label.qrcode_text       = @"扫码有惊喜";
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"number"]             = @"021D-123-789";
    dict[@"barcode"]            = @"AFC7150124715012424";
    dict[@"receiver_name"]      = @"齐齐哈尔木鱼";
    dict[@"receiver_phone"]     = @"15605883677 0571-53992320";
    dict[@"receiver_address"]   = @"黑龙江齐齐哈尔市建华区文化大街42号齐齐哈尔大学计算机工程学院001班";
    dict[@"sender_name"]        = @"浙江杭州行者";
    dict[@"sender_phone"]       = @"18000989090 0571-53992320";
    dict[@"sender_address"]     = @"浙江省杭州市余杭区文一西路1001号阿里巴巴淘宝城5号办公楼5号小邮局";
    dict[@"Orderdetails1"]      = @"我是厦门高崎路飞机场金砖回忆";
    dict[@"Orderdetails2"]      = @"Orderdetails2";
    dict[@"Orderdetails3"]      = @"Orderdetails3";
    
    NSMutableData *muData = [[NSMutableData alloc] init];
    [muData appendData:[label getTemplateData:source labelDict:dict]];
    
    UIImage *logo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/LOGO" ofType:@"png"]];
    
    PTCommandTSPL *cmd = [[PTCommandTSPL alloc] init];
    NSData *logoData = [PTBitmap getImageData:logo.CGImage mode:PTBitmapModeBinary compress:PTBitmapCompressModeNone];

    NSData *logoNagativeData = [PTBitmap negativeData:logoData];

    [cmd addBitmapWithXPos:400 YPos:32 width:logo.size.width height:logo.size.height Mode:1 imageData:logoNagativeData];
    [cmd addBitmapWithXPos:300 YPos:824 width:logo.size.width height:logo.size.height Mode:1 imageData:logoNagativeData];
    [cmd printWithSets:1 Copies:1];
    
    [muData appendData:cmd.cmdData];
   // NSString *text = [[NSString alloc] initWithData:muData encoding:];
    return muData;
}

+ (NSData *)printTianTianTemplate {
    
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"Referred"]               = @"蒙 锡林郭勒盟";
    dict[@"City"]                   = @"锡林郭勒盟 包";
    dict[@"Receiver"]               = @"瑜州";
    dict[@"Receiver_Phone"]         = @"15182429075";
    dict[@"Receiver_address1"]      = @"内蒙古自治区 锡林郭勒盟 正黄旗 解放东路与";
    dict[@"Receiver_address2"]      = @"外滩路交叉口62好静安中学静安小区10栋2单元";
    dict[@"Receiver_address3"]      = @"1706室";
    
    dict[@"Sender"]                 = @"尼古拉斯-赵四";
    dict[@"Sender_Phone"]           = @"18877773333";
    dict[@"Sender_address1"]        = @"浙江省 杭州市 滨江区 斌南路1505号1706室信息部，斌南路15";
    dict[@"Sender_address2"]        = @"05号1706室信息部，好1706室信息部";
    
    dict[@"Barcode"]                = @"998016450402";
    
    dict[@"Waybill"]                = @"998016450402";
    dict[@"Product_types"]          = @"数码产品";
    dict[@"Quantity"]               = @"22";
    dict[@"Weight"]                 = @"22.66kG";
    
    // 从服务器获取到新模板后保存到本地，读取为字符串。（要注意文本的编码类型，建议保存为无 BOM 的 UTF-8）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/CPCL_TianTian" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [label getTemplateData:source labelDict:dict];
    data = [label dataWithTSPL];
    return data;
}

+ (NSData *)printShenTongTemplate {
    
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"barcode"] = @"363604310467";
    dict[@"distributing"] = @"上海 上海市 长宁区";
    
    dict[@"receiver_name"] = @"申大通";
    dict[@"receiver_phone"] = @"13826514987";
    dict[@"receiver_address1"] = @"上海市宝山区共和新路4719弄共";
    dict[@"receiver_address2"] = @"和小区12号306室";
    
    dict[@"sender_name"] = @"快小宝";
    dict[@"sender_phone"] = @"13826514987";
    dict[@"sender_address1"] = @"上海市长宁区北瞿路1178号（鑫达商务楼）";
    dict[@"sender_address2"] = @"1号楼305室";
    
    // 从服务器获取到新模板后保存到本地，读取为字符串。（要注意文本的编码类型，建议保存为无 BOM 的 UTF-8）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/CPCL_ShenTong" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [label getTemplateData:source labelDict:dict];
    
    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];
    UIImage *logo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/logo_sto" ofType:@"png"]];
//        UIImage *scaleLogo = [PTScaleImage scaleSourceImage:logo maxWidth:100];
    NSData *bmpData = [PTBitmap getImageData:logo.CGImage mode:PTBitmapModeBinary compress:PTBitmapCompressModeNone];
    [cmd cpclCompressedGraphicsWithImageWidth:logo.size.width imageHeight:logo.size.height x:10 y:10 bitmapData:bmpData];
    [cmd cpclCompressedGraphicsWithImageWidth:logo.size.width imageHeight:logo.size.height x:10 y:706 bitmapData:bmpData];
    [cmd cpclCompressedGraphicsWithImageWidth:logo.size.width imageHeight:logo.size.height x:10 y:1010 bitmapData:bmpData];
    [cmd cpclPrint];

    NSMutableData *finalData = [[NSMutableData alloc] init];
    [finalData appendData:data];
    [finalData appendData:cmd.cmdData];
    
    return finalData;
}

+ (NSData *)printKuaiDaTemplate_CPCL {
    /**
     对于模板来说，mac下的输入回车键只表示\n,windows下表示\r\n
     \r:表示回车 \n:表示换行，所以需要在后面添加上\r
     */
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"courier_name"] = @"老司机";
    dict[@"print_time"] = @"2018-02-07 17:00";
    dict[@"barcode"] = @"363604310467";
    
    dict[@"receiver_name"] = @"李四";
    dict[@"receiver_phone"] = @"18000000000";
    dict[@"receiver_address1"] = @"上海市宝山区共和新路弄共和新路弄共";
    dict[@"receiver_address2"] = @"上77号山区共和新路弄共和新路弄共";
    
    dict[@"sender_name"] = @"张三";
    dict[@"sender_phone"] = @"18000001111";
    dict[@"sender_address1"] = @"江苏市宝山区共和新路弄共和新路弄共";
    dict[@"sender_address2"] = @"上77号山区共和新路弄共和新路弄共";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/KD_order" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
   
    NSData *data = [label getTemplateData:source labelDict:dict];
    
    
    return data;
}

+ (NSData *)printZhongTongTemplate {
    
    PTLabelAppend *label = [[PTLabelAppend alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"Barcode"] = @"363604310467";
    dict[@"remark"] = @"上海 上海市 长宁区";
    
    dict[@"Receiver"] = @"申大通";
    dict[@"Receiver_Phone"] = @"13826514987";
    dict[@"Receiver_address1"] = @"上海市宝山区共和新路4719弄共";
    dict[@"Receiver_address2"] = @"和小区12号306室";
    
    dict[@"Sender"] = @"快小宝";
    dict[@"Sender_Phone"] = @"13826514987";
    dict[@"Sender_address1"] = @"上海市长宁区北瞿路1178号（鑫达商务楼）";
    dict[@"Sender_address2"] = @"1号楼305室";
    
    PTCommandCPCL *cmd = [[PTCommandCPCL alloc] init];
    [cmd cpclAutoTextWithRotate:0 font:3 fontSize:0 x:0 y:1455 width:112 lineSpacing:4 text:@"哈哈哈哈哈哈哈哈哈付费方法方法方法方法反反"];
    [cmd cpclAutoTextWithRotate:0 font:1 fontSize:20 x:122 y:1465 width:112 lineSpacing:4 text:@"我是厦门金砖会议主持人我方法反反"];
    [cmd cpclAutoTextWithRotate:0 font:1 fontSize:20 x:234 y:1465 width:112 lineSpacing:4 text:@"价格"];
//    [cmd cpclCenterTextWithRotate:0 font:55 fontSize:0 x:122 y:1465 width:112 text:@"我是厦门金砖会议主持人我"];
//    [cmd cpclCenterTextWithRotate:0 font:55 fontSize:2 x:234 y:1465 width:112 text:@"价格"];
    [cmd cpclCenterTextWithRotate:0 font:3 fontSize:0 x:346 y:1465 width:112 text:@"我是中国人"];
    [cmd cpclCenterTextWithRotate:0 font:2 fontSize:10 x:458 y:1465 width:112 text:@"来自厦门"];
    [cmd cpclPrint];
    
    // 从服务器获取到新模板后保存到本地，读取为字符串。（要注意文本的编码类型，建议保存为无 BOM 的 UTF-8）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrinterResource.bundle/CPCL_ZhongTong" ofType:@"txt"];
    NSMutableString *source = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [label getTemplateData:source labelDict:dict];
    
    NSMutableData *finalData = [[NSMutableData alloc] init];
    [finalData appendData:data];
    [finalData appendData:cmd.cmdData];
    
    return finalData;
}

+ (NSData *)printselfTest_TSPL
{
    NSMutableData *muData = [[NSMutableData alloc] init];
    PTCommandTSPL *tsc = [[PTCommandTSPL alloc] init];
    [tsc setPrintAreaSizeWithWidth:100 Height:100];
    [tsc setCLS];
    [tsc appendTextWithXPos:0 YPos:0 FontSize:16 Rotation:0 Text:@"16号字体"];
    [tsc appendTextWithXPos:0 YPos:20 FontSize:20 Rotation:0 Text:@"20号字体"];
    [tsc appendTextWithXPos:0 YPos:40 FontSize:24 Rotation:0 Text:@"24号字体"];
    [tsc appendTextWithXPos:0 YPos:60 FontSize:28 Rotation:0 Text:@"28号字体"];
    [tsc appendTextWithXPos:0 YPos:80 FontSize:32 Rotation:0 Text:@"32号字体"];
    [tsc appendTextWithXPos:0 YPos:120 FontSize:40 Rotation:0 Text:@"40号字体"];
    [tsc appendTextWithXPos:0 YPos:160 FontSize:48 Rotation:0 Text:@"48号字体"];
    [tsc appendTextWithXPos:0 YPos:200 FontSize:56 Rotation:0 Text:@"56号字体"];
    [tsc printWithSets:1 Copies:1];
    
    [muData appendData:tsc.cmdData];
    
    return muData;
}


@end











