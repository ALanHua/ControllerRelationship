//
//  ViewController.m
//  92_coreAnimation07
//
//  Created by yhp on 2018/1/22.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layerView1.layer.cornerRadius = 20.0;
    self.layerView2.layer.cornerRadius = 20.0;
//    边框是跟着图层的边界变化的，而非图层里面的内容
    self.layerView1.layer.borderWidth = 5.0;
    self.layerView2.layer.borderWidth = 5.0;
//    添加阴影
    self.layerView1.layer.shadowOpacity = 0.5;
    self.layerView1.layer.shadowOffset  = CGSizeMake(0, 5.0);
    self.layerView1.layer.shadowRadius  = 5.0;
   
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowOffset  = CGSizeMake(0, 5.0);
    self.shadowView.layer.shadowRadius  = 5.0;
    
    
    self.layerView2.layer.masksToBounds = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
