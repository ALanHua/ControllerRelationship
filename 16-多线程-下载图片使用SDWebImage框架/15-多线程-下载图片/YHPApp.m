//
//  YHPApp.m
//  15-多线程-下载图片
//
//  Created by yhp on 16/8/6.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPApp.h"

@implementation YHPApp

+(instancetype)appWithDict:(NSDictionary*)dict
{
    YHPApp* app = [[YHPApp alloc]init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}

@end
