//
//  YHPCategroyViewController.h
//  05-级联菜单
//
//  Created by yhp on 16/6/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHPCategroyViewController;
// 代理协议
@protocol YHPCategoryViewControllerDelegate <NSObject>
@optional
-(void)categoryViewController:(YHPCategroyViewController*)categoryViewController didSelectSubCategories:(NSArray*)subCategories;
@end

@interface YHPCategroyViewController : UITableViewController
@property(nonatomic,weak)id <YHPCategoryViewControllerDelegate>delegate;
@end
