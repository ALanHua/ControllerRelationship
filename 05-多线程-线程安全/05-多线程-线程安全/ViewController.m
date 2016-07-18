//
//  ViewController.m
//  05-多线程-线程安全
//
//  Created by yhp on 16/7/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 售票员1 */
@property(nonatomic,strong)NSThread* thread01;
/** 售票员2 */
@property(nonatomic,strong)NSThread* thread02;
/** 售票员3 */
@property(nonatomic,strong)NSThread* thread03;

/** 漂的总数 */
@property(nonatomic,assign)NSUInteger ticketCount;

/** 锁对象 */
//@property(nonatomic,strong)NSObject* locker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.locker = [[NSObject alloc]init];
    self.ticketCount = 100;
    
    self.thread01 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTicket) object:nil];
    self.thread01.name = @"售票员01";
    self.thread02 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTicket) object:nil];
    self.thread02.name = @"售票员02";
    self.thread03 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTicket) object:nil];
    self.thread03.name = @"售票员03";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.thread01 start];
    [self.thread02 start];
    [self.thread03 start];
}

-(void)sellTicket
{

    while (1) {
        @synchronized (self) {// 控制器做锁对象
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                NSLog(@"%@卖了-张票，还剩下%zd张", [NSThread currentThread].name,self.ticketCount);
            }else{
                NSLog(@"票卖完了");
                break;
            }
        }
    }
}

@end
