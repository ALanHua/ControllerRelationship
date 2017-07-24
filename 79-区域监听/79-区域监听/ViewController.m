//
//  ViewController.m
//  79-区域监听
//
//  Created by yhp on 2017/7/24.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager* lM;
@end

@implementation ViewController


-(CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc]init];
        _lM.delegate = self;
        
        if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
            [_lM requestAlwaysAuthorization];
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
                _lM.allowsBackgroundLocationUpdates = YES;
            }
        }
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 区域监听
    CLLocationCoordinate2D center = {22.13,123.456};
    CLCircularRegion * regin = [[CLCircularRegion alloc]initWithCenter:center radius:1000 identifier:@"yhp"];
    
    [self.lM startMonitoringForRegion:regin];
#if 0 // 可以监听多个区域
    CLLocationCoordinate2D center2 = {21.13,123.456};
    CLCircularRegion * regin2 = [[CLCircularRegion alloc]initWithCenter:center2 radius:1000 identifier:@"yhp2"];
    [self.lM startMonitoringForRegion:regin2];
#endif
    /*状态监听*/
    [self.lM requestStateForRegion:regin];
}

#pragma mark - <CLLocationManagerDelegate>
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域%@",region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域%@",region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"状态%zd",state);
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
}



@end
