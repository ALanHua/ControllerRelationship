//
//  YHPVideo.h
//  22-网络-JSON解析
//
//  Created by yhp on 16/8/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPVideo : NSObject

/** name */
@property(nonatomic,copy)NSString* name;
/** video length */
@property(nonatomic,assign)NSInteger length;
/** image */
@property(nonatomic,copy)NSString* image;
/** url */
@property(nonatomic,copy)NSString* url;



//+(instancetype)videoWithDict:(NSDictionary*)dict;

@end
