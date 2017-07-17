//
//  ViewController.m
//  72-静态库的使用
//
//  Created by yhp on 2017/7/13.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPMathTool.h"
#import <mathTool.framework/MathTool.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"sum:%ld",[YHPMathTool sumNum1:20 num2:30]);
    
    NSLog(@"sum:%ld",[MathTool sumNum1:20 num2:30]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
