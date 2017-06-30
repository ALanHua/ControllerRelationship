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

@end
