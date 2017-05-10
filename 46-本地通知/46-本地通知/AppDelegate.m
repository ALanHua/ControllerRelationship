//
//  AppDelegate.m
//  46-本地通知
//
//  Created by yhp on 2017/5/7.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setApplicationIconBadgeNumber:0];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
   
    if (launchOptions[UIApplicationLaunchOptionsLocationKey]) {
         // 界面跳转
        
    }

    return YES;
}


/**
 应用程序从后台进入前台时跳转
 @param application  应用
 @param notification 通知
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if(application.applicationState == UIApplicationStateInactive){
        NSLog(@"进行应用间跳转");
        NSLog(@"%@",notification.userInfo);
    }
    
}


@end
