//
//  YHPSocialViewController.m
//  08-新闻首页
//
//  Created by yhp on 16/6/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSocialViewController.h"

@interface YHPSocialViewController ()

@end

@implementation YHPSocialViewController

static NSString* ID = @"social";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@--viewDidload",self.title);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"YHP--%@-%zd",self.title,indexPath.row];
    return cell;
}


@end