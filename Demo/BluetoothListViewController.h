//
//  ViewController.h
//  GSDK
//
//  Created by 猿史森林 on 2018/6/15.
//  Copyright © 2018年 Smarnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnecterManager.h"
#import "CtrlViewController.h"

@interface BluetoothListViewController : UIViewController

@property(nonatomic,copy)ConnectDeviceState state;
@end

