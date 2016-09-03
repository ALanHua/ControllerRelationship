//
//  YHPDownLoadManager.h
//  33-网络-NSURLSession文件下载
//
//  Created by yhp on 16/9/3.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPDownLoadManager : NSObject


+(instancetype)shareInstance;

-(void)download:(NSString*)url;

@end
