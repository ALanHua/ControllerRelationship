//
//  ViewController.m
//  21-网络-NSConnection-POST
//
//  Created by yhp on 16/8/15.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self postAsync];
}

-(void)getAsync
{
    // 1,路径
    NSString* urlStr = @"http://120.25.226.186:32812/login2?username=小码哥&pwd=520it";
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* url = [NSURL URLWithString:urlStr];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //  请求完毕
        // 解析数据
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];
}

-(void)postAsync
{
    //1 请求路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login2"];
    //2 请求对象
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    // 更改请求方法
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=小码哥&pwd=520it" dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 5;// 5s 后超时
    // 请求头
    //    [request setValue:@"iOS9" forHTTPHeaderField:@"User-Agent"];
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"----请求失败");
        }else{
            NSLog(@"------%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

@end
