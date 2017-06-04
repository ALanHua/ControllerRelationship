//
//  YHPLrcLine.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcLine.h"

@implementation YHPLrcLine

-(instancetype)initWithLrcLineString:(NSString*)lrcLineString
{
    if (self = [super init]) {
        // [00:00.89]传奇
        NSArray* lrcArray = [lrcLineString componentsSeparatedByString:@"]"];
        self.text = lrcArray[1];
        NSString* timeString = lrcArray[0];
        self.time = [self timeStringWithString:[timeString substringFromIndex:1]];
    }
    return self;
}

+(instancetype)lrcLineWithLrcLineString:(NSString*)lrcLineString
{
    return [[self alloc]initWithLrcLineString:lrcLineString];
}

#pragma mark - 时间提取
- (NSTimeInterval)timeStringWithString:(NSString*)timeString
{
    NSInteger min = [[timeString componentsSeparatedByString:@":"][0] integerValue];
    NSInteger second = [[[timeString componentsSeparatedByString:@"."][0] componentsSeparatedByString:@":"][1] integerValue];
    NSUInteger millisecond = [[timeString componentsSeparatedByString:@"."][1] integerValue];
    
    return  min * 60 + second + millisecond * 0.01;
}

@end
