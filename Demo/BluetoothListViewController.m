//
//  ViewController.m
//  GSDK
//
//  Created by 猿史森林 on 2018/6/15.
//  Copyright © 2018年 Smarnet. All rights reserved.
//

#import "BluetoothListViewController.h"

@interface BluetoothListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *devices;
@property(nonatomic,strong)NSMutableDictionary *dicts;
@property (strong, nonatomic) IBOutlet UITableView *deviceList;
@end

@implementation BluetoothListViewController

-(NSMutableArray *)devices {
    if (!_devices) {
        _devices = [[NSMutableArray alloc]init];
    }
    return _devices;
}

-(NSMutableDictionary *)dicts {
    if (!_dicts) {
        _dicts = [[NSMutableDictionary alloc]init];
    }
    return _dicts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
    if (Manager.bleConnecter == nil) {
        [Manager didUpdateState:^(NSInteger state) {
            switch (state) {
                case CBCentralManagerStateUnsupported:
                    NSLog(@"The platform/hardware doesn't support Bluetooth Low Energy.");
                    break;
                case CBCentralManagerStateUnauthorized:
                    NSLog(@"The app is not authorized to use Bluetooth Low Energy.");
                    break;
                case CBCentralManagerStatePoweredOff:
                    NSLog(@"Bluetooth is currently powered off.");
                    break;
                case CBCentralManagerStatePoweredOn:
                    [self startScane];
                    NSLog(@"Bluetooth power on");
                    break;
                case CBCentralManagerStateUnknown:
                default:
                    break;
            }
        }];
    } else {
        [self startScane];
    }
}

-(void)startScane {
    //CBUUID *uuid = [CBUUID UUIDWithString:@"49535343-FE7D-4AE5-8FA9-9FAFD205E455"];
    [Manager scanForPeripheralsWithServices:nil options:nil discover:^(CBPeripheral * _Nullable peripheral, NSDictionary<NSString *,id> * _Nullable advertisementData, NSNumber * _Nullable RSSI) {
        if (peripheral.name != nil) {
            NSLog(@"name -> %@",peripheral.name);
            NSUInteger oldCounts = [self.dicts count];
            [self.dicts setObject:peripheral forKey:peripheral.identifier.UUIDString];
            if (oldCounts < [self.dicts count]) {
                [_deviceList reloadData];
            }
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [_devices count];
    return [[self.dicts allKeys]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    CBPeripheral *peripheral = [self.dicts objectForKey:[self.dicts allKeys][indexPath.row]];
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = [self.dicts objectForKey:[self.dicts allKeys][indexPath.row]];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CtrlViewController *ctrlViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CtrlViewController"];
//    [self.navigationController pushViewController:ctrlViewController animated:YES];
    [self connectDevice:peripheral];
}

-(void)connectDevice:(CBPeripheral *)peripheral {
    if (Manager.bleConnecter.connPeripheral) {
        //[Manager.bleConnecter closePeripheral:Manager.bleConnecter.connPeripheral];
    }
    [Manager connectPeripheral:peripheral options:nil timeout:20 connectBlack:self.state];
}

-(void)viewDidDisappear:(BOOL)animated{
    [Manager stopScan];
}

@end
