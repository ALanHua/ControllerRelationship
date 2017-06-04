//
//  YHPLrcCell.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/4.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcCell.h"

@implementation YHPLrcCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString* ID = @"lrccell";
    YHPLrcCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YHPLrcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
