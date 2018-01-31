//
//  ViewController.m
//  101_coreAnimation16
//
//  Created by yhp on 2018/1/31.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath* path = [[UIBezierPath alloc]init];
//    添加起始点
    [path moveToPoint:CGPointMake(175, 100)];
//    画半径为25的圆形
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2* M_PI clockwise:YES];
//   移动画笔
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
//    创建 shape layer
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth   = 5;
//    线条拐点样式
    shapeLayer.lineJoin    = kCALineJoinRound;
//  kCALineCapRound 在线段头尾添加半径为线段 lineWidth 一半的半圆
    shapeLayer.lineCap     = kCALineCapRound;
    shapeLayer.path        = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
