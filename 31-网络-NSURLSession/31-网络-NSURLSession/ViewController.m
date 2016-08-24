//
//  ViewController.m
//  31-网络-NSURLSession
//
//  Created by yhp on 16/8/23.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self download];
}

-(void)download
{
    // 获得NSURLSession对象
    NSURLSession* session = [NSURLSession sharedSession];
    // 获得下载任务
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"文件下载完毕---%@",location);
        // 文件将来存放的真实路径
        NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString* file = [caches stringByAppendingPathComponent:response.suggestedFilename];
        // 剪切location的临时文件到真实路径
        NSFileManager* mgr = [NSFileManager defaultManager];
        [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:file]  error:nil];
        NSLog(@"%@",file);
    }];
    // 启动任务
    [task resume];
}

-(void)post
{
    // 获得NSURLSession对象
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=520it&pwd=520it" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    // 启动任务
    [task resume];
}

-(void)get2
{
    // 获得NSURLSession对象
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=&pwd=111"];
    NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
        }
    }];
    // 启动任务
    [task resume];
}

-(void)get
{
    // 获得NSURLSession对象
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=&pwd=111"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    // 启动任务
    [task resume];
}

@end
