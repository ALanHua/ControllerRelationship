//
//  ViewController.m
//  11-多线程-NSOperation
//
//  Created by yhp on 16/7/24.
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
    [self blockOperation];
}

-(void)blockOperation
{
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
        //  在主线程
        NSLog(@"-----%@",[NSThread currentThread]);
    }];
    // 添加额外任务(在子线程执行)/ 异步执行
    [op addExecutionBlock:^{
        NSLog(@"---111--%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"---222--%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"---333--%@",[NSThread currentThread]);
    }];
    
    [op start];
}


-(void)invocationOperation
{
    NSInvocationOperation* op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run) object:nil];
    
    [op start];
}

-(void)run
{
    NSLog(@"-----%@",[NSThread currentThread]);
}

@end
