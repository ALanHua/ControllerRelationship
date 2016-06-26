//
//  ViewController.m
//  06-级联菜单
//
//  Created by yhp on 16/6/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPCategory.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
/** 所有类别数据 */
@property(nonatomic,strong)NSArray* categories;
/** 左边表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边表格 */
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;

@end

@implementation ViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边表格
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
     // 右边表格
    YHPCategory* c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    return c.subcategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        static NSString* ID = @"category";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        YHPCategory* c = self.categories[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:c.icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:c.highlighted_icon];
        cell.textLabel.text = c.name;
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
       static NSString* ID = @"subCategory";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        YHPCategory* c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.textLabel.text = c.subcategories[indexPath.row];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        return cell;
    }
    

}

#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self.subCategoryTableView reloadData];
    }
}


@end
