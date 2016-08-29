//
//  ViewController.m
//  37-网络-https
//
//  Created by yhp on 16/8/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:@"http://www.apple.com/"];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    // 处理https证书问题s
    NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
}

#pragma mark -<NSURLSessionDataDelegate>
/**
 *  challenge 挑战
 *
 *  @param session
 *  @param challenge
 *  @param completionHandler 通过调用Block 来告诉URLSession 是否需要安装证书
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    /**zz
     *  NSURLSessionAuthChallengeDisposition 如何处理这个安全证书
     *  NSURLCredential  安全证明
     */
    // 根据服务器的信任信息创建对象
//    NSURLCredential* credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    // 如果不是服务器信任类型的授权方法就返回
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return;
    }
    
    if (completionHandler) {
//        NSURLCredential* credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,challenge.proposedCredential);
    }

    
}


@end
