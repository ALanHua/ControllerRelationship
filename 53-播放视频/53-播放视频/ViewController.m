//
//  ViewController.m
//  53-播放视频
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
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"xiaohuangren.mp4" withExtension:nil];
        NSLog(@"%@",url);
//        NSURL* url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
        AVPlayerItem* item = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:item];
     // 给AVPlayerLayer
        AVPlayerLayer* player = [AVPlayerLayer playerLayerWithPlayer:_player];
        player.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 9 / 16);
        [self.view.layer addSublayer:player];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@",self.player);
    [self.player play];
}


@end
