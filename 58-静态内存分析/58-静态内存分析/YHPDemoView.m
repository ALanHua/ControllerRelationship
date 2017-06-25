//
//  YHPDemoView.m
//  58-静态内存分析
//
//  Created by yhp on 2017/6/25.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPDemoView.h"

@implementation YHPDemoView

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, rect);
    CGContextAddPath(context, path);
    [[UIColor redColor] set];
    CGPathRelease(path);
    CGContextDrawPath(context, kCGPathFill);
    
    
}

@end
