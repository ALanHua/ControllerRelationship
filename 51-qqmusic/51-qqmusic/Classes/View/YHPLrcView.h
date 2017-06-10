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


/**
 设置tableView的属性 这些属性必须在ViewDidAppear中设置不然不起作用
 @param style tabeleView Cell 分割线模式
 @param color 背景颜色
 */
- (void)setUpInterTableViewSeparatorStyle:(UITableViewCellSeparatorStyle)style withInterTableViewBackgroundColor:(UIColor*)color;
@end
