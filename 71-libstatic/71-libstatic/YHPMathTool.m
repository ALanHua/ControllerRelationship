//
//  YHPMathTool.m
//  71-libstatic
//
//  Created by yhp on 2017/7/13.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPMathTool.h"

@implementation YHPMathTool

/*
 静态库合并
 lipo -create Debug-iphoneos/lib71-libstatic.a Debug-iphonesimulator/lib71-libstatic.a -output libstatic.a
 查看静态库信息
 lips - info  *.a
 */

+(NSInteger)sumNum1:(NSInteger)num1 num2:(NSInteger)num2
{
    return num1 + num2;
}

@end
