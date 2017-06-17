//
//  YHPVideoPlayView.m
//  55-AVPlayer的封装
//
//  Created by yhp on 2017/6/14.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPVideoPlayView.h"
#import <AVFoundation/AVFoundation.h>

@interface YHPVideoPlayView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

// 属性
/** 播放器 */
@property(nonatomic,strong)AVPlayer* player;
/** 播放器的layer */
@property(nonatomic,strong)AVPlayerLayer* playerLayer;
/** playerItem */
@property(nonatomic,strong)AVPlayerItem* playItem;

/** 记录当前是否显示工具栏 */
@property(nonatomic,assign)BOOL isShowToolView;
/** 定时器 */
@property(nonatomic,strong)NSTimer* progressTimer;
/** 工具栏的显示和隐藏定时器 */
@property(nonatomic,strong)NSTimer* showTimer;
/** 工具栏显示时间 */
@property(nonatomic,assign)NSTimeInterval showTime;

#pragma mark - 监听点击事件
- (IBAction)playOrPause:(UIButton *)sender;
- (IBAction)switchOrientation:(UIButton *)sender;
- (IBAction)slider:(UISlider *)sender;
- (IBAction)startSlider:(UISlider *)sender;
- (IBAction)sliderValueChange:(UISlider *)sender;
// 手势
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
- (IBAction)swipeAction:(UISwipeGestureRecognizer*)sender;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;

@end

@implementation YHPVideoPlayView

#pragma mark -  快速创建YHPVideoPlayView
+ (instancetype)videoPlayView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 初始化Player和layer
    self.player = [[AVPlayer alloc]init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // 添加layer到imageview上
    [self.imageView.layer addSublayer:self.playerLayer];
    
    // 设置工具栏状态
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    // 设置进度条的内容
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];// 设置滑块的图片
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    // 设置按钮状态
    self.playOrPauseBtn.selected = YES;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    NSURL* url = [NSURL URLWithString:urlString];
    AVPlayerItem* item = [AVPlayerItem playerItemWithURL:url];
    self.playItem = item;
    [self.player replaceCurrentItemWithPlayerItem:self.playItem];
    [self.playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.player play];
}
#pragma mark - 观察者对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey]integerValue];
        if (AVPlayerItemStatusReadyToPlay == status) {
            [self removeProgressTimer];
            [self addProgressTimer];
        }else{
            [self removeProgressTimer];
        }
    }
}
#pragma mark - 定时器(播放时间进度文本时间刷新)
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

-(void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

/**
 更新timeLabel时间显示
 */
-(void)updateProgressInfo
{
    self.timeLabel.text = [self timeString];
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
}

-(NSString*)timeString
{
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    return [self stringWithCurrentTime:currentTime duration:duration];
}

/**
 时间装换
 @param currentTime 当前时间
 @param duration 持续时间
 @return 字符串时间
 */
-(NSString*)stringWithCurrentTime:(NSTimeInterval)currentTime duration: (NSTimeInterval)duration
{
    NSInteger dMin = (NSInteger)duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = (NSInteger)currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSString* durationString = [NSString stringWithFormat:@"%02ld::%02ld",dMin,dSec];
    NSString* currentnString = [NSString stringWithFormat:@"%02ld::%02ld",cMin,cSec];
    
    return [NSString stringWithFormat:@"%@/%@",durationString,currentnString];
}

#pragma mark - 定时器(工具栏的显示和隐藏)
-(void)addShowTimer
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.showTimer forMode:NSRunLoopCommonModes];
}

-(void)removeShowTimer
{
    [self.showTimer invalidate];
    self.showTimer = nil;
}
-(void)updateShowTime
{
    self.showTime += 1;
    if (self.showTime > 2.0) {
        [self tapAction:nil];
        [self removeShowTimer];
        self.showTime = 0;
    }
}

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}



#pragma mark - 监听点击事件
/**
 按钮及滑块点击事件
 */
- (IBAction)playOrPause:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
        [self addProgressTimer];
    }else{
        [self.player pause];
        [self removeProgressTimer];
    }
}

- (IBAction)slider:(UISlider *)sender {
    [self addProgressTimer];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    
    [self.player seekToTime:CMTimeMake(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)startSlider:(UISlider *)sender {
    [self removeProgressTimer];
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    self.timeLabel.text = [self stringWithCurrentTime:currentTime duration:duration];
}
// 全屏展示
- (IBAction)switchOrientation:(UIButton *)sender{
    
}

#pragma mark - 手势

-(void)showToolView:(BOOL)isShow
{
    [UIView animateWithDuration:0.5 animations:^{
        self.toolView.alpha = !self.isShowToolView;
        self.isShowToolView = !self.isShowToolView;
    }];
}
// 轻拍
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self showToolView:!self.isShowToolView];
    if (self.isShowToolView) {
        [self addShowTimer];
    }
}

-(void)swipeToRight:(BOOL)isRight
{
    // 获取当前播放的时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    if (isRight) {
        currentTime += 10;
    }else{
        currentTime -= 10;
    }
    
    if (currentTime >= CMTimeGetSeconds(self.player.currentItem.duration)) {
        currentTime = CMTimeGetSeconds(self.player.currentItem.duration) - 1;
    } else if (currentTime <= 0) {
        currentTime = 0;
    }
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self updateProgressInfo];
}

- (IBAction)swipeAction:(UISwipeGestureRecognizer*)sender {
    [self swipeToRight:YES];
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self swipeToRight:NO];
}
@end
