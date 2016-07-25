//
//  YHPNSOperation.m
//  12-多线程-OperationQueue
//
//  Created by yhp on 16/7/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPNSOperation.h"

@implementation YHPNSOperation

/**
 *  需要执行的任务
 */
-(void)main
{
//    NSLog(@"YHPNSOperation----%@",[NSThread currentThread]);
    for (NSInteger i = 0; i < 1000; i++) {
        NSLog(@"YHPNSOperation--1-%@",[NSThread currentThread]);
    }
    if (self.isCancelled) {
        return;
    }// 苹果官方建议，自定义queue
    
    for (NSInteger i = 0; i < 1000; i++) {
        NSLog(@"YHPNSOperation--2-%@",[NSThread currentThread]);
    }
    if (self.isCancelled) {
        return;
    }// 苹果官方建议,自定义queue
    for (NSInteger i = 0; i < 1000; i++) {
        NSLog(@"YHPNSOperation--3-%@",[NSThread currentThread]);
    }
}
@end
