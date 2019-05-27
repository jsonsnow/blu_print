//
//  PTPrinter.h
//
//  Created by midmirror on 15/12/25.
//  Copyright © 2015年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SDKDefine.h"
#import "PTPrinter.h"

/** 当前通讯方式 : Current communication method */
typedef NS_ENUM(NSInteger, PTDispatchMode) {
    
    PTDispatchModeUnconnect  = 0,
    PTDispatchModeBLE        = 1,
    PTDispatchModeWiFi       = 2,
};

//cpcl:Print Status
typedef NS_ENUM(NSInteger, PTPrintState) {
    
    // 打印成功 Print success
    PTPrintStateSuccess             = 0xcc00,
    // 打印失败（缺纸）Print failure (paper out)
    PTPrintStateFailurePaperEmpty   = 0xcc01,
    // 打印失败（开盖） Print failure (cover open)
    PTPrintStateFailureLidOpen      = 0xcc02,
};

typedef NS_ENUM(NSInteger, PTBleConnectError) {
    
    //连接超时 Connect timeout
    PTBleConnectErrorTimeout                  = 0,
    //获取服务超时 Disvocer Service timeout
    PTBleConnectErrorDisvocerServiceTimeout   = 1,
    //验证超时 Validation timeout
    PTBleConnectErrorValidateTimeout          = 2,
    //未知设备 Unkown device
    PTBleConnectErrorUnknownDevice            = 3,
    //系统错误，由coreBluetooth框架返回
    //System error, returned by coreBluetooth
    PTBleConnectErrorSystem                   = 4,
    //验证失败 Validation failure
    PTBleConnectErrorValidateFail             = 5
};

@class PTPrinter;

typedef void(^PTPrinterParameterBlock)(PTPrinter *printer);
typedef void(^PTPrinterDictionaryBlock)(NSDictionary<NSString *, PTPrinter *> *printerDic);
typedef void(^PTEmptyParameterBlock)();
typedef void(^PTBluetoothConnectFailBlock)(PTBleConnectError error);
typedef void(^PTNumberParameterBlock)(NSNumber *number);
typedef void(^PTDataParameterBlock)(NSData *data);
typedef void(^PTPrintStateBlock)(PTPrintState state);

/**
 *  主要功能：实现和打印机的 BLE 和 WiFi通讯
 *  Main function：Achieve BLE and WiFi communication of the printer
 */
@interface PTDispatcher : NSObject

+ (instancetype)share;

/** connected device */
@property (strong,nonatomic,readwrite) PTPrinter                    *printerConnected;

@property (assign,nonatomic) PTDispatchMode                         mode;

@property (weak, nonatomic, readonly) CBCentralManager*             centralManager;
/** send data success */
@property (copy,nonatomic,readwrite) PTNumberParameterBlock         sendSuccessBlock;
/** send data fail */
@property (copy,nonatomic,readwrite) PTEmptyParameterBlock          sendFailureBlock;
/** send progress */
@property (copy,nonatomic,readwrite) PTNumberParameterBlock         sendProgressBlock;
/** receiveDara */
@property (copy,nonatomic,readwrite) PTDataParameterBlock           receiveDataBlock;
/** printStatus */
@property (copy,nonatomic,readwrite) PTPrintStateBlock              printStateBlock;
/** findDevice */
@property (copy,nonatomic,readwrite) PTPrinterParameterBlock        findBluetoothBlock;
/** findAllDevice */
@property (copy,nonatomic,readwrite) PTPrinterDictionaryBlock       findBluetoothAllBlock;
/** findAllDevice */
@property (copy,nonatomic,readwrite) PTPrinterDictionaryBlock       findWiFiAllBlock;
/** connecte success */
@property (copy,nonatomic,readwrite) PTEmptyParameterBlock          connectSuccessBlock;
/** connecte fail*/
@property (copy,nonatomic,readwrite) PTBluetoothConnectFailBlock    connectFailBlock;
/** unconnect */
@property (copy,nonatomic,readwrite) PTNumberParameterBlock         unconnectBlock;
/** rssi */
@property (copy,nonatomic,readwrite) PTNumberParameterBlock         readRSSIBlock;

/**
 发送数据
 Send data

 @param data 要发送的数据 the data to send
 */
- (void)sendData:(NSData *)data;

/**
 Start scanning Bluetooth
 开始扫描蓝牙
 */
- (void)scanBluetooth;

/**
 Stop scanning Bluetooth
 停止扫描蓝牙
 */
- (void)stopScanBluetooth;

/**
 扫描Wi-Fi
 Scan Wi-Fi
 
 @param wifiAllBlock 扫描Wi-Fi成功回调Block，参数为打印机字典 Block is triggered when successfully scanning Wi-Fi, parameter is printer dictionary
 */
- (void)scanWiFi:(PTPrinterDictionaryBlock)wifiAllBlock;

/**
 连接打印机
 Connect printer

 @param printer 连接的打印机 connected printer
 */
- (void)connectPrinter:(PTPrinter *)printer;

/**
 断开打印机连接
 Disconnect printer

 @param printer 要连接的打印机 the printer to connect
 */
- (void)unconnectPrinter:(PTPrinter *)printer;

/**
 发现蓝牙回调，coreBlueTooth框架每发现一台打印机就会调用（会重复发现打印机）
 Trigger this method when finding Bluetooth, coreBlueTooth will trigger it when finding one printer (will find printer repeatably)
 @param bluetoothBlock 回调，参数为发现的打印机对象 trigger, parameter is the printer object found
 */
- (void)whenFindBluetooth:(PTPrinterParameterBlock)bluetoothBlock;

/**
 获取已发现的所有打印机，每新发现新的打印机或隔三秒调用一次
 Get all the printers found, trigger once when finding new printer or trigger once every 3 seconds
 
 @param bluetoothAllBlock 回调Block，参数为打印机字典 trigger Block, parameter is printer dictionary
 */
- (void)whenFindBluetoothAll:(PTPrinterDictionaryBlock)bluetoothAllBlock;


/**
 连接设备更新RSSI回调
 Trigger this method when connecting new device to update RSSI

 @param readRSSIBlock 回调block 参数为连接打印机信号强度 trigger block, parameter is the signal strength of connecting printer
 */
- (void)whenReadRSSI:(PTNumberParameterBlock)readRSSIBlock;


/**
 连接成功回调
 Trigger this method when connecting successfully

 @param connectSuccessBlock 回调block : trigger block
 */
- (void)whenConnectSuccess:(PTEmptyParameterBlock)connectSuccessBlock;

/**
 出现连接错误时
 When connect error is occurred

 @param connectFailBlock 带连接错误参数的block block with connect error parameter
 */
- (void)whenConnectFailureWithErrorBlock:(PTBluetoothConnectFailBlock)connectFailBlock;


/**
 断开连接回调
 Trigger this method when disconnecting

 @param unconnectBlock 回调block : trigger block
 */
- (void)whenUnconnect:(PTNumberParameterBlock)unconnectBlock;

/**
 数据发送成功
 Data send success

 @param sendSuccessBlock 回调block : trigger block
 */
- (void)whenSendSuccess:(PTNumberParameterBlock)sendSuccessBlock;

/**
 数据发送失败
 Data send failure

 @param sendFailureBlock 回调block
 */
- (void)whenSendFailure:(PTEmptyParameterBlock)sendFailureBlock;

/**
 数据发送进度
 Data sending progress

 @param sendProgressBlock 回调block，参数是发送进度0~1
 */
- (void)whenSendProgressUpdate:(PTNumberParameterBlock)sendProgressBlock;

/**
 蓝牙接收到数据回调,只有蓝牙接收到数据就会有回调
 Trigger this method when Bluetooth receives the data, only when Bluetooth receives data can it trigger

 @param receiveDataBlock 回调block，参数时接收到的data数据
 */
- (void)whenReceiveData:(PTDataParameterBlock)receiveDataBlock;

/**
 接收到打印机打印状态回调
 Trigger this method when receiving print state

 @param printStateBlock 回调block，参数为打印状态枚举
 */
- (void)whenUpdatePrintState:(PTPrintStateBlock)printStateBlock;

/**
 获取蓝牙中心蓝牙是否打开,蓝牙中心刚初始化时，状态值默认时未开启的
 Get the information of whether Bluetooth of center device is ON, when the center device is initializing, its status defaults to OFF.

 @return 蓝牙开启状态
 */
- (BOOL)isBluetoothStatePowerOn;

/**
 设置蓝牙连接超时时间
 Set the time of Bluetooth timeout

 @param timeout 时间，单位为秒，大于0 : time, unit is second, > 0
 */
- (void)setupBleConnectTimeout:(double)timeout;

- (NSString *)SDKVersion;
- (NSString *)SDKBuildTime;
- (NSString *)SDKDescription;

@end
