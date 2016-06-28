//
//  YHPHomeViewController.m
//  08-新闻首页
//
//  Created by yhp on 16/6/28.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHomeViewController.h"

@interface YHPHomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation YHPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 先添加标题
    [self setUpTittle];
    
}

/**
 *  添加标题
 */
 -(void)setUpTittle
{
    CGFloat labelW = 100;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    CGFloat labelY = 0;
    //  添加label
    for (int i = 0; i < 7; i++) {
        UILabel* label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        CGFloat labelX = i * labelW ;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [self randomColor];
        [label addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
        label.userInteractionEnabled = YES;
        [self.titleScrollView addSubview:label];
    }
    //   设置contentSize
    self.titleScrollView.contentSize = CGSizeMake(7 * labelW, 0);
    
}

/**
 *  监听titleScrollView顶部label点击
 *  @param tap 点击手势
 */
-(void)labelClick:(UITapGestureRecognizer*)tap
{
//    NSLog(@"%@",tap.view);
}

/**
 *  产生随机颜色
 *  @return UIColor
 */
-(UIColor*)randomColor
{
    CGFloat r = arc4random_uniform(255) / 255.0;
    CGFloat g = arc4random_uniform(255) / 255.0;
    CGFloat b = arc4random_uniform(255) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
@end
