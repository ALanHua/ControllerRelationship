//
//  ViewController.m
//  02-父子关系重要性
//
//  Created by yhp on 16/6/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPTempViewController.h"
#import "YHPOneViewController.h"

@interface ViewController ()

///** one */
//@property(nonatomic,strong)YHPOneViewController* one;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YHPOneViewController* one = [[YHPOneViewController alloc]init];
    one.view.frame = CGRectMake(20, 50, 100, 100);
    [self.view addSubview:one.view];
    [self addChildViewController:one];
    
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    YHPTempViewController* temp = [[YHPTempViewController alloc]init];
//    
//    [self.navigationController pushViewController:temp animated:YES];
//}


@end
