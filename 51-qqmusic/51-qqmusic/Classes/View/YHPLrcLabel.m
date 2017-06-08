//
//  YHPLrcLabel.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/8.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcLabel.h"

@implementation YHPLrcLabel


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 获取要画的区域
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    // 设置颜色
    [[UIColor greenColor] set];
    // 填充区域
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
