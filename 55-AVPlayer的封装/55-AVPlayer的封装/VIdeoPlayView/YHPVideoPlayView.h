//
//  YHPVideoPlayView.h
//  55-AVPlayer的封装
//
//  Created by yhp on 2017/6/14.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPVideoPlayView : UIView


/**
 快速创建YHPVideoPlayView
 */
+(instancetype)videoPlayView;
/** 需要播放的视频资源 */
@property (nonatomic,copy) NSString *urlString;

@end
