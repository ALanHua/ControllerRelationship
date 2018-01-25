//
//  ViewController.m
//  97_coreAnimation12
//
//  Created by yhp on 2018/1/25.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *layerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    CGAffineTransform transform = CGAffineTransformIdentity;
//    缩小50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//   旋转 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI_2);
//   平移200 point
    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    self.layerView.layer.affineTransform = transform;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
