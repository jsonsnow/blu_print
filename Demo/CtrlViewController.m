//
//  CtrlViewController.m
//  GSDK
//
//  Created by 猿史森林 on 2018/6/16.
//  Copyright © 2018年 Smarnet. All rights reserved.
//

#import "CtrlViewController.h"
#import "ConnecterManager.h"
#import "EscCommand.h"
#import "TscCommand.h"
#import "BluetoothListViewController.h"
#import "Template.h"
#import <objc/runtime.h>
#import "TscCommand+TSPLCategory.h"
#import "PTTestESC.h"
#import "TscCommand+WGTSPLYunDaCategory.h"
#import "TscCommand+WGTSPLYunDaThreeCategory.h"
#import "Demo-Swift.h"
#import "JSONUtils.h"
#import "WGPrintHeaderFile.h"
#import "HexData.h"

@interface CtrlViewController (){
    BOOL isReceive;
}
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UILabel *connState;
@property (nonatomic, strong) NSDictionary *jsonDict;
@end

@implementation CtrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setTimeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSInteger witdh1 = MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 6);
    NSInteger widht2 = MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 10 + 1);
    NSInteger width3 = MM_TO_DOT(17 + 15 + 10 + 15 + 13 + 22 + 17 + 14 + 1);
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *miniPath = [[NSBundle mainBundle] pathForResource:@"liantu" ofType:@"png"];
    NSData *data = [NSData dataWithContentsOfFile:miniPath];
    NSString *res = [WGPrintDataManager.print convertDataToBase64:data];
   
    //NSLog(@"%@", res);
    //Manager.bleConnecter
}

- (void)parsJsonData {
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    self.jsonDict = [JSONUtils dictWithData:jsonData];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  断开连接
 */
- (IBAction)disconnectAction:(id)sender {
    [Manager close];
}


- (IBAction)hideKeyboardAction:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)bleConnAction:(id)sender {
    BluetoothListViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.state = ^(ConnectState state) {
        [self updateConnectState:state];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)labelPrintAction:(id)sender {
    [Manager write:[self tscCommand]];
}

-(NSData *)tscCommand{
    TscCommand *command = [[TscCommand alloc]init];
    [command addSize:48 :80];
    [command addGapWithM:2 withN:0];
    [command addReference:0 :0];
    [command addTear:@"ON"];
    [command addQueryPrinterStatus:ON];
    [command addCls];
    [command addTextwithX:0 withY:0 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"Smarnet"];
    [command add1DBarcode:30 :30 :@"CODE128" :100 :1 :0 :2 :2 :@"1234567890"];
    [command addQRCode:20 :160 :@"L" :5 :@"A" :0 :@"www.smarnet.cc"];
    [command addPrint:1 :1];
    return [command getCommand];
}

- (IBAction)writeAndRead:(id)sender {
    //发送标签模式查询
    unsigned char tscCommand[] = {0x1B, 0x21, 0x3F};
    NSData *data = [NSData dataWithBytes:tscCommand length:sizeof(tscCommand)];
    isReceive = NO;
    Manager.connecter.readData = ^(NSData * _Nullable data) {
        isReceive = YES;
        NSLog(@"data -> %@",data);
    };
    [Manager write:data];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isReceive) {
            //esc查询状态指令
            unsigned char escCommand[] = {0x1D,0x72,0x01};
            [Manager write:[NSData dataWithBytes:escCommand length:sizeof(escCommand)]];
        }
    });
}

//只适用于蓝牙连接
- (IBAction)progressWriteLabel:(id)sender {
    [Manager write:[self tscCommand] progress:^(NSUInteger total, NSUInteger progress) {
        CGFloat p = (CGFloat)progress / (CGFloat)total;
        [SVProgressHUD showProgress:p status:@"发送中..."];
    } receCallBack:^(NSData * _Nullable data) {
        [SVProgressHUD dismiss];
    }];
}

//只适用于蓝牙连接
- (IBAction)progressWriteTicket:(id)sender {
    [Manager write:[self escCommand] progress:^(NSUInteger total, NSUInteger progress) {
        CGFloat p = (CGFloat)progress / (CGFloat)total;
        [SVProgressHUD showProgress:p status:@"发送中..."];
    } receCallBack:^(NSData * _Nullable data) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)printCpclTemplate:(id)sender {
    //NSData *data = [Template printZhongJiTemplate_TSPL];
    NSData *data = [self printTsplZhongtongTemplate];
    [Manager write:data progress:^(NSUInteger total, NSUInteger progress) {
        CGFloat p = (CGFloat)progress / (CGFloat)total;
        [SVProgressHUD showProgress:p status:@"发送中..."];
    } receCallBack:^(NSData * _Nullable data) {
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)ticketPrintAction:(id)sender {
    
    [Manager write:[self escCommand]];
}

- (NSData *)printTsplZhongtongTemplate {
    TscCommand *cmd = [[TscCommand alloc] init];
    [cmd zhongTong_CommandData];
    [cmd zhongTong_addReceiverName:@"陈亮亮" phone:@"18374911770"];
    [cmd zhongTong_addReceiverAddress:@"深圳市南山区科技园A8音乐"];
    [cmd zhongTong_addSendName:@"李丽" phone:@"18374911770"];
    [cmd zhongTong_addSendAdress:@"深圳市南山区科技园A8音乐"];
    [cmd zhongTong_TopBarCodeNumber:@"1837491177"];
    
    [cmd zhongTong_BottomCodeNumber:@"18374911770"];
    [cmd zhongTong_BottomReceiverName:@"陈亮亮" phone:@"18374911770"];
    [cmd zhongTong_BottomaddReceiverAddress:@"深圳市南山区科技园A8音乐"];
    [cmd zhongTong_bottomAddSendName:@"李丽" phone:@"18374911770"];
    [cmd zhongTong_bottomAddSendAdress:@"深圳市南山区科技园A8音乐"];
    [cmd addPrint:1 :1];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([TscCommand class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = *(ivars + i);
        NSLog(@"%s", ivar_getName(ivar));
    }
    return [cmd getCommand];
    
    
    //cmd addTear:<#(NSString *)#>
}

- (IBAction)printSmallTicket:(id)sender {
    PTTestESC *esc = [PTTestESC new];
    NSData *data = [esc printElectronicSheet];
    NSData *data2 = [esc printElectronicSheet];
    NSMutableData *m_data = [[NSMutableData alloc] init];
    [m_data appendData:data];
    [m_data appendData:data2];
    [Manager write:m_data progress:^(NSUInteger total, NSUInteger progress) {
        CGFloat p = (CGFloat)progress / (CGFloat)total;
        [SVProgressHUD showProgress:p status:@"发送中..."];
    } receCallBack:^(NSData * _Nullable res) {
        [SVProgressHUD dismiss];
    }];
}


-(NSData *)escCommand{
    EscCommand *command = [[EscCommand alloc]init];
    [command addInitializePrinter];
    [command addPrintAndFeedLines:5];
    //内容居中
    [command addSetJustification:1];
    [command addPrintMode: 0|8|16|32];
    [command addText:@"Print text\n"];
    [command addPrintAndLineFeed];
    [command addPrintMode: 0];
    [command addText:@"Welcome to use Smarnet printer!"];
    //换行
    [command addPrintAndLineFeed];
    //内容居左（默认居左）
    [command addSetJustification:0];
    [command addText:@"智汇"];
    //设置水平和垂直单位距离
    [command addSetHorAndVerMotionUnitsX:7 Y:0];
    //设置绝对位置
    [command addSetAbsolutePrintPosition:6];
    [command addText:@"网络"];
    [command addSetAbsolutePrintPosition:10];
    [command addText:@"设备"];
    [command addPrintAndLineFeed];
    NSString *content = @"Gprinter";
    //二维码
    [command addQRCodeSizewithpL:0 withpH:0 withcn:0 withyfn:0 withn:5];
    [command addQRCodeSavewithpL:0x0b withpH:0 withcn:0x31 withyfn:0x50 withm:0x30 withData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [command addQRCodePrintwithpL:0 withpH:0 withcn:0 withyfn:0 withm:0];
    [command addPrintAndLineFeed];

    [command addSetBarcodeWidth:2];
    [command addSetBarcodeHeight:60];
    [command addSetBarcodeHRPosition:2];
    [command addCODE128:'B' : @"ABC1234567890"];
    
    [command addPrintAndLineFeed];
    
    UIImage *image = [UIImage imageNamed:@"gprinter.png"];
    [command addOriginrastBitImage:image];
    [command addPrintAndFeedLines:5];
    return [command getCommand];
}
- (IBAction)printBitMap:(id)sender {
    NSData *data = [Template printShenTongTemplate];
    NSData *date2 = [Template printShenTongTemplate];
    NSMutableData *res = [NSMutableData new];
    [res appendData:data];
    [res appendData:date2];
    [Manager write:res progress:^(NSUInteger total, NSUInteger progress) {
        CGFloat p = (CGFloat)progress / (CGFloat)total;
        [SVProgressHUD showProgress:p status:@"发送中..."];
    } receCallBack:^(NSData * _Nullable data) {
         [SVProgressHUD dismiss];
    }];
    
}

/**
 *  连接
 */
- (IBAction)connectAction:(id)sender {
    NSString *ip = self.ipTextField.text;
    int port = [self.portTextField.text intValue];
    [Manager connectIP:ip port:port connectState:^(ConnectState state) {
        [self updateConnectState:state];
    } callback:^(NSData *data) {
        
    }];
}
- (IBAction)yun_da_print:(id)sender {
    TscCommand *cmd = [TscCommand new];
    [cmd yunda_commonData];
    [cmd yunda_area_data:@"乌市市内包"];
    [cmd yunda_addSendName:@"陈亮亮" phone:@"18374911770"];
    [cmd yunda_addSendAdress:@"广东省深圳市南山区中心工业城10栋"];
    [cmd yunda_addReceiverName:@"邢新辉" phone:@"18374911770"];
    [cmd yunda_addReceiverAddress:@"新疆乌鲁木齐新市区大战共本机南路433号星际服务器几天"];
    [cmd yunda_addSignDate:@"2019/04/29 12:58:58"];
    [cmd yunda_topBarCodeNumber:@"18374911770"];
    [cmd yunda_remark_data:@"快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址快件送达收件人地址"];
    [cmd yunda_top_qr_code:@"18374911770"];
    
    [cmd yunda_bottomCodeNumber:@"18374911770"];
    [cmd yunda_bottomReceiverName:@"陈亮亮" phone:@"18374911770"];
    [cmd yunda_bottomaddReceiverAddress:@"新疆乌鲁木齐新市区大战共本机南路433号星际服务器几天"];
    [cmd yunda_bottomAddSendName:@"陈亮亮" phone:@"18374911770"];
    [cmd yunda_bottomAddSendAdress:@"广东省深圳市南山区中心工业城10栋"];
    [cmd yunda_bottom_qr_code:@"18374911770"];
    [cmd addPrint:1 :1];
    [Manager write:[cmd getCommand] receCallBack:^(NSData *data) {
        NSLog(@"recevier data");
    }];
}
- (IBAction)yunda_three_print:(id)sender {
    TscCommand *cmd = [TscCommand new];
    [cmd yunda_three_commonData];
    [cmd addPrint:1 :1];
    [Manager write:[cmd getCommand] receCallBack:^(NSData *data) {
        NSLog(@"recevier data");
    }];
}

-(void)updateConnectState:(ConnectState)state {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (state) {
            case CONNECT_STATE_CONNECTING:
                self.connState.text = @"连接状态：连接中....";
                break;
            case CONNECT_STATE_CONNECTED:
                NSLog(@"connect state test");
                [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                self.connState.text = @"连接状态：已连接";
                break;
            case CONNECT_STATE_FAILT:
                [SVProgressHUD showErrorWithStatus:@"连接失败"];
                self.connState.text = @"连接状态：连接失败";
                break;
            case CONNECT_STATE_DISCONNECT:
                [SVProgressHUD showInfoWithStatus:@"断开连接"];
                self.connState.text = @"连接状态：断开连接";
                break;
            default:
                self.connState.text = @"连接状态：连接超时";
                break;
        }
    });
}

- (IBAction)xmlPrint:(id)sender {
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"yunda74" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlPath];
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"josn" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    Manager.bleConnecter.readData = ^(NSData * _Nullable data) {
        
    };
    NSData *data = [WGPrintDataManager.print getQueryPrintStatusData:[JSONUtils dictWithData:jsonData]];
    NSString *str = [HexData hexStringWithData:data];
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [Manager write:data progress:^(NSUInteger total, NSUInteger progress) {
//                
//            } receCallBack:^(NSData * _Nullable res) {
//                NSLog(@"data:%@", res);
//            }];
//            sleep(1);
        });
        Manager.bleConnecter.readData = ^(NSData * _Nullable data) {
            NSLog(@"data: %@", data);
        };
    }
    
    [WGXMLParserManager.manager parseData:xmlData callback:^(NSArray<NSDictionary<NSString *,NSDictionary<NSString *,NSString *> *> *> * _Nullable atrri) {
        NSArray <NSData *> *datas = [WGPrintDataManager.print getPrintDataWithJson:[JSONUtils dictWithData:jsonData] xmlAttri:atrri];
        for (NSData *data in datas) {
            NSString *hex = [HexData hexStringWithData:data];
            NSString *es = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [Manager write:data progress:^(NSUInteger total, NSUInteger progress) {
                if (progress == total) {
                    NSData *data = [WGPrintDataManager.print getQueryPrintStatusData:[JSONUtils dictWithData:jsonData]];
                    NSString *str = [HexData hexStringWithData:data];
                    
                    for (int i = 0; i < 1; i++) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                             sleep(1);
                            [Manager write:data];
                           
                        });
                    }
                }
            } receCallBack:^(NSData * _Nullable data) {
                NSLog(@"data re: %@", data)
            }];
        }
    }];
}
- (IBAction)excTest:(id)sender {
//    PTTestESC *esc = [[PTTestESC alloc] init];
//    NSData *data = [esc textJustifiatopn];
//    [Manager write:data receCallBack:^(NSData *recever) {
//        NSString *str = [[NSString alloc] initWithData:recever encoding:NSUTF8StringEncoding];
//        NSLog(@"recevier data %@", str);
//    }];
//    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"zhongtong" ofType:@"xml"];
//    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlPath];
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"josn" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"esc" ofType:@"json"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSArray *atrri = [JSONUtils arrayWithData:xmlData];
//    NSDictionary *dic = [JSONUtils dictWithData:jsonData];
//    NSData *data = [WGPrintDataManager.print getEscPrintData:dic];
//    [Manager write:data receCallBack:^(NSData *recever) {
//        NSString *str = [[NSString alloc] initWithData:recever encoding:NSUTF8StringEncoding];
//        NSLog(@"recevier data %@", str);
//    }];
    
    NSData *queryData = [WGPrintDataManager.print getQueryPrintStatusData:[JSONUtils dictWithData:jsonData]];
    NSDictionary *jsonDict = [JSONUtils dictWithData:jsonData];
    NSArray <NSData *> *datas = [WGPrintDataManager.print getPrintDataWithJson:jsonDict xmlAttri:atrri];
    NSArray <NSString *> *iden = [WGPrintDataManager.print printIdentifers:[JSONUtils dictWithData:jsonData]];
    [WGPrintQueue.printQueue printDatas:datas identifiles:iden callback:^(NSString * _Nonnull state, NSInteger cur, NSInteger total, NSString * _Nonnull ide) {
        NSLog(@"state:%@, cur: %ld, total: %ld, ide: %@", state, (long)cur, (long)total, ide);
    } queryData:queryData type:@"esc"];
//    [WGXMLParserManager.manager parseData:xmlData callback:^(NSArray<NSDictionary<NSString *,NSDictionary<NSString *,NSString *> *> *> * _Nullable atrri) {
//        NSArray <NSData *> *datas = [WGPrintDataManager.print getPrintDataWithJson:[JSONUtils dictWithData:jsonData] xmlAttri:atrri];
//        NSArray <NSString *> *iden = [WGPrintDataManager.print printIdentifers:[JSONUtils dictWithData:jsonData]];
//        [WGPrintQueue.printQueue printDatas:datas identifiles:iden callback:^(NSString * _Nonnull state, NSInteger cur, NSInteger total, NSString * _Nonnull ide) {
//            NSLog(@"state:%@, cur: %ld, total: %ld, ide: %@", state, (long)cur, (long)total, ide);
//        } queryData:queryData];
//    }];
}
- (IBAction)printZhongTongXml:(id)sender {
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"zhongtong" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlPath];
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"josn" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    Manager.bleConnecter.readData = ^(NSData * _Nullable data) {
        
    };
     NSData *queryData = [WGPrintDataManager.print getQueryPrintStatusData:[JSONUtils dictWithData:jsonData]];
    [WGXMLParserManager.manager parseData:xmlData callback:^(NSArray<NSDictionary<NSString *,NSDictionary<NSString *,NSString *> *> *> * _Nullable atrri) {
        NSArray <NSData *> *datas = [WGPrintDataManager.print getPrintDataWithJson:[JSONUtils dictWithData:jsonData] xmlAttri:atrri];
        NSArray <NSString *> *iden = [WGPrintDataManager.print printIdentifers:[JSONUtils dictWithData:jsonData]];
        [WGPrintQueue.printQueue printDatas:datas identifiles:iden callback:^(NSString * _Nonnull state, NSInteger cur, NSInteger total, NSString * _Nonnull ide) {
            NSLog(@"state:%@, cur: %ld, total: %ld, ide: %@", state, (long)cur, (long)total, ide);
        } queryData:queryData type:@"tspl"];
    }];
}

- (IBAction)cmdTest:(id)sender {
    WGTSPLPrintCommand *cmd = [[WGTSPLPrintCommand alloc] init];
    NSData *data = [cmd cmdTtpe];
    NSString *hex = [HexData hexStringWithData:data];
    [WGLODOPConvertToJSON parseTxtWithFileName:@"韵达宽76高159"];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
