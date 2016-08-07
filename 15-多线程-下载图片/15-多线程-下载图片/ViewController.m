//
//  ViewController.m
//  15-多线程-下载图片
//
//  Created by yhp on 16/8/6.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPApp.h"

@interface ViewController ()

/** 所有app的数据 */
@property(nonatomic,strong)NSArray* apps;
/** 内存缓冲图片 */
@property(nonatomic,strong)NSMutableDictionary* imageCache;
@end


@implementation ViewController


-(NSMutableDictionary *)imageCache
{
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

/**
 *  懒加载模型数据
 */
-(NSArray*)apps
{
    if (!_apps) {
        NSArray* dictArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSMutableArray* appArray = [NSMutableArray array];
        for (NSDictionary* dict  in dictArray) {
            [appArray addObject:[YHPApp appWithDict:dict]];
        }
        _apps =appArray;
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"app";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    YHPApp* app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    // 先从内存缓冲中取出图片
    UIImage* image = self.imageCache[app.icon];
    // 下载图片
    if (image) {
        cell.imageView.image = image;
    }else{ // 内存中没有
        // 将图片文件写入沙盒中去
        NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString* fileName = [app.icon lastPathComponent];
        NSString* file = [cachesPath stringByAppendingPathComponent:fileName];
        NSData* data = [NSData dataWithContentsOfFile:file];
        if (data){
             cell.imageView.image = [UIImage imageWithData:data];
        }else{
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
            cell.imageView.image = [UIImage imageWithData:data];
            [data writeToFile:file atomically:YES];
        }
        // 存到字典中去
        self.imageCache[app.icon] = cell.imageView.image;
    }
    
    return cell;
}
/**
 应用沙盒
 Document
 Library
    - Caches      // 下载文件
    - Preference
 temp
 */

@end
