//
//  ViewController.m
//  51-qqmusic
//
//  Created by yhp on 2017/5/26.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "YHPMusicTool.h"
#import "YHPMusic.h"
#import "YHPAudioTools.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/* 滑块*/
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置毛玻璃效果
    [self setUpBlurView];
    // 设置滑块的图片
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"]forState:UIControlStateNormal];
    // 展示界面信息
    [self startPlayingMusic];
    
}

-(void)setUpBlurView
{
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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 设置图片圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 4.0;
    self.iconView.layer.borderColor = [UIColor colorWithRed:36 / 255.0 green:36 / 255.0 blue:36 / 255.0 alpha:1].CGColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 开始播放音乐
-(void)startPlayingMusic
{
    YHPMusic* playingMusic = [YHPMusicTool playingMusic];
    // 设置界面信息
    self.albumView.image = [UIImage imageNamed:playingMusic.icon];
    self.iconView.image = [UIImage imageNamed:playingMusic.icon];
    self.songLabel.text = playingMusic.name;
    self.singerLabel.text = playingMusic.singer;
    
    AVAudioPlayer* currentPlayer = [YHPAudioTools playMusicWithMusicName:playingMusic.filename];
    self.totalTimeLabel.text = [self stringWithTime:currentPlayer.duration];
    self.currentTimeLabel.text = [self stringWithTime:currentPlayer.currentTime];
    
}

-(NSString*)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = (NSInteger)time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,second];
}

@end
