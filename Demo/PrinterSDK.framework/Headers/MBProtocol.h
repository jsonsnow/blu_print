//
//  MBProtocol.h
//  PrinterSDK
//
//  Created by mellow on 2017/2/27.
//  Copyright © 2017年 Mellow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProtocol : NSObject

@property(assign,nonatomic,readwrite) uint32_t crcKey;
@property(strong,nonatomic,readwrite) NSData *crcKeyData;

- (NSData *)packImageData:(NSData *)data andMaxPacketLength:(uint16_t)maxPacketLength;

+ (MBProtocol *)shared;

@end
