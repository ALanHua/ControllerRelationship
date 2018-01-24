//
//  ViewController.m
//  95_coreAnimation10
//
//  Created by yhp on 2018/1/23.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitViews;

/** 定时器 */
@property(nonatomic,strong)NSTimer* timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* digits = [UIImage imageNamed:@"Digits"];

//  设置View
    for (UIView* view in self.digitViews) {

        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect =  CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
//        拉伸过滤
        view.layer.magnificationFilter = kCAFilterNearest;
    }
//    开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
}

- (void)setDigit:(NSInteger)digit forView:(UIView*)view
{
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

-(void)tick
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* components = [calendar components:units fromDate:[NSDate date]];
//    设置小时
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
//   设置分钟
    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
//    设置秒
    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
