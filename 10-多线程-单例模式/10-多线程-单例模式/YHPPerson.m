//
//  YHPPerson.m
//  10-多线程-单例模式
//
//  Created by yhp on 16/7/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPPerson.h"

@interface YHPPerson () <NSCopying>

@end

@implementation YHPPerson

static YHPPerson* _person;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _person = [super allocWithZone:zone];
    });
    return _person;
}
/**
 *  单例
 */
+(instancetype)sharePerson
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _person = [[self alloc]init];
    });
    return _person;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _person;
}
@end
