//
//  AppDelegate.m
//  39-网络-网页相关
//
//  Created by yhp on 16/8/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate

/**
 *  崩溃统计：
 *  1,友盟
 *  2，Flurry
 *  3,Crashlytics
 */

/*
 *  拦截异常
 */
void handleException2(NSException* exception)
{
   
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    info[@"callStack"] =  [exception callStackSymbols];// 调用栈信息，错误来源
    info[@"name"] = [exception name];  // 异常名字
    info[@"reason"] = [exception reason]; // 报错理由
    // 写入沙盒
}
-(void)handle
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"sb Project" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
    // 重新启动RunLoop
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}

void handleException(NSException* exception)
{
    [[UIApplication sharedApplication].delegate performSelector:@selector(handle)];
}

#pragma mark - <UIAlertViewDelegate>
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    exit(0);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 读取沙盒信息
    
    // 设置捕获异常回调
    NSSetUncaughtExceptionHandler(handleException);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
