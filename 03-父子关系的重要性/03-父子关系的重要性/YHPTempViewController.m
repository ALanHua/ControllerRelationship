//
//  YHPTempViewController.m
//  02-父子关系重要性
//
//  Created by yhp on 16/6/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTempViewController.h"
#import "YHPOneViewController.h"

@interface YHPTempViewController ()

@end

@implementation YHPTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.view = 600x600 -> 375x667
    // one.view = 100x100 -> 缩小x增大
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));

    
    YHPOneViewController* one = [[YHPOneViewController alloc]init];
    one.view.frame = CGRectMake(20, 50, 100, 100);
    /**
     默认情况下，所有控制器的view的autoresizingMask都包含了UIViewAutoresizingFlexibleWidth
     和UIViewAutoresizingFlexibleHeight两个值
     */
    one.view.autoresizingMask = UIViewAutoresizingNone;
    
    [self.view addSubview:one.view];
    [self addChildViewController:one];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
