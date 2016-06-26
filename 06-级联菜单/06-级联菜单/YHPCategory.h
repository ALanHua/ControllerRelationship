//
//  YHPCategroy.h
//  05-级联菜单
//
//  Created by yhp on 16/6/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPCategory : NSObject

/** 子类别 */
@property(nonatomic,strong)NSArray* subcategories;
/** 姓名 */
@property(nonatomic,strong)NSString* name;
/** 图标 */
@property(nonatomic,strong)NSString* icon;
/** 高亮图标 */
@property(nonatomic,strong)NSString* highlighted_icon;


+(instancetype)categoryWithDict:(NSDictionary*)dict;

@end
