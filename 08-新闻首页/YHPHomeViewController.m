//
//  YHPHomeViewController.m
//  08-新闻首页
//
//  Created by yhp on 16/6/28.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHomeViewController.h"
#import "YHPSocialViewController.h"
#import "YHPHomeLabel.h"

@interface YHPHomeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation YHPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setUpChildVc];
    // 先添加标题
    [self setUpTittle];
    // 默认选择第一个
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

/**
 *  添加子控制器
 */
-(void)setUpChildVc
{
    YHPSocialViewController* social0 = [[YHPSocialViewController alloc]init];
    social0.title = @"国际";
    [self addChildViewController:social0];
    
    YHPSocialViewController* social2 = [[YHPSocialViewController alloc]init];
    social2.title = @"军事";
    [self addChildViewController:social2];
    
    YHPSocialViewController* social3 = [[YHPSocialViewController alloc]init];
    social3.title = @"娱乐";
    [self addChildViewController:social3];
    
    YHPSocialViewController* social4 = [[YHPSocialViewController alloc]init];
    social4.title = @"政治";
    [self addChildViewController:social4];
    
    YHPSocialViewController* social5 = [[YHPSocialViewController alloc]init];
    social5.title = @"经济";
    [self addChildViewController:social5];
    
    YHPSocialViewController* social6 = [[YHPSocialViewController alloc]init];
    social6.title = @"动漫";
    [self addChildViewController:social6];
    
    YHPSocialViewController* social7 = [[YHPSocialViewController alloc]init];
    social7.title = @"科技";
    [self addChildViewController:social7];
    
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
    for (NSInteger i = 0; i < 7; i++) {
        YHPHomeLabel* label = [[YHPHomeLabel alloc]init];
        label.text = self.childViewControllers[i].title;
        CGFloat labelX = i * labelW ;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        if (i == 0) {
            label.scale = 1.0;
        }
    }
    //   设置contentSize 
    self.titleScrollView.contentSize = CGSizeMake(7 * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(7 * [UIScreen mainScreen].bounds.size.width,0);
//    self.contentScrollView.autoresizingMask = NO;
}
/**
 *  监听titleScrollView顶部label点击
 *  @param tap 点击手势
 */
-(void)labelClick:(UITapGestureRecognizer*)tap
{
//    [self.titleScrollView.subviews indexOfObject:tap.view];
    NSInteger index =  tap.view.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];

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

#pragma mark -- <UIScrollViewDelegate>

/**
 *  ScrollView结束动画滚动结束以后
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //  新控制器的索引
    CGFloat width = scrollView.frame.size.width;// 600 ,约束后375
    CGFloat height = scrollView.frame.size.height;
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset / width;
    
    //  让对应的顶部的标题居中显示
    YHPHomeLabel* label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x < 0) {
        titleOffset.x = 0;
    }else if(titleOffset.x > maxTitleOffsetX){
        titleOffset.x = maxTitleOffsetX;
    }
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    // 取出需要显示的控制器
    UIViewController* willShowVc = self.childViewControllers[index];
    //    如果现实过了就直接返回
    if (willShowVc.view.superview) {
        return;
    }
    // 添加控制器的View到contentScrollView中
//    willShowVc.view.autoresizingMask = UIViewAutoresizingNone;
    willShowVc.view.frame = CGRectMake(offset, -64, width, height);
    [scrollView addSubview:willShowVc.view];
    
}

/**
 *  手指松开ScrollView，ScrollView停止减速完毕就会调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidEndDecelerating");
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 *  实时监听 scrollView拖拽
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    left
    NSInteger leftIndex = scale;
    YHPHomeLabel* leftLabel = self.titleScrollView.subviews[leftIndex];
    NSInteger rightIndex = leftIndex + 1;
    YHPHomeLabel* rightLabel = (rightIndex > self.titleScrollView.subviews.count - 1) ?nil : self.titleScrollView.subviews[rightIndex];
    //左右比例
    CGFloat  rightScale = scale - leftIndex;
    CGFloat  leftScale  = 1 - rightScale;
    //  设置比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}

@end
