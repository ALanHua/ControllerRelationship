//
//  YHPHomeLabel.m
//  08-新闻首页
//
//  Created by yhp on 16/7/3.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHomeLabel.h"

#define YHPRed    0
#define YHPGreen  0
#define YHPBlue   0

@implementation YHPHomeLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor colorWithRed:YHPRed green:YHPGreen blue:YHPBlue  alpha:1.0];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    //        R   G    B
    //  默认   0.4  0.6 0。7
    //  红色   1   0   0
    CGFloat red   = YHPRed + (1 - YHPRed)* scale;
    CGFloat green = YHPGreen + (0 - YHPGreen)* scale;
    CGFloat blue  = YHPBlue + (0 - YHPBlue)* scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    CGFloat transformScale = 1 + scale * 0.3;// 比例范围 1 - 1.3
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    
}


@end
