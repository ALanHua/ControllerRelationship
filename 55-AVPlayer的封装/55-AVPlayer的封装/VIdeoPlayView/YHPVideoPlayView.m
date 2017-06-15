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
/** 记录当前是否显示工具栏 */
@property(nonatomic,assign)BOOL isShowToolView;
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
    
}

#pragma mark - 监听点击事件
/**
 按钮及滑块点击事件
 */
- (IBAction)playOrPause:(UIButton *)sender{
    
}
- (IBAction)switchOrientation:(UIButton *)sender{
    
}
- (IBAction)slider:(UISlider *)sender {
}

- (IBAction)startSlider:(UISlider *)sender {
}

- (IBAction)sliderValueChange:(UISlider *)sender {
}
/**
 手势事件
 */
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
}

- (IBAction)swipeAction:(UISwipeGestureRecognizer*)sender {
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
}
@end
