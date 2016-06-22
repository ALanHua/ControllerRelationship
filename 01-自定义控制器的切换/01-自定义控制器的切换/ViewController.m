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
@property(nonatomic,weak)UIView* contentView;

@end

@implementation ViewController

/**
 *  [a.view addSubView b.view]
 *  [a addChildViewController:b]
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* cotentView = [[UIView alloc]init];
    cotentView.frame = CGRectMake(0, 64,CONTROLLER_VIEW_WIDTH(self) , CONTROLLER_VIEW_HEIGHT(self));
    [self.view addSubview:cotentView];
    self.contentView = cotentView;
    
    [self addChildViewController:[[YHPOneViewController alloc]init]];
    /**
     *  将听 didMoveToParentViewController方法
     */
//    [self.childViewControllers[0] didMoveToParentViewController:self];
    [self addChildViewController:[[YHPTwoViewController alloc]init]];
    [self addChildViewController:[[YHPThreeViewController alloc]init]];
    
    /**
     *  这个歌方法会主动调用 didMoveToParentViewController，并告诉你你将被移动到一个空的父控制器
     */
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
    //  当前的索引
    NSUInteger oldIndex = [self.childViewControllers indexOfObject:self.showingVc];
    self.showingVc = self.childViewControllers[index];
    self.showingVc.view.frame = self.contentView.bounds;
    [self.contentView addSubview: self.showingVc.view];
    
    // 添加转场动画
    CATransition* animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = index > oldIndex ? kCATransitionFromRight :kCATransitionFromLeft;
    animation.duration = 1;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

/**
 *  屏幕即将某个方向时调用
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@,rotate",self.class);
}


@end
