//
//  YHPLrcView.h
//  51-qqmusic
//
//  Created by yhp on 2017/6/3.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPLrcLabel;
@interface YHPLrcView : UIScrollView
/** 歌词的名字 */
@property(nonatomic,copy)NSString* lrcName;
/** 当前播放的时间 */
@property(nonatomic,assign)NSTimeInterval currentTime;
/** lrcLabel */
@property(nonatomic,strong)YHPLrcLabel* LrcViewlrcLabel;
/** 当前播放歌曲总时长 */
@property(nonatomic,assign)NSTimeInterval duration;

@end
