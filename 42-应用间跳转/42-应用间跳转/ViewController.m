//
//  ViewController.m
//  42-应用间跳转
//
//  Created by yhp on 2017/4/22.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

/**
 URL 可以没有路径，但必须有协议头
 默认情况下，应用程序没有URL
 打开应用程序，只要能拿到对应程序的协议头
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)skip {
    [self openURLWithString:@"weixin://"];
}

- (IBAction)skipToTimeline {
   [self openURLWithString:@"weixin://timeline?news"];
}

- (IBAction)skipToSession {
   [self openURLWithString:@"weixin://session?news"];
}

-(void)openURLWithString:(NSString*)url
{
    // 1，获取对应程序的URL
    NSURL* weChatURL = [NSURL URLWithString:url];
    // 2,判断是否安装对应的应用程序
    if ([[UIApplication sharedApplication]canOpenURL:weChatURL]) {
        // 打开应用程序
        [[UIApplication sharedApplication] openURL:weChatURL];
    }
}


@end
