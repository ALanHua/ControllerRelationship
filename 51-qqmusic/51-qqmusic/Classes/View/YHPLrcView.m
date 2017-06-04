//
//  YHPLrcView.m
//  51-qqmusic
//
//  Created by yhp on 2017/6/3.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLrcView.h"
#import "Masonry.h"
#import "YHPLrcCell.h"
#import "YHPLrcLine.h"
#import "YHPLrcTool.h"

@interface YHPLrcView () <UITableViewDataSource>
/** tableView */
@property(nonatomic,strong)UITableView* tableView;
/** 歌词列表 */
@property(nonatomic,strong)NSArray* lrcList;
@end

@implementation YHPLrcView

- (NSArray *)lrcList
{
    if (!_lrcList) {
        _lrcList = [NSArray array];
    }
    return _lrcList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpTableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpTableView];
    }
    return self;
}

-(void)setUpTableView
{
    // 创建tableView
    UITableView* tableView = [[UITableView alloc]init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 35;
    self.tableView.dataSource = self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_top);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width);
    }];
    // 设置tableView多出的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPLrcCell* cell = [YHPLrcCell lrcCellWithTableView:tableView];
    
    YHPLrcLine* lrcLine = self.lrcList[indexPath.row];
    cell.textLabel.text = lrcLine .text;

    return cell;
}

#pragma mark 重写lrcName

-(void)setLrcName:(NSString *)lrcName
{
    _lrcName = [lrcName copy];
    // 解析歌词
    self.lrcList = [YHPLrcTool lrcWithLrcName:lrcName];
    // 刷新表格
    [self.tableView reloadData];
}

@end
