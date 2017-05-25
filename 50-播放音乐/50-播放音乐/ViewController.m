//
//  ViewController.m
//  50-播放音乐
//
//  Created by yhp on 2017/5/25.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YHPAudioTools.h"

@interface ViewController ()
/** 播放器 */
@property(nonatomic,strong)AVAudioPlayer* player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 播放器懒加载
 @return 播放器
 */
- (AVAudioPlayer *)player
{
    if (!_player) {
        // 取出资源URL
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"235319.mp3" withExtension:nil];
        // 创建播放器
        NSError* error = nil;
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        // 准备播放
        [_player prepareToPlay];
    }
    return _player;
}

/**
播放歌曲
 */
- (IBAction)play:(UIButton *)sender {
//    [self.player play];
    [YHPAudioTools playMusicWithMusicName:@"235319.mp3"];
}
/**
 暂停
 */
- (IBAction)pause:(UIButton *)sender {
//    [self.player pause];
    [YHPAudioTools pauseMusicWithMusicName:@"235319.mp3"];
}
/**
 停止播放歌曲
 */
- (IBAction)stop:(UIButton *)sender {
//     [self.player stop];
//    self.player = nil;
    [YHPAudioTools stopMusicWithMusicName:@"235319.mp3"];
}

- (IBAction)otherMusic:(UIButton *)sender {
    [YHPAudioTools playMusicWithMusicName:@"309769.mp3"];
}


@end
