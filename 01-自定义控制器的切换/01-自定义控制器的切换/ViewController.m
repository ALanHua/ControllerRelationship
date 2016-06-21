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

#define CONTROLLER_VIEW_WIDTH(vc) (vc.view.frame.size.width)
#define CONTROLLER_VIEW_HEIGHT(vc) (vc.view.frame.size.height)


@interface ViewController ()
// 正在显示的控制器
@property(nonatomic,weak)UIViewController* showingVc;
/** 存放控制器的数组 */
@property(nonatomic,strong)NSArray* allVces;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allVces = @[
                     [[YHPOneViewController alloc]init],
                     [[YHPTwoViewController alloc]init],
                     [[YHPThreeViewController alloc]init]
                     ];
}


/**
 *  优化版本
 *  @param sender 核心代码
 */
- (IBAction)buttonClick:(UIButton *)sender {
    
    [self.showingVc.view removeFromSuperview];
    
    //  获取控制器的索引
    NSUInteger index = [sender.superview.subviews indexOfObject:sender];
    self.showingVc = self.allVces[index];
    self.showingVc.view.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
    [self.view addSubview: self.showingVc.view];
    
}



///**
// *  显示OneViewController
// */
//- (IBAction)oneClick {
//    
//    [self.showingVc.view removeFromSuperview];
//    /**
//     *  注意点，数组中 [self.allVces[0].view 该语法
//     */
//    self.showingVc = self.allVces[0];
//    self.showingVc.view.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
//    [self.view addSubview: self.showingVc.view];
//    
//}
//
///**
// *  显示TwoViewController
// */
//- (IBAction)twoClick {
//     [self.showingVc.view removeFromSuperview];
//    self.showingVc = self.allVces[1];
//    self.showingVc.view.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
//    [self.view addSubview: self.showingVc.view];
//}
//
///**
// *  显示ThreeViewController
// */
//- (IBAction)threeClick {
//    [self.showingVc.view removeFromSuperview];
//    self.showingVc = self.allVces[2];
//    self.showingVc.view.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
//    [self.view addSubview: self.showingVc.view];
//}


@end
