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
#import "NSString+YHPTimeExtension.h"
#import "CALayer+PauseAimate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
/* 滑块*/
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 定时器 */
@property(nonatomic,strong)NSTimer* progressTimer;
/** 当前的播放器 */
@property(nonatomic,strong)AVAudioPlayer* currentPlayer;

@end


@implementation ViewController

#pragma mark - slider 的时间处理
- (IBAction)startSlider {
    [self removeProgressTimer];
}
- (IBAction)sliderValueChange {
    
    self.currentTimeLabel.text = [NSString stringWithTime:self.currentPlayer.duration * self.progressSlider.value];
    
}
- (IBAction)endSlide {
    // 设置歌曲的播放时间
    self.currentPlayer.currentTime = self.currentPlayer.duration * self.progressSlider.value;
    // 添加定时器
    [self addProgressTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    // 获取手势点击位置
    CGPoint point = [sender locationInView:sender.view];
    // 获取点击在slider中的比例
    CGFloat ratio = point.x / self.progressSlider.bounds.size.width;
    // 改变滑块位置
    self. currentPlayer.currentTime = ratio * self.currentPlayer.duration;
    [self updateProgressInfo];
}

#pragma mark - 监听按钮点击
- (IBAction)playOrPause {
    self.playOrPauseBtn.selected = !self.playOrPauseBtn.selected;
    if (self.currentPlayer.isPlaying) {
        [self.currentPlayer pause];
        [self removeProgressTimer];
        [self.iconView.layer pauseAnimate];
    }else{
        [self.currentPlayer play];
        [self addProgressTimer];
        [self.iconView.layer resumeAnimate];
    }
}

- (IBAction)previous {
    YHPMusic* previousMusic = [YHPMusicTool previousMusic];
    [self playingMusicWithMusic:previousMusic];
}

- (IBAction)next {
    YHPMusic* nextMusic = [YHPMusicTool nextMusic];
    [self playingMusicWithMusic:nextMusic];
}

#pragma mark - 加载UIView
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
//        make.top.equalTo(self.albumView.mas_top);
//        make.bottom.equalTo(self.albumView.mas_bottom);
//        make.left.equalTo(self.albumView.mas_left);
//        make.right.equalTo(self.albumView.mas_right);
        make.edges.equalTo(self.albumView);
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
    self.playOrPauseBtn.selected = !self.currentPlayer.isPlaying;
    
    AVAudioPlayer* currentPlayer = [YHPAudioTools playMusicWithMusicName:playingMusic.filename];
    self.totalTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
    self.currentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.currentPlayer = currentPlayer;
    // 开始播放动画
    [self startIconViewAnimation];
}

-(void)playingMusicWithMusic:(YHPMusic*)music
{
    // 停止当前歌曲
    YHPMusic* playingMusic = [YHPMusicTool playingMusic];
    [YHPAudioTools stopMusicWithMusicName:playingMusic.filename];
    // 将工具类中的当前歌曲切换成下一首
    [YHPMusicTool setPlayingMusic:music];
    // 改变界面信息
    [self startPlayingMusic];
}

#pragma mark - 开始IcomView动画
-(void)startIconViewAnimation
{
    // 创建基本动画
    CABasicAnimation* rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设置基本动画属性
    rotateAnim.fromValue   = @(0);
    rotateAnim.toValue     = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration    = 30;
    // 添加动画到图层上
    [self.iconView.layer addAnimation:rotateAnim forKey:nil];
    // 添加定时器
    [self removeProgressTimer];
    [self addProgressTimer];
    
}
#pragma mark - 定时器
-(void)addProgressTimer
{
    [self updateProgressInfo];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
-(void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    
}
#pragma mark - 更新进度界面
-(void)updateProgressInfo
{
    // 设置当前的播放时间
    self.currentTimeLabel.text = [NSString stringWithTime:self.currentPlayer.currentTime];
    // 更新滑块的位置
    self.progressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}

@end
