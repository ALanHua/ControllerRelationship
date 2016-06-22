//
//  ViewController.m
//  04-父子关系补充
//
//  Created by yhp on 16/6/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

/**
 * 当前控制器已经被添加到某个父控制器器上时会调用这个方法
 */
- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    if ([parent isKindOfClass:[UINavigationController class]]) {
        
    }
    
    NSLog(@"didMoveToParentViewController--%@",parent);
    
}


@end
