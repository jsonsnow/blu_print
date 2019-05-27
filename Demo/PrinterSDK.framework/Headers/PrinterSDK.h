//
//  PrinterSDK.h
//  PrinterSDK
//
//  Created by midmirror on 16/10/31.
//  Copyright © 2016年 Mellow. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif

#import <Foundation/NSObjCRuntime.h>

//! Project version number for PrinterSDK.
FOUNDATION_EXPORT double PrinterSDKVersionNumber;

//! Project version string for PrinterSDK.
FOUNDATION_EXPORT const unsigned char PrinterSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <PrinterSDK/PublicHeader.h>

#import <PrinterSDK/PTCommandESC.h>     //ESC-POS 指令集
#import <PrinterSDK/PTCommandTSPL.h>    //TSC-TSPL指令集
#import <PrinterSDK/PTCommandZPL.h>     //ZPL     指令集
#import <PrinterSDK/PTCommandCPCL.h>
#import <PrinterSDK/PTLabel.h>

#import <PrinterSDK/PTBitmap.h>
#import <PrinterSDK/PTBitmap+GrayLevel.h>
#import <PrinterSDK/PTBitmapSTAR.h>
#import <PrinterSDK/PTEncode.h>
#import <PrinterSDK/NSString+Ext.h>

// Dispatch

#import <PrinterSDK/PTDispatcher.h>
#import <PrinterSDK/PTPrinter.h>  //Wifi 和 蓝牙 BLE 通讯
#import <PrinterSDK/PTRouter.h>
#import <PrinterSDK/MBProtocol.h>
#import <PrinterSDK/DitheringManager.h>
