//
//  ViewController.m
//  18-多线程-RunLoop
//
//  Created by yhp on 16/8/9.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

-(void)timer2
{
    // 默认被添加到当前RunLoop中，而且是NSDefaultRunLoopMode模式
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 修改模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)timer
{
    //    NSLog(@"%p,%p",[NSRunLoop mainRunLoop],[NSRunLoop currentRunLoop]);
    
    //    NSThread* thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    //    [thread start];
    // core fundation
    //    CFRunLoopGetMain()
    //    CFRunLoopGetCurrent()
    //    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    NSTimer* timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    // default 模式，但该模式你在滚动UI滚动中会被RunLop中断，去执行UITrackingRunLoopMode的定时器
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // 定时器会在标记为common modes的模式下
    // 标记为common modes的模式有NSDefaultRunLoopMode，UITrackingRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //    NSLog(@"----%@", [NSRunLoop currentRunLoop]);
}
-(void)run
{
    NSLog(@"----%p", [NSRunLoop currentRunLoop]);
//    [NSRunLoop currentRunLoop] runMode:<#(nonnull NSString *)#> beforeDate:<#(nonnull NSDate *)#>
   
}

@end
