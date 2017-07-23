//
//  ViewController.m
//  78-指南针
//
//  Created by yhp on 2017/7/23.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager* lM;
@property (weak, nonatomic) IBOutlet UIImageView *compass;

@end

@implementation ViewController

-(CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc]init];
        _lM.delegate = self;
        // 每隔多少度旋转一次
        _lM.headingFilter = 2;
    }
    return _lM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开始监听设备朝向
    [self.lM startUpdatingHeading];
}

#pragma mark - <CLLocationManagerDelegate>

/**
  获取
 @param manager 位置管理者
 @param newHeading 手机朝向
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /*
     *  newHeading
     *  magneticHeading 磁北角度
     *  trueHeading     真北角度
     */
    CGFloat angle = newHeading.magneticHeading;
    // 把角度转换成弧度
    CGFloat angleR = angle / 180.0 * M_PI;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.compass.transform = CGAffineTransformMakeRotation(-angleR);
    }];

    
}




@end
