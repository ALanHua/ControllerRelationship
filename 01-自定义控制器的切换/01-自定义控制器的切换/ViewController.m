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

@end

@implementation ViewController

/**
 *  [a.view addSubView b.view]
 *  [a addChildViewController:b]
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     addChildViewController 会将控制器存放在self.childViewControllers
     */
    [self addChildViewController:[[YHPOneViewController alloc]init]];
    [self addChildViewController:[[YHPTwoViewController alloc]init]];
    [self addChildViewController:[[YHPThreeViewController alloc]init]];
    
    //  将控制器从父控制器中移除
//    [self.childViewControllers[0] removeFromParentViewController];
}


/**
 *  优化版本
 *  @param sender 核心代码
 */
- (IBAction)buttonClick:(UIButton *)sender {
    
    [self.showingVc.view removeFromSuperview];
    
    //  获取控制器的索引
    NSUInteger index = [sender.superview.subviews indexOfObject:sender];
    self.showingVc = self.childViewControllers[index];
    self.showingVc.view.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
    [self.view addSubview: self.showingVc.view];
    
}
/**
 *  屏幕即将某个方向时调用
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@,rotate",self.class);
}


@end
