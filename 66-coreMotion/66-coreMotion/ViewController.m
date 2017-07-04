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
    

    
}
#pragma mark - 获取加速计信息
-(void)acceleramiter
{
    // push 运动管理者对象
    self.mgr = [[CMMotionManager alloc]init];
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

@end
