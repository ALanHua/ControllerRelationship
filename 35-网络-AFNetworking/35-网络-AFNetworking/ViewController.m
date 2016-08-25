//
//  ViewController.m@
//  35-网络-AFNetworking
//
//  Created by yhp on 16/8/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

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
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSString* urlString = @"http://120.25.226.186:32812/login";
    NSDictionary* params =  @{
                              @"username":@"520it",
                              @"pwd" : @"520it"
                              };
    
    [mgr POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---succcess:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---failure--");
    }];
}

-(void)get
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSString* urlString = @"http://120.25.226.186:32812/login";
    NSDictionary* params =  @{
                              @"username":@"520it",
                              @"pwd" : @"520it"
                              };
    
    [mgr GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---succcess:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---failure--");
    }];
    
}

@end
