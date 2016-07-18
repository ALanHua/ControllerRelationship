//
//  ViewController.m
//  04-多线程-线程状态
//
//  Created by yhp on 16/7/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

-(void)run
{
    for (NSUInteger i = 0; i < 100; i++) {
        NSLog(@"---%zd",i);
        if (i == 49) {
            [NSThread exit];// 直接退出线程
        }
    }
}

-(void)run2
{
    NSLog(@"-------");
//    [NSThread sleepForTimeInterval:2];
//    [NSThread sleepUntilDate:[NSDate distantFuture]];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];// 2s 钟
    NSLog(@"-------");
}

@end
