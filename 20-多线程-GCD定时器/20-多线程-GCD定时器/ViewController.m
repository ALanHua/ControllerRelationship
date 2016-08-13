//
//  ViewController.m
//  20-多线程-GCD定时器
//
//  Created by yhp on 16/8/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 定时器 */
@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}
int count = 0;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建定时器
    //
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // dispatch_source_t 是OC对象
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0  , 0, queue);
    // 设置定时器的属性,GCD的实践参数一般是纳秒 1秒 = pow(10,9)
//    dispatch_time_t start = DISPATCH_TIME_NOW;// 开始执行
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_time_t interval = (int64_t)(2.0 * NSEC_PER_SEC);
    
    dispatch_source_set_timer(self.timer, start, interval, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"-------%@",[NSThread currentThread]);
        count++;
        if (count == 5) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
    });
    
    dispatch_resume(self.timer);// 启动定时器
}

@end
