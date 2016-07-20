//
//  ViewController.m
//  07-多线程-GCD基本使用
//
//  Created by yhp on 16/7/19.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
// GCD 在libdispath
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self syncMain];
}

/**
 *  同步函数 + 主线程 会阻塞
 */
-(void)syncMain
{
    // 获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3--%@",[NSThread currentThread]);
    });
}

/**
 *  异步函数 + 主队列 不会开启线程，只会在主线程中执行
 */
-(void)asyncMain
{
    // 获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3--%@",[NSThread currentThread]);
    });
}

/**
 *  同步函数 + 串行队列，不会开启线程
 */
-(void)syncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);// 串行队列
    dispatch_sync(queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3--%@",[NSThread currentThread]);
    });
}


/**
 *  异步函数 + 串行队列，会开启新的线程，任务串行
 */
-(void)asyncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);// 串行队列
    dispatch_async(queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3--%@",[NSThread currentThread]);
    });
}

/**
 *  同步函数--并发队列，不会开启新的线程，
 */
-(void)syncConcurrent
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);// 并发队列
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}

/**
 *  异步函数--并发队列，可以同时开启多条线程
 */
-(void)asyncConcurrent
{
    //    创建并发队列
    //   1，label:队列的名字
//    dispatch_queue_t queue = dispatch_queue_create("download.image.queue", DISPATCH_QUEUE_CONCURRENT);
    // 2，获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });

}

@end
