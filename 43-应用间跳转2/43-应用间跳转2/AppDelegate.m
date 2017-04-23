//
//  AppDelegate.m
//  43-应用间跳转2
//
//  Created by yhp on 2017/4/22.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // url 转成字符串
    NSString* urlString = url.absoluteString;
    // 获取控制器
    UINavigationController* rootNav = (UINavigationController*)self.window.rootViewController;
    ViewController* homeVc = [rootNav.childViewControllers firstObject];
    
    if ([urlString containsString:@"session"]) {
        [homeVc performSegueWithIdentifier:@"homeToSession" sender:nil];
    }else if ([urlString containsString:@"timeline"]){
        [homeVc performSegueWithIdentifier:@"honeToTimeline" sender:nil];
    }
    
    return YES;
}


@end
