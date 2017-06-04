//
//  YHPLrcLine.h
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPLrcLine : NSObject
/** text */
@property(nonatomic,copy)NSString* text;
/** time */
@property(nonatomic,assign)NSTimeInterval time;

-(instancetype)initWithLrcLineString:(NSString*)lrcLineString;
+(instancetype)lrcLineWithLrcLineString:(NSString*)lrcLineString;

@end
