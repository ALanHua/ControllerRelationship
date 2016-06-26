//
//  YHPCategroy.m
//  05-级联菜单
//
//  Created by yhp on 16/6/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCategory.h"

@implementation YHPCategory


+(instancetype)categoryWithDict:(NSDictionary*)dict;
{
    YHPCategory* c = [[YHPCategory alloc]init];
    
    [c setValuesForKeysWithDictionary:dict];
    
    return c;
}

@end
