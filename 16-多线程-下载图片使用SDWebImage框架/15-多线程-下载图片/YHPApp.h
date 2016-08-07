//
//  YHPApp.h
//  15-多线程-下载图片
//
//  Created by yhp on 16/8/6.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPApp : NSObject

/** 图标 */
@property(nonatomic,strong)NSString* icon;
/** 下载量 */
@property(nonatomic,strong)NSString* download;
/** 下载量 */
@property(nonatomic,strong)NSString* name;


+(instancetype)appWithDict:(NSDictionary*)dict;

@end
