//
//  YHPLrcTool.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcTool.h"
#import "YHPLrcLine.h"

@implementation YHPLrcTool

+(NSArray *)lrcWithLrcName:(NSString *)lrcName
{
    // 1，拿到歌词路径
    NSString* lrcPath = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
    // 读取歌词
    NSString* lrcString = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    NSArray* lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    // 把每一句歌词转成模型
    NSMutableArray* tempArrary = [NSMutableArray array];
    for (NSString* lrcLineString in lrcArray) {
        /*
          过滤 [ti:] / [ar:] / [al:] / 空格
         */
        if ([lrcLineString hasPrefix:@"[ti:"]
        || [lrcLineString hasPrefix:@"[ar:"]
        || [lrcLineString hasPrefix:@"[al:"]
        || ![lrcLineString hasPrefix:@"["]){
            continue;
        }
        // 转模型
        YHPLrcLine* lrcLine = [YHPLrcLine lrcLineWithLrcLineString:lrcLineString];
        [tempArrary addObject:lrcLine];
    }
    return tempArrary;
}
@end
