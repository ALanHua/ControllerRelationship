//
//  ViewController.m
//  55-AVPlayer的封装
//
//  Created by yhp on 2017/6/12.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPVideoPlayView.h"

@interface ViewController ()
@property(nonatomic,weak)YHPVideoPlayView* playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupVideoPlayView];
    
    self.playerView.urlString = @"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4";
}

-(void)setupVideoPlayView
{
    YHPVideoPlayView* playView = [YHPVideoPlayView videoPlayView];
    playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view addSubview:playView];
    self.playerView = playView;
    self.playerView.contrainerViewController = self;
}


@end
