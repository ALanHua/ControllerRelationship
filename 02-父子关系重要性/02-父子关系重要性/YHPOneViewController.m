//
//  YHPOneViewController.m
//  02-父子关系重要性
//
//  Created by yhp on 16/6/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPOneViewController.h"
#import "YHPTempViewController.h"

@interface YHPOneViewController ()

@end

@implementation YHPOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YHPTempViewController* temp = [[YHPTempViewController alloc]init];
    /**
     *  self.navigationController is nil
     */
    [self.navigationController pushViewController:temp animated:YES];

}

@end
