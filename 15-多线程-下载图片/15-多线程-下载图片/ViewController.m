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
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.images = nil;
    self.operations = nil;
    [self.queue cancelAllOperations];
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
    UIImage* image = self.images[app.icon];
    // 下载图片
    if (image) {
        cell.imageView.image = image;
    }else{ // 内存中没有
        // 将图片文件写入沙盒中去
        NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString* fileName = [app.icon lastPathComponent];
        NSString* file = [cachesPath stringByAppendingPathComponent:fileName];
        __block  NSData* data = [NSData dataWithContentsOfFile:file];
        data = nil;
        if (data){
            UIImage* image = [UIImage imageWithData:data];
            cell.imageView.image = image;
            self.images[app.icon] = image;
        }else{
            // 显示一个占位图片
            cell.imageView.image = [UIImage imageNamed:@"qq"];
            NSOperation* operation = self.operations[app.icon];
            if (operation == nil) {
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    // 将图片文件写入沙盒中去
                    NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                    NSString* fileName = [app.icon lastPathComponent];
                    NSString* file = [cachesPath stringByAppendingPathComponent:fileName];
                    __block  NSData* data = [NSData dataWithContentsOfFile:file];
                    if (data){
                        UIImage* image = [UIImage imageWithData:data];
                        cell.imageView.image = image;
                        self.images[app.icon] = image;
                    }else{
                        [self.queue addOperationWithBlock:^{
                            // 下载图片
                            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
                            /**
                             *  异常处理
                             */
                            if (data == nil) {
                                // 移除操作
                                [self.operations removeObjectForKey:app.icon];
                                return;
                            }
                            UIImage* image = [UIImage imageWithData:data];
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                            // 存到字典中去
                            self.images[app.icon] = image;
                            [data writeToFile:file atomically:YES];
                            // 移除操作
                            [self.operations removeObjectForKey:app.icon];
                        }];
                    }
                }];
                //  添加到队列中
                [self.queue addOperation:operation];
                self.operations[app.icon] = operation;
            }
        }
        
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