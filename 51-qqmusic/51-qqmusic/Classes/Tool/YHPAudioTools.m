//
//  YHPAudioTools.m
//  49-播放音效
//
//  Created by yhp on 2017/5/24.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPAudioTools.h"

@implementation YHPAudioTools

static NSMutableDictionary* _soundIDs;
static NSMutableDictionary* _players;

+(void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
    _players  = [NSMutableDictionary dictionary];
}

//+ (NSMutableDictionary*)soundIDs
//{
//    if (_soundIDs == nil) {
//        _soundIDs = [NSMutableDictionary dictionary];
//    }
//    return _soundIDs;
//}

+(void)playSoundWithSoundName:(NSString*)soundName
{
    SystemSoundID soundID = 0;
    
    soundID = (SystemSoundID)[_soundIDs[soundName] unsignedIntegerValue];
    if (soundID == 0) {
        // 创建SystemSoundID
        NSURL* url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef _Nonnull)(url);
        if (!urlRef) {
            return;
        }
        AudioServicesCreateSystemSoundID(urlRef, &soundID);
        // 存入字典
        [_soundIDs setObject:@(soundID) forKey:soundName];
    }
    
    AudioServicesPlaySystemSound(soundID);
}

+(AVAudioPlayer*)playMusicWithMusicName:(NSString*)musicName
{
    assert(musicName);
    // 定义一个播放器
    AVAudioPlayer* player = nil;
    // 从字典中去player
    player = _players[musicName];
    if (!player) {
        // 创建播放器
        NSURL* fileUrl = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        if (!fileUrl) {
            return nil;
        }
        // 创建播放器
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
        [player prepareToPlay];
        // 存入字典
        [_players setObject:player forKey:musicName];
    }
    // 播放音乐
    [player play];
    
    return player;
}

+(void)stopMusicWithMusicName:(NSString*)musicName
{
    assert(musicName);
    AVAudioPlayer*  player = _players[musicName];
    if (player) {
        [player stop];
        [_players removeObjectForKey:musicName];
        player = nil;
    }
}
+(void)pauseMusicWithMusicName:(NSString*)musicName
{
    assert(musicName);
    AVAudioPlayer*  player = _players[musicName];
    if (player) {
        [player pause];
    }
}

@end
