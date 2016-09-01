//
//  main.m
//  39-网络-网页相关
//
//  Created by yhp on 16/8/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }

}
/**
 *  非主流
 */
void tryCatchMainException(void)
{
    @try {
//        @autoreleasepool {
//            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//        }
    } @catch (NSException *exception) {
        NSLog(@"-----%@",exception);
    } @finally {
        
    }
}
