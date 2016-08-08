//
//  ViewController.m
//  15-多线程-下载图片
//
//  Created by yhp on 16/8/6.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPApp.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@interface ViewController ()

/** 所有app的数据 */
@property(nonatomic,strong)NSArray* apps;
/** 内存缓冲图片 */
@property(nonatomic,strong)NSMutableDictionary* images;
/** 队列 */
@property(nonatomic,strong)NSOperationQueue* queue;
/** 所有的操作数 */
@property(nonatomic,strong)NSMutableDictionary* operations;
@end


@implementation ViewController

/**
 *  懒加载缓存操作数
 */
-(NSMutableDictionary *)operation
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

/**
 *  懒加载队列缓存
 */
-(NSOperationQueue*)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}
/**
 *  懒加载图片内存缓存
 */
-(NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
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
    
    //  下载图片
    [[SDWebImageManager sharedManager] downloadImageWithURL:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
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
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"qq"]];
//
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"qq"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //expectedSize 期望大小
        //receivedSize 已经接收大小
        NSLog(@"%f",1.0 * receivedSize / expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"图片下载完毕");
    }];
    //   SDwebImage的图片缓存周期是多久：默认1周
    
    return cell;
}


@end