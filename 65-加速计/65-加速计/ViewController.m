//
//  ViewController.m
//  65-加速计
//
//  Created by yhp on 2017/7/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAccelerometerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 获取单例对象
    UIAccelerometer* accelerometer = [UIAccelerometer sharedAccelerometer];
    // 设置代理
    accelerometer.delegate = self;
    // 获取采用间隔
    [accelerometer setUpdateInterval:1.0];
}

#pragma mark - <UIAccelerometerDelegate>
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"x:%f,y:%f,z:%f\n",acceleration.x,acceleration.y,acceleration.z);
}

@end
