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
    [self post];
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
