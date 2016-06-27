//
//  ViewController.m
//  07-导航栏细节
//
//  Created by yhp on 16/6/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  打开的话，苹果不会帮你调整
     */
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView* scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, 200, 200);
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:[[UISwitch alloc]init]];
}


@end
