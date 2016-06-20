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

@interface ViewController ()

/** 控制器 */
@property(nonatomic,strong)YHPOneViewController* one;
@property(nonatomic,strong)YHPTwoViewController* two;
@property(nonatomic,strong)YHPThreeViewController* three;

@end

@implementation ViewController

/**
 *  显示OneViewController
 */
- (IBAction)oneClick {
    if (self.one == nil) {
        self.one = [[YHPOneViewController alloc]init];
        self.one.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }
    
    [self.two.view removeFromSuperview];
    [self.three.view removeFromSuperview];
    
    [self.view addSubview: self.one.view];
    
}

/**
 *  显示TwoViewController
 */
- (IBAction)twoClick {
    
    if (self.two == nil) {
        self.two = [[YHPTwoViewController alloc]init];
        self.two.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }
    
    [self.one.view removeFromSuperview];
    [self.three.view removeFromSuperview];
    [self.view addSubview: self.two.view];// 加了100次，其实也就加了1次
}

/**
 *  显示ThreeViewController
 */
- (IBAction)threeClick {
    
    if (self.three == nil) {
        self.three = [[YHPThreeViewController alloc]init];
        self.three.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }
    
    [self.one.view removeFromSuperview];
    [self.two.view removeFromSuperview];
    [self.view addSubview:self.three.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  1,上面点按创建控制器的代码有问题
 */

@end
