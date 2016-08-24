//
//  ViewController.m
//  32-网络-NSURLSession代理方法
//
//  Created by yhp on 16/8/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    // 创建请求
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=qqq&pwd=www"];
    NSURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request];
    
    [task resume];
}

#pragma mark - <NSURLSessionDataDelegate>
/*
    1,接收到服务器响应
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"%s",__func__);
    // 允许处理服务器响应
    completionHandler(NSURLSessionResponseAllow);
}

/*
    2,接收服务器的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"%s",__func__);
    
}
/*
    3,请求完毕
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
       NSLog(@"%s",__func__);
}





@end
