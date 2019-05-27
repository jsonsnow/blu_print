//
//  PTPrinter.h
//  WirelessPrinter
//
//  Created by midmirror on 16/9/9.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PTRouter.h"

/** 当前打印机配备哪些模块 */
/** Which modules that the current printer equipped */
typedef NS_ENUM(NSInteger, PTPrinterModule) {
    
    PTPrinterModuleUnknown    = 0,
    PTPrinterModuleBLE        = 1,
    PTPrinterModuleWiFi       = 2,
    PTPrinterModuleBoth       = 3,
};

typedef NS_ENUM(NSInteger, PTCommandMode) {
    
    PTCommandModeUnselected = -1,
    PTCommandModeESC        = 0,
    PTCommandModeTSPL       = 1,
    PTCommandModeCPCL       = 2,
    PTCommandModeDPL        = 3,
    PTCommandModeEPL        = 4,
    PTCommandModeZPL        = 5,
    PTCommandModeSTAR       = 6,
};

typedef NS_ENUM(NSInteger, PTPrinterVender) {
    PTPrinterVenderUnknown = -1,
    PTPrinterVenderHY = 0,
    PTPrinterVenderSTAR = 1,
};

typedef NS_ENUM(NSInteger, PTBluetoothVender) {
    PTBluetoothVenderUnknown = -1,
    PTBluetoothVenderISSC = 0,
    PTBluetoothVenderIVT = 1,
    PTBluetoothVenderMB = 2
};

@interface PTPrinter : NSObject

// Printer's distance calculate by RSSI
@property(strong,nonatomic,readwrite) NSString *name;
//打印机Mac地址          @"34:81:F4:24:D7:AB"
//Printer Mac address
@property(strong,nonatomic,readwrite) NSString *mac;
//打印机Mac地址字符串前6位 @"3481F4"
//Former 6 numbers of printer Mac address character string
@property(strong,nonatomic,readwrite) NSString *macKey;
@property(strong,nonatomic,readwrite) NSString *lastTime;
//打印机模型 暂时无效
//Printer model  ineffective temporarily
@property(strong,nonatomic,readwrite) NSString *model;
@property(assign,nonatomic,readwrite) PTPrinterModule module;
//打印机支持的指令类型
//Command type supported by the printer
@property(assign,nonatomic,readwrite) PTCommandMode commandMode;
//打印机厂商
//Printer supplier
@property(assign,nonatomic,readwrite) PTPrinterVender vender;
//蓝牙供应商,由macKey决定
//Bluetooth supplier, decided by macKey
@property(assign,nonatomic,readwrite) PTBluetoothVender bluetoothVender;
//发现蓝牙时获取到的广播信息
//The broadcast information obtained when Bluetooth is found
@property(strong,nonatomic,readwrite) NSDictionary *advertisement;
// BLE
// 蓝牙外设UUID : Bluetooth peripherals UUID
@property(strong,nonatomic,readwrite) NSString *uuid;
//发现外设时获取到的信号强度值，单位分贝
//The signal strength value obtained when peripherals are found, unit is db
@property(strong,nonatomic,readwrite) NSNumber *rssi;
//信号强度等级分0-5级，
//Signal strength level is from 0 to 5
@property(strong,nonatomic,readwrite) NSNumber *strength;
//由信号强度计算的距离
//The distance calculated by signal strength
@property(strong,nonatomic,readwrite) NSNumber *distance;
// when value is YES, SDK will get printer's message
@property(assign,nonatomic,readwrite) BOOL notify;
//蓝牙外设 : Bluetooth peripherals
@property(strong,nonatomic,readwrite) CBPeripheral *peripheral;
@property(strong,nonatomic,readwrite) NSDate *time;
// WiFi
@property(strong,nonatomic,readwrite) PTRouter *router;
@property(strong,nonatomic,readwrite) NSString *ip;
@property(strong,nonatomic,readwrite) NSString *port;

/** 获取打印机名字 */
/** Get printer name */
+ (NSString *)nameWithPeripheral:(CBPeripheral *)peripheral adv:(NSDictionary *)adv;
+ (PTPrinterVender)venderWith:(NSDictionary *)adv;
+ (PTBluetoothVender)bluetoothVenderWith:(NSString *)macKey;
+ (NSString *)macWith:(NSDictionary *)adv vender:(PTPrinterVender)vender;
+ (NSString *)macKeyWith:(NSString *)mac;
+ (PTCommandMode)commandModeWith:(NSDictionary *)adv;

/** 计算距离 : Calculate distance */
+ (NSNumber *)distanceWithRSSI:(NSNumber *)RSSI;

/** 判断信号强度 : Determine signal strength */
+ (NSNumber *)strengthWithRSSI:(NSNumber *)RSSI;

+ (NSString *)hexStringWithData:(NSData *)data;

@end
