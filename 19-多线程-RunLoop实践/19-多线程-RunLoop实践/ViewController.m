//
//  ViewController.m
//  19-多线程-RunLoop实践
//
//  Created by yhp on 16/8/11.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPThread.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 线程对象 */
@property(nonatomic,strong)YHPThread* thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thread = [[YHPThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [self.thread start];
}

-(void)run
{
    /**
     *  内存池会在进入秀面前清掉
     */
    @autoreleasepool {
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]run];
    }

}

-(void)run3
{
    @autoreleasepool {
        NSTimer* timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
    }
    
}

-(void)run2
{
    @autoreleasepool {
        // port 就相当于source
        [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
        NSLog(@"----end-----");
    }
    NSLog(@"----run-----");

//    [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate distantFuture]];
}

-(void)test
{
    NSLog(@"-----%p",[NSRunLoop currentRunLoop]);
}

-(void)test2
{
    NSLog(@"----test2---%p",[NSRunLoop currentRunLoop]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self performSelector:@selector(test2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)useImageView
{
    // 只在NSDefaultRunLoopMode 模式下显示图片
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"aa"] afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
    
    
}

@end
