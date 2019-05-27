//
//  WGBLEConnecter.h
//  Demo
//
//  Created by chen liang on 2019/5/8.
//  Copyright © 2019 smarnet. All rights reserved.
//

#import "BLEConnecter.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGBLEConnecter : BLEConnecter<CBPeripheralDelegate, CBCentralManagerDelegate>

@end

NS_ASSUME_NONNULL_END
