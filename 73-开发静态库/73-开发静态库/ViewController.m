//
//  ViewController.m
//  73-开发静态库
//
//  Created by yhp on 2017/7/17.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPMathTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"sum:%ld",[YHPMathTool sumNum1:20 num2:30]);
}


@end
