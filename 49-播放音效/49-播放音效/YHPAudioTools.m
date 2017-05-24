//
//  YHPAudioTools.m
//  49-播放音效
//
//  Created by yhp on 2017/5/24.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPAudioTools.h"
#import <AVFoundation/AVFoundation.h>

@implementation YHPAudioTools

static NSMutableDictionary* _soundIDs;


+(void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
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
        AudioServicesCreateSystemSoundID(urlRef, &soundID);
        // 存入字典
        [_soundIDs setObject:@(soundID) forKey:soundName];
    }
    
    AudioServicesPlaySystemSound(soundID);
}

@end
