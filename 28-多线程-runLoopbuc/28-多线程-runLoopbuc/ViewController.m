//
//  ViewController.m
//  28-多线程-runLoopbuc
//
//  Created by yhp on 16/8/23.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSThread* thread = [[NSThread alloc]initWithTarget:self selector:@selector(excute) object:nil];
    [thread start];
}
/**
 *  NSRUnLoop 添加监听不能让NSRunLoop一直执行，只有定时器和source
 */
-(void)excute
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"------");
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    [[NSRunLoop currentRunLoop]run];
    
    CFRelease(observer);
}
@end
