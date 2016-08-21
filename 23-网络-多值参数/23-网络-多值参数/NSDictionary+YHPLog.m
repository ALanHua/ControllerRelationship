//
//  NSDictionary+YHPLog.m
//  23-网络-多值参数
//
//  Created by yhp on 16/8/21.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (YHPLog)

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString* string = [NSMutableString string];
    // head
    [string appendString:@"\n{"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@",key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n",obj];
    }];
    
    // tail
    [string appendString:@"}"];
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }

    return string;
}
@end


@implementation NSArray(YHPLog)

-(NSString *)descriptionWithLocale:(id)locale
{
     NSMutableString* string = [NSMutableString string];
     // head
     [string appendString:@"["];
    
     [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [string appendFormat:@"\t%@,\n",obj];
     }];
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    // tail
    [string appendString:@"]"];
    return string;
}

@end
