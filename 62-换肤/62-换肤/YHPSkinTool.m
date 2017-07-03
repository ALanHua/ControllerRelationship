//
//  YHPSkinTool.m
//  62-换肤
//
//  Created by yhp on 2017/6/30.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPSkinTool.h"

static NSString* _skinColor;

@implementation YHPSkinTool

+ (void)initialize
{
    _skinColor = [[NSUserDefaults standardUserDefaults]objectForKey:@"skinColor"];
    if (!_skinColor) {
        _skinColor = @"blue";
    }
}

+(void)setSkinColor:(NSString*)skinColor
{
    _skinColor = skinColor;
    // 记录选中的颜色
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:@"skinColor"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(UIImage*)skinToolWithImageName:(NSString*)imageName
{
    NSString* imagePath = [NSString stringWithFormat:@"skin/%@/%@",_skinColor,imageName];
    return [UIImage imageNamed:imagePath];
}

+(UIColor*)skinToolWithabelColor
{
    // 获取plist 文件路径
    
    NSString* plistName = [NSString stringWithFormat:@"skin/%@/bgColor.plist",_skinColor];
    NSString* plistPath = [[NSBundle mainBundle]pathForResource:plistName ofType:nil];
    // 读取颜色字典
    NSDictionary* colorDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    // 读取颜色的字符串
    NSString* colorString = colorDict[@"labelBgColor"];
    // 获取颜色数组
    NSArray* colorArray = [colorString componentsSeparatedByString:@","];
    NSInteger red = [colorArray[0] integerValue];
    NSInteger green = [colorArray[1] integerValue];
    NSInteger blue = [colorArray[2] integerValue];
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

@end
