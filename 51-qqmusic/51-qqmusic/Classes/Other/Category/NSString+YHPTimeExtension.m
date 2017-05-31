//
//  NSString+YHPTimeExtension.m
//  51-qqmusic
//
//  Created by yhp on 2017/5/31.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "NSString+YHPTimeExtension.h"

@implementation NSString (YHPTimeExtension)

+(NSString*)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = (NSInteger)time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,second];
}


@end
