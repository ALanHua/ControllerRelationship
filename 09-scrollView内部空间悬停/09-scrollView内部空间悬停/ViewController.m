//
//  ViewController.m
//  09-scrollView内部空间悬停
//
//  Created by yhp on 16/7/3.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.blueView.frame));
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat imageH = self.imageView.frame.size.height;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY >= imageH) {
        CGRect redF = self.redView.frame;
        redF.origin.y = 0;
        self.redView.frame = redF;
        [self.view addSubview:self.redView];
    }else{
        CGRect redF = self.redView.frame;
        redF.origin.y = 140;
        self.redView.frame = redF;
//        NSLog(@"%f", redF.origin.y);
        [self.scrollView addSubview:self.redView];
    }
    
//    CGFloat scale = 1 - (offSetY / 70);
//    scale = (scale >= 1) ? scale : 1;
//    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
   
}

@end
