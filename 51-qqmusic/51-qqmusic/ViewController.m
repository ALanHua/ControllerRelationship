//
//  ViewController.m
//  51-qqmusic
//
//  Created by yhp on 2017/5/26.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加毛玻璃效果
    UITabBar* toolBar = [[UITabBar alloc]init];
    [self.albumView addSubview:toolBar];
    [toolBar setBarStyle:UIBarStyleBlack];
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    // VFL 添加约束
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.albumView.mas_top);
        make.bottom.equalTo(self.albumView.mas_bottom);
        make.left.equalTo(self.albumView.mas_left);
        make.right.equalTo(self.albumView.mas_right);
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
