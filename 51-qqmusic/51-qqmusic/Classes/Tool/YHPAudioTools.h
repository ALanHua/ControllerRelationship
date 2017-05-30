//
//  YHPAudioTools.h
//  49-播放音效
//
//  Created by yhp on 2017/5/24.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface YHPAudioTools : NSObject

/**
 录音
 */
+(void)playSoundWithSoundName:(NSString*)soundName;

/**
 播放音乐
 */
+(AVAudioPlayer*)playMusicWithMusicName:(NSString*)musicName;
+(void)stopMusicWithMusicName:(NSString*)musicName;
+(void)pauseMusicWithMusicName:(NSString*)musicName;
@end
