//
//  ViewController.m
//  54-MediaPlayer
//
//  Created by yhp on 2017/6/11.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
//#import <AVKit/AVKit.h>

@interface ViewController ()
/** 播放器 */
@property(nonatomic,strong)MPMoviePlayerController* playerController;
/** 播放器2 */
@property(nonatomic,strong)MPMoviePlayerViewController* playerVc;
@end

@implementation ViewController

- (MPMoviePlayerController *)playerController
{
    if (!_playerController) {
        NSURL* url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
        _playerController = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _playerController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 /16);
        [self.view addSubview:_playerController.view];
        _playerController.controlStyle = MPMovieControlStyleNone;
    }
    return _playerController;
}

- (MPMoviePlayerViewController *)playerVc
{
    if (!_playerVc) {
         NSURL* url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
        _playerVc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    }
    return _playerVc;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.playerController play];
    
}
- (IBAction)playMovie:(UIButton *)sender {
    [self presentMoviePlayerViewControllerAnimated:self.playerVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(next) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)next
{
    self.playerController.contentURL = nil;
    [self.playerController play];
}

@end
