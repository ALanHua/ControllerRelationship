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
    NSLog(@"----run-----");
    // port 就相当于source
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
    NSLog(@"----end-----");
//    [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate distantFuture]];
}

-(void)test
{
    NSLog(@"-----%p",[NSRunLoop currentRunLoop]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)useImageView
{
    // 只在NSDefaultRunLoopMode 模式下显示图片
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"aa"] afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
    
    
}

@end
