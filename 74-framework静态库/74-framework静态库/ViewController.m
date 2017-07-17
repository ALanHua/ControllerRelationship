//
//  ViewController.m
//  74-framework静态库
//
//  Created by yhp on 2017/7/17.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "MathTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
   NSLog(@"sum:%ld",[MathTool sumNum1:20 num2:30]);
}


@end
