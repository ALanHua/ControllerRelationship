//
//  TimeLineViewController.m
//  43-应用间跳转2
//
//  Created by yhp on 2017/4/24.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "TimeLineViewController.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)backToApp:(UIButton *)sender {
    // 获取到对应程序的URL
    //NSRange range = [self.urlString rangeOfString:@"?"];
    NSString* urlSchemeString = [[self.urlString componentsSeparatedByString:@"?"]lastObject];
    NSString* urlString = [urlSchemeString stringByAppendingString:@"://"];
    NSURL* url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
    }
}


@end
