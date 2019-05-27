//
//  WGBLEConnecter.m
//  Demo
//
//  Created by chen liang on 2019/5/8.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "WGBLEConnecter.h"
#import "HexData.h"

@implementation WGBLEConnecter

//- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
//    SEL sel = @selector(centralManager:didConnectPeripheral:);
//    [super performSelector:sel withObject:central withObject:peripheral];
//    //self.connPeripheral.
//}
//
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
//    NSLog(@"============收到打印状态：%@", [HexData hexStringWithData:characteristic.value]);
//    SEL sel = @selector(peripheral:didUpdateValueForDescriptor:error:);
//    [self analyzePrintState:characteristic.value];
//    [super performSelector:sel withObject:characteristic withObject:error];
//}
//
//- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
//    
//}
//
//- (void)analyzePrintState:(NSData *)data {
//    NSString *res = [HexData hexStringWithData:data];
//    NSLog(@"打印机回传状态为：%@", res);
////    if (data.length != 1) {
////        return;
////    }
////    Byte res[1];
////    [data getBytes:res length:1];
////    Byte byte = res[0];
////    int byte0 = byte >> 7 ^ 0x01;
////    int byte1 = byte >> 6 ^ 0x01;
////    int byte2 = byte >> 5 ^ 0x01;
////    int byte3 = byte >> 4 ^ 0x01;
////    int byte4 = byte >> 3 ^ 0x01;
////    int byte5 = byte >> 2 ^ 0x01;
////    int byte6 = byte >> 1 ^ 0x01;
////    int byte7 = byte ^ 0x01;
////    NSLog(@"%d, %d, %d, %d, %d, %d, %d, %d", byte0, byte1, byte2, byte3, byte4, byte5, byte6, byte7);
//    
//}
@end
