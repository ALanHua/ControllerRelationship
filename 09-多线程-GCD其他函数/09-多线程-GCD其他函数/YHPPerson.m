//
//  YHPPerson.m
//  09-多线程-GCD其他函数
//
//  Created by yhp on 16/7/21.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPPerson.h"

@implementation YHPPerson

-(NSArray *)books
{
    if (_books == nil) {
        _books = @[@"iOS",@"swift"];
    }
    return _books;
}

@end
