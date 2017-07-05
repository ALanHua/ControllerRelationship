//
//  ViewController.m
//  66-coreMotion
//
//  Created by yhp on 2017/7/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
/** 运动管理者 */
@property(nonatomic,strong) CMMotionManager* mgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pull
    if (![self.mgr isGyroAvailable]) {
        NSLog(@"手机该换了");
    }
    
    [self.mgr startGyroUpdates];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CMRotationRate rotationrate = self.mgr.gyroData.rotationRate;
    NSLog(@"x:%f,y:%f,z:%f",rotationrate.x,rotationrate.y,rotationrate.z);
}

#pragma mark - 获取陀螺仪信息
- (void)pushGyro
{
    // 获取陀螺仪
    if (![self.mgr isGyroAvailable]) {
        NSLog(@"手机该换了");
    }
    
    // 设置采样间隔
    self.mgr.gyroUpdateInterval = 0.3;
    
    // 开始采样
    [self.mgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        CMRotationRate rate = gyroData.rotationRate;
        NSLog(@"x:%f,y:%f,z:%f",rate.x,rate.y,rate.z);
    }];
}

#pragma mark - 获取加速计信息
-(void)pullAccelerameter
{
    // pull
    // 判断加速度计是否可用
    if (!self.mgr.isAccelerometerAvailable) {
        NSLog(@"加速度计不可用");
        return;
    }
    // 开始采样
    [self.mgr startAccelerometerUpdates];
}

-(void)pushAccelerameter
{
    // push 运动管理者对象
    // 判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable) {
        NSLog(@"加速计不可用");
        return;
    }
    // 设置采样间隔
    self.mgr.accelerometerUpdateInterval = 0.3;
    // 开始采样
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) { // 将采样到加速计数据时就会执行
        if (error) {
            return;
        }
        // 获取加速信息
        CMAcceleration acceleration = accelerometerData.acceleration;
        NSLog(@"x:%f,y:%f,z:%f",acceleration.x,acceleration.y,acceleration.z);
    }];
}

-(void)getAcceleramiterInfo
{
    CMAcceleration acceleration = self.mgr.accelerometerData.acceleration;
    NSLog(@"x:%f,y:%f,z:%f",acceleration.x,acceleration.y,acceleration.z);
}

#pragma mark - mgr 懒加载
- (CMMotionManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CMMotionManager alloc]init];
    }
    return _mgr;
}



@end
