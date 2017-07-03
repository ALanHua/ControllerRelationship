//
//  ViewController.m
//  63-硬件信息获取
//
//  Created by yhp on 2017/7/3.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice--Hardware.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取手机型号
    NSLog(@"%@",[[UIDevice currentDevice] platformString]);
    // 获取内存空间
    NSLog(@"%@,%@",[[UIDevice currentDevice] freeDiskSpace],[[UIDevice currentDevice] totalDiskSpace]);
}


@end
