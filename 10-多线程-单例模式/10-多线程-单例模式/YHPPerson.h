//
//  YHPPerson.h
//  10-多线程-单例模式
//
//  Created by yhp on 16/7/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPPerson : NSObject
/** 名字 */
@property(nonatomic,strong)NSString* name;

+(instancetype)sharePerson;
@end
