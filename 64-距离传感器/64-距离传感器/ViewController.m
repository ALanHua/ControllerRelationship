//
//  ViewController.m
//  64-距离传感器
//
//  Created by yhp on 2017/7/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UIApplication sharedApplication].proximitySensingEnabled = YES;
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    // 监听有物体靠近还是离开
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ProximityStateDidChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
}

-(void)ProximityStateDidChange
{
    if ([UIDevice currentDevice].proximityState) {
        NSLog(@"有物品靠近");
    }else{
        NSLog(@"有物品离开");
    }
}


@end
