//
//  ViewController.m
//  96_coreAnimation11
//
//  Created by yhp on 2018/1/24.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (UIButton*)customButton
{
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton* button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
//    添加label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel* label = [[UILabel alloc]initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* buttton1 = [self customButton];
    buttton1.center = CGPointMake(75, 150);
    [self.containerView addSubview:buttton1];
    
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.containerView addSubview:button2];
//    设置组透明
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
