//
//  ViewController.m
//  46-本地通知
//
//  Created by yhp on 2017/5/7.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)fireLocalNote:(UIButton *)sender {
    // 1，创建本地通知
    UILocalNotification* localNote = [[UILocalNotification alloc]init];
    // 2,设置本地通知的内容
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    localNote.alertBody = @"吃饭了吗";
    // 设置滑块的文字
    localNote.alertAction = @"快点";
//    localNote.hasAction  = YES;
    localNote.alertTitle = @"1222777";
    // 设置音效
    localNote.soundName = UILocalNotificationDefaultSoundName;
    // 设置图标数字
    localNote.applicationIconBadgeNumber = 100;
    // 设置额外信息
    localNote.userInfo = @{@"type":@1};
    // 3,调用通知
    [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
