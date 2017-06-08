//
//  YHPLrcCell.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcCell.h"
#import "YHPLrcLabel.h"
#import "Masonry.h"

@implementation YHPLrcCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        YHPLrcLabel* lrcLabel = [[YHPLrcLabel alloc]init];
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.font = [UIFont systemFontOfSize:14];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lrcLabel];
        lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _lrcLabel = lrcLabel;
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString* ID = @"lrccell";
    YHPLrcCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YHPLrcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
