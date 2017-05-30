//
//  YHPMusicTool.m
//  51-qqmusic
//
//  Created by yhp on 2017/5/30.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPMusicTool.h"
#import "MJExtension.h"
#import "YHPMusic.h"

@implementation YHPMusicTool

static NSArray* _music;
static YHPMusic* _playingMusic;

+ (void)initialize
{
    if (!_music) {
        _music = [YHPMusic mj_objectArrayWithFilename:@"Musics.plist"];
    }
    
    if (!_playingMusic) {
        _playingMusic = _music[1];
    }

}

+(NSArray*)musics
{
    return _music;
}

+(YHPMusic*)playingMusic
{
    return _playingMusic;
}

+(void)setPlayingMusic:(YHPMusic*)playingMusic
{
    _playingMusic = playingMusic;
    
}

+(YHPMusic*)nextMusic
{
    // 拿到当前播放歌曲的小标
    NSInteger currentIndex = [_music indexOfObject:_playingMusic];
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= _music.count) {
        nextIndex = 0;
    }
    return _music[nextIndex];
}

+(YHPMusic*)previousMusic
{
    NSInteger currentIndex = [_music indexOfObject:_playingMusic];
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = _music.count - 1;
    }
    return _music[previousIndex];
}

@end
