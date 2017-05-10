//
//  AppDelegate.m
//  47-远程通知
//
//  Created by yhp on 2017/5/10.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        [application registerForRemoteNotifications];
    }else{// ios7
//        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeNewsstandContentAvailability
//         | UIRemoteNotificationTypeAlert
//         | UIRemoteNotificationTypeBadge
//         | UIRemoteNotificationTypeSound];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",deviceToken.description);
}

@end
