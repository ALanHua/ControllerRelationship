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
#import "YHPLrcLabel.h"

@interface YHPLrcView () <UITableViewDataSource>
/** tableView */
@property(nonatomic,strong)UITableView* tableView;
/** 歌词列表 */
@property(nonatomic,strong)NSArray* lrcList;
/** 滚动时档期下标值 */
@property(nonatomic,assign)NSInteger currentIndex;
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
    
    if (self.currentIndex == indexPath.row) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:20.0];
    }else{
        cell.lrcLabel.font = [UIFont systemFontOfSize:14.0];
        cell.lrcLabel.progress = 0.0;
    }
    
    YHPLrcLine* lrcLine = self.lrcList[indexPath.row];
    cell.lrcLabel.text = lrcLine.text;

    return cell;
}

#pragma mark 重写lrcName

-(void)setLrcName:(NSString *)lrcName
{
    // 重置当前位置的下标值
    self.currentIndex = 0;
    // 更新歌词
    _lrcName = [lrcName copy];
    // 解析歌词
    self.lrcList = [YHPLrcTool lrcWithLrcName:lrcName];
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - 重写currentTime
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    // 1,匹配歌词时间
    NSInteger count = self.lrcList.count;
    NSInteger nextIndex = 0;
    for (NSInteger i = 0; i < count; i++) {
        // 当前行
        YHPLrcLine* currentLrcLine = self.lrcList[i];
        // 下一行
        nextIndex = i + 1;
        YHPLrcLine* nextLrcLine = nil;
        if (nextIndex < count) {
            nextLrcLine = self.lrcList[nextIndex];
        }
        // 当前时间和i位置歌词和下一句比较
        if (self.currentIndex != i &&
        currentTime >= currentLrcLine.time &&
        currentTime <= nextLrcLine.time) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath* previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            // 显示对应歌词
            self.currentIndex = i;
            [self.tableView reloadRowsAtIndexPaths:@[previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            // 外面的歌词
            self.LrcViewlrcLabel.text = currentLrcLine.text;
        }
        // 根据进度画lrcLabel
        if (self.currentIndex == i) {
            // 1，i 拿到这个cell
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            YHPLrcCell* cell = (YHPLrcCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            // 更新label 进度
            CGFloat progress = (currentTime - currentLrcLine.time) / (nextLrcLine.time - currentLrcLine.time);
            cell.lrcLabel.progress = progress;
            // 设置外面歌词label的进度
            self.LrcViewlrcLabel.progress = progress;
        }
    }
    
}

@end
