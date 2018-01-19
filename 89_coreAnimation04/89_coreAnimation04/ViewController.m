//
//  ViewController.m
//  89_coreAnimation04
//
//  Created by yhp on 2018/1/18.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;

@property(nonatomic,weak)NSTimer* timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
//    设置表针的视图锚点
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
//    UIView Control 一加载就设置
    [self tick];
}


/**
 设置 指针的旋转角度
 */
-(void)tick
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* components = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hourAngle    = (components.hour / 12.0)   * M_PI * 2;
    CGFloat minuteAngle  = (components.minute / 60.0) * M_PI * 2;
    CGFloat secondAngle  = (components.second / 60.0) * M_PI * 2;
    
//    设置旋转角度
    self.hourHand.transform   = CGAffineTransformMakeRotation(hourAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secondAngle);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
