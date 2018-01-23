//
//  ViewController.m
//  93_coreAnimation08
//
//  Created by yhp on 2018/1/23.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *layerView1;
@property (weak, nonatomic) IBOutlet UIImageView *layerView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    使能shadow
    self.layerView1.layer.shadowOpacity = 0.5;
    self.layerView2.layer.shadowOpacity = 0.5;
    
//  矩形阴影
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
//  环形阴影
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    self.layerView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
