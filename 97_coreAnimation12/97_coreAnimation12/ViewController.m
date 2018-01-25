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
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    
    self.layerView.layer.affineTransform = transform;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
