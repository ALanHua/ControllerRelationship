//
//  ViewController.m
//  09-多线程-GCD其他函数
//
//  Created by yhp on 16/7/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    YHPPerson* p1 = [[YHPPerson alloc]init];
//    NSLog(@"%@",p1.books);
//    YHPPerson* p2 = [[YHPPerson alloc]init];
//    NSLog(@"%@",p2.books);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString* from = @"/Users/smartwater/Downloads/11";
    NSString* to = @"/Users/smartwater/Downloads/22";
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSArray* subPaths = [mgr subpathsAtPath:from];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(subPaths.count, queue, ^(size_t index) {
        NSString* subPath = subPaths[index];
        NSString* fromFullPath = [from stringByAppendingPathComponent:subPath];
        NSString* toFullpath = [to stringByAppendingPathComponent:subPath];
        [mgr moveItemAtPath:fromFullPath toPath:toFullpath error:nil];
        NSLog(@"---%@",subPath);
    });


    
}

-(void)moveFile
{
 
    NSString* from = @"/Users/smartwater/Downloads/11";
    NSString* to = @"/Users/smartwater/Downloads/22";
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSArray* subPaths = [mgr subpathsAtPath:from];
    for (NSString* subPath in subPaths) {
        NSString* fromFullPath = [from stringByAppendingPathComponent:subPath];
        NSString* toFullpath = [to stringByAppendingPathComponent:subPath];
        // 剪切
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           [mgr moveItemAtPath:fromFullPath toPath:toFullpath error:nil];
        });
    }
}

-(void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"run------");// 只执行一次
    });// 线程安全，有锁
}
/**
 *  延时执行方式
 */
-(void)delay
{
    NSLog(@"rbegian------");
    // [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    //  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"run------");
    });
}

-(void)run
{
    NSLog(@"run------");
}

-(void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"----barrier-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@",[NSThread currentThread]);
    });
}


@end
