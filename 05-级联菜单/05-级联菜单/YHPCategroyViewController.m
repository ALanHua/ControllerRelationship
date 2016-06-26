//
//  YHPCategroyViewController.m
//  05-级联菜单
//
//  Created by yhp on 16/6/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCategroyViewController.h"
#import "YHPCategory.h"

@interface YHPCategroyViewController ()
/** 所有类别数据 */
@property(nonatomic,strong)NSArray* categories;
@end

/**
 *  知识点：
 当一个cell呗选中的时候，cell内部的子控件都会到达high_lighted
 */

@implementation YHPCategroyViewController

#pragma mark - 数据懒加载
- (NSArray *)categories
{
    if (_categories == nil) {
        NSArray* dictArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource:@"categories" ofType:@"plist"]];
        NSMutableArray* categoryArray = [NSMutableArray array];
        for (NSDictionary* dict in dictArray) {
            [categoryArray addObject:[YHPCategory categoryWithDict:dict]];
        }
        _categories = categoryArray;
    }
    return _categories;
}
NSString* ID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    YHPCategory* c = self.categories[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:c.icon];
    cell.imageView.highlightedImage = [UIImage imageNamed:c.highlighted_icon];
    cell.textLabel.text = c.name;
    cell.textLabel.highlightedTextColor = [UIColor blueColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    告诉代理
    if ([self.delegate respondsToSelector:@selector(categoryViewController:didSelectSubCategories:)]) {
        YHPCategory* c = self.categories[indexPath.row];
        [self.delegate categoryViewController:self didSelectSubCategories:c.subcategories];
    }
    
}


@end