//
//  ViewController.m
//  03-多线程-NSThread
//
//  Created by yhp on 16/7/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self createThread3];
}


-(void)createThread3
{
    [self performSelectorInBackground:@selector(run:) withObject:@"YHP"];
}

-(void)createThread2
{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"yhp"];
}

-(void)createThread1
{
    //    NSThread* thread = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"jack"];
    //    [thread start];
    YHPThread* thread = [[YHPThread alloc]initWithTarget:self selector:@selector(run:) object:@"jack"];
    thread.name = @"my_thread";
    [thread start];
}
-(void)run:(NSString*)param
{
    NSLog(@"----run---%@---%@",param,[NSThread mainThread]);
}

@end
