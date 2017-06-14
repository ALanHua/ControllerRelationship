//
//  YHPVideoPlayView.m
//  55-AVPlayer的封装
//
//  Created by yhp on 2017/6/14.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPVideoPlayView.h"

@interface YHPVideoPlayView()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIView *ToolView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


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
