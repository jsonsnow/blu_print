//
//  PTRouter.h
//  WirelessPrinter
//
//  Created by midmirror on 16/9/18.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRouter : NSObject

@property(strong,nonatomic,readwrite) NSString *broadcastIP;
@property(strong,nonatomic,readwrite) NSString *localIP;
@property(strong,nonatomic,readwrite) NSString *netmask;
@property(strong,nonatomic,readwrite) NSString *interface;
@property(strong,nonatomic,readwrite) NSString *gateway;

@property(assign,nonatomic,readwrite) BOOL connected;
@property(strong,nonatomic,readwrite) NSString *MAC;
@property(strong,nonatomic,readwrite) NSString *SSID;
@property(strong,nonatomic,readwrite) NSString *SSIDDATA;

@end
