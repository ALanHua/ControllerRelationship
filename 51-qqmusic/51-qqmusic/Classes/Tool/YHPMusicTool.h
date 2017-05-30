//
//  YHPMusicTool.h
//  51-qqmusic
//
//  Created by yhp on 2017/5/30.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHPMusic;

@interface YHPMusicTool : NSObject

+(NSArray*)musics;
+(YHPMusic*)playingMusic;
+(void)setPlayingMusic:(YHPMusic*)playingMusic;
+(YHPMusic*)nextMusic;
+(YHPMusic*)previousMusic;

@end
