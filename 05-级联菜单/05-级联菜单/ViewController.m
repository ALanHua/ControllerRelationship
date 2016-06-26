//
//  ViewController.m
//  05-级联菜单
//
//  Created by yhp on 16/6/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPCategroyViewController.h"
#import "YHPSubCategroyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width   = self.view.frame.size.width * 0.5;
    CGFloat height = self.view.frame.size.height;
    
    YHPSubCategroyViewController* subCategroyVc = [[YHPSubCategroyViewController alloc]init];
    subCategroyVc.view.frame = CGRectMake(width, 0, width, height);
    [self addChildViewController:subCategroyVc];
    [self.view addSubview:subCategroyVc.view];
    
    YHPCategroyViewController* categroyVc = [[YHPCategroyViewController alloc]init];
    categroyVc.view.frame = CGRectMake(0, 0, width, height);
    categroyVc.delegate = subCategroyVc;
    [self addChildViewController:categroyVc];
    [self.view addSubview:categroyVc.view];
    
    
}


@end
