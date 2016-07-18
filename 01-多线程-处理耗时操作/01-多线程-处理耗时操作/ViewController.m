//
//  ViewController.m
//  01-多线程-处理耗时操作
//
//  Created by yhp on 16/7/17.
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

- (IBAction)buttonClick {
//    NSLog(@"%@,%@",[NSThread mainThread],[NSThread currentThread]);
    for (NSInteger i = 0 ; i < 10000; i++) {
        NSLog(@"-----buttonclick:%zd",i);
    }// 这样会阻塞
}

@end
