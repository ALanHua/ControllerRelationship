//
//  ViewController.m
//  44-系统分享
//
//  Created by yhp on 2017/4/25.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 判断平台是否可用
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo       ]) {
        NSLog(@"平台不可用，或者没有相关配置");
        return;
    }
    // 创建分享控制器
    SLComposeViewController* composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    // 添加分享文字
    [composeVc setInitialText:@"我是天才，永远18岁，this is just a joke!!"];
    // 添加图片
    [composeVc addImage:[UIImage imageNamed:@"xiaoxin"]];
    // 弹出分享控制器
    [self presentViewController:composeVc animated:YES completion:^{
        
    }];
    composeVc.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"点击了完成");
        }else if (result == SLComposeViewControllerResultCancelled){
            NSLog(@"点击了取消");
        }
    };
}

@end
