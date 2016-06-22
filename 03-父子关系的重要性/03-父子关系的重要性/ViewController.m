//
//  ViewController.m
//  03-父子关系的重要性
//
//  Created by yhp on 16/6/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPTempViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YHPTempViewController* temp = [[YHPTempViewController alloc]init];
    [self presentViewController:temp animated:YES completion:nil];
    
}

@end
