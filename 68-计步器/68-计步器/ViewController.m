//
//  ViewController.m
//  68-计步器
//
//  Created by yhp on 2017/7/6.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

/** 计步器 */
//@property(nonatomic,strong)CMStepCounter* counter;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
/** 计步器 */
@property(nonatomic,strong)CMPedometer* pedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![CMPedometer isStepCountingAvailable]) {
         NSLog(@"计步器不可用");
        return;
    }
    
    // 开始计步
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate =
    [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    NSLog(@"%@",fromDate);
    [self.pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            self.stepLabel.text = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
    }];
    
    
}


#pragma mark - 懒加载

- (CMPedometer *)pedometer
{
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc]init];
    }
    return _pedometer;
}

#if 0
-(void)notUseStepCounter
{
    if (![CMStepCounter isStepCountingAvailable]) {
        NSLog(@"计步器不可用");
        return;
    }
    
    // 开始计步
    [self.counter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:5 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        if (error) {
            return;
        }
        //NSLog(@"%ld",numberOfSteps);
        self.stepLabel.text = [NSString stringWithFormat:@"%ld",numberOfSteps];
    }];
}

- (CMStepCounter *)counter
{
    if (!_counter) {
        _counter = [[CMStepCounter alloc]init];
    }
    return _counter;
}
#endif

@end
