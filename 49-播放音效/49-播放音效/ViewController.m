//
//  ViewController.m
//  49-播放音效
//
//  Created by yhp on 2017/5/23.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YHPAudioTools.h"

@interface ViewController ()

/** soundID */
@property(nonatomic,assign)SystemSoundID soundID;
/** 音效文件 */
@property(nonatomic,strong)NSMutableDictionary* soundIDs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buyao:(UIButton *)sender {
//    [self playSoundWithSoundName:@"buyao.wav"];
    [YHPAudioTools playSoundWithSoundName:@"buyao.wav"];
}
- (IBAction)dawang:(UIButton *)sender {
//    [self playSoundWithSoundName:@"m_16.wav"];
    [YHPAudioTools playSoundWithSoundName:@"m_16.wav"];
}
- (IBAction)xiaowang:(UIButton *)sender {
//    [self playSoundWithSoundName:@"m_17.wav"];
    [YHPAudioTools playSoundWithSoundName:@"m_17.wav"];
}

/**
 根据音频文件名播放音效
 @param soundName 音频文件名
 */
-(void)playSoundWithSoundName:(NSString*)soundName
{
    SystemSoundID soundID = 0;
    
    soundID = (SystemSoundID)[self.soundIDs[soundName] unsignedIntegerValue];
    if (soundID == 0) {
        // 创建SystemSoundID
        NSURL* url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef _Nonnull)(url);
        AudioServicesCreateSystemSoundID(urlRef, &soundID);
        // 存入字典
        [self.soundIDs setObject:@(soundID) forKey:soundName];
    }
    
    AudioServicesPlaySystemSound(soundID);
}

- (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}

- (SystemSoundID)soundID
{
    if (_soundID == 0) {
        // 创建SystemSoundID
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"win.aac" withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef _Nonnull)(url);
        AudioServicesCreateSystemSoundID(urlRef, &_soundID);
    }
    
    return _soundID;
}
#pragma mark - 早期
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 播放音效
    //    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlayAlertSound(self.soundID);// 带振动效果
}


@end
