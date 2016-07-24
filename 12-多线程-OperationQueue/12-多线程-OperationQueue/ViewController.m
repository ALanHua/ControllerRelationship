//
//  ViewController.m
//  12-多线程-OperationQueue
//
//  Created by yhp on 16/7/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPNSOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //  创建队列
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    
    //  设置最大并发操作数
    queue.maxConcurrentOperationCount = 1;// 串行队列
    
    [queue addOperationWithBlock:^{
         NSLog(@"download1---%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download2---%@",[NSThread currentThread]);
       [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download3---%@",[NSThread currentThread]);
       [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download4---%@",[NSThread currentThread]);
       [NSThread sleepForTimeInterval:0.01];
    }];
}

-(void)operationQueue2
{
    //  创建队列
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    //  穿件操作
    NSBlockOperation* op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    }];
    // 添加操作到队列中
    [queue addOperation:op1];
    [queue addOperationWithBlock:^{
        NSLog(@"download32---%@",[NSThread currentThread]);
    }];
}

-(void)operationQueue
{
    /**
     *  NSOperationQueue的队列类型
     1，主队列，【NSOperationQueue mainQueue]
     2,其他队列，（串行，并发） [[NSOperationQueue alloc]init];
     */
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    // 创建操作（任务）
    NSInvocationOperation* op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation* op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download2) object:nil];
    
    NSBlockOperation* op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download4---%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download5---%@",[NSThread currentThread]);
    }];
    NSBlockOperation* op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download6---%@",[NSThread currentThread]);
    }];
    //  创建YHPNSOperation
    YHPNSOperation* op5 = [[YHPNSOperation alloc]init];// 异步操作，代码很长
    
    //  将操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
}

-(void)download1
{
    NSLog(@"download1---%@",[NSThread currentThread]);
}

-(void)download2
{
    NSLog(@"download2---%@",[NSThread currentThread]);
}

@end
