//
//  ViewController.m
//  52-播放远程音乐
//
//  Created by yhp on 2017/6/11.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
/** 播放器 */
@property(nonatomic,strong)AVPlayer* player;
@end

@implementation ViewController

- (AVPlayer *)player
{
    if (!_player) {
        NSURL* url = [NSURL URLWithString:@"http://cc.stream.qqmusic.qq.com/C100003j8IiV1X8Oaw.m4a?fromtag=52"];
        AVPlayerItem* item = [AVPlayerItem playerItemWithURL:url];
//        _player = [AVPlayer playerWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:item];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.player play];
}

@end
