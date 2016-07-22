//
//  YHPCar.m
//  10-多线程-单例模式
//
//  Created by yhp on 16/7/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCar.h"

@interface YHPCar ()

@end

@implementation YHPCar
/**
 *  传统方式
 */
static id _instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    // 加锁,保证线程安全
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }

    return _instance;
}

+(instancetype)shareInstance
{
     // 加锁，保证线程安全
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc]init];
        }
    }

    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
