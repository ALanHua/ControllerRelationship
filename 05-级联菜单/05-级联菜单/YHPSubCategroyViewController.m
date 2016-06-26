//
//  YHPSubCategroyViewController.m
//  05-级联菜单
//
//  Created by yhp on 16/6/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSubCategroyViewController.h"

@interface YHPSubCategroyViewController ()
/** 子类别数据 */
@property(nonatomic,strong)NSArray* subcategories;
@end

@implementation YHPSubCategroyViewController

NSString* ID2 = @"subCategory";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <YHPCategoryViewControllerDelegate>
-(void)categoryViewController:(YHPCategroyViewController *)categoryViewController didSelectSubCategories:(NSArray *)subCategories
{
    self.subcategories = subCategories;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.subcategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    cell.textLabel.text = self.subcategories[indexPath.row];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    
    return cell;
}
@end