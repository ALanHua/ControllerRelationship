//
//  YHPLrcCell.h
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPLrcLabel;
@interface YHPLrcCell : UITableViewCell

+(instancetype)lrcCellWithTableView:(UITableView*)tableView;
/** lrcLabel */
@property(nonatomic,strong,readonly)YHPLrcLabel* lrcLabel;

@end
