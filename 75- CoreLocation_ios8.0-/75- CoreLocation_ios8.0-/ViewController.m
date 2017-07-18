//
//  ViewController.m
//  75- CoreLocation_ios8.0-
//
//  Created by yhp on 2017/7/18.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<CLLocationManagerDelegate>
/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager* lM;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 使用位置管理者
    [self.lM startUpdatingLocation];
    
}

#pragma mark -懒加载
- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM  = [[CLLocationManager alloc]init];
        // 1.1 设置代理
        _lM.delegate = self;
        // 每个多远定位一次
       // _lM.distanceFilter = 100;
        /**
         kCLLocationAccuracyBestForNavigation // 最适合导航
         kCLLocationAccuracyBest; // 最好的
         kCLLocationAccuracyNearestTenMeters; // 10m
         kCLLocationAccuracyHundredMeters; // 100m
         kCLLocationAccuracyKilometer; // 1000m
         kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _lM.desiredAccuracy = kCLLocationAccuracyBest;
        
        [_lM requestWhenInUseAuthorization];
    }
    return _lM;
}

#pragma mark - <<CLLocationManagerDelegate>>
/**
 更新到位置之后调用
 @param manager 位置管理者
 @param locations 位置数组
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"更新位置");
    // 停止更新
    [manager stopUpdatingLocation];
}

@end
