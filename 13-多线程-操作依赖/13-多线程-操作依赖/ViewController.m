//
//  ViewController.m
//  13-多线程-操作依赖
//
//  Created by yhp on 16/7/26.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
//    [queue addOperationWithBlock:^{
//        NSLog(@"download1----%@",[NSThread currentThread]);
//    }];
    NSBlockOperation* op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1----%@",[NSThread currentThread]);
    }];
    NSBlockOperation* op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download2----%@",[NSThread currentThread]);
    }];
    NSBlockOperation* op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3----%@",[NSThread currentThread]);
    }];
    NSBlockOperation* op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download4----%@",[NSThread currentThread]);
    }];
    NSBlockOperation* op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download5----%@",[NSThread currentThread]);
    }];
    /**
     *  监听operation 执行完成
     */
    op5.completionBlock = ^{
        NSLog(@"download complete--%@",[NSThread currentThread]);
    };
    //  设置依赖
    /**
     *  不能循环依赖
     */
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    [op3 addDependency:op4];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
}

@end
