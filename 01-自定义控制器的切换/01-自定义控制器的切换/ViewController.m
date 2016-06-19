//
//  ViewController.m
//  01-自定义控制器的切换
//
//  Created by yhp on 16/6/19.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
// 子控制器
#import "YHPOneViewController.h"
#import "YHPTwoViewController.h"
#import "YHPThreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 *  显示OneViewController
 */
- (IBAction)oneClick {
    YHPOneViewController* one = [[YHPOneViewController alloc]init];
    
    one.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    [self.view addSubview:one.view];
}

/**
 *  显示TwoViewController
 */
- (IBAction)twoClick {
    
    YHPTwoViewController* two = [[YHPTwoViewController alloc]init];
    two.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    [self.view addSubview:two.view];
}

/**
 *  显示ThreeViewController
 */
- (IBAction)threeClick {
    
    YHPThreeViewController* three = [[YHPThreeViewController alloc]init];
    three.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    [self.view addSubview:three.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
