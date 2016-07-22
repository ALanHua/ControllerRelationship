//
//  ViewController.m
//  10-多线程-单例模式
//
//  Created by yhp on 16/7/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YHPPerson* p1 = [[YHPPerson alloc]init];
    p1.name = @"swift";
    YHPPerson* p2 = [[YHPPerson alloc]init];
    YHPPerson* p3 = [[YHPPerson alloc]init];
    YHPPerson* p4 = [[YHPPerson alloc]init];
    NSLog(@"%p,%p,%p,%p",p1,p2,p3,p4);
    NSLog(@"%@,%@,%@,%@",p1.name,p2.name,p3.name,p4.name);
    NSLog(@"%@,%@",[YHPPerson sharePerson],[YHPPerson sharePerson]);
    
}


@end