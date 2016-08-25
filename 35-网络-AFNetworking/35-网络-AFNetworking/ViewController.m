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
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self upload];
}

/**
 *  文件上传
 */
-(void)upload
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSString* urlString = @"http://120.25.226.186:32812/upload";
    NSURLSessionDataTask* uploadTask = [mgr POST:urlString parameters:@{@"username":@"520it"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 在这个block中设置要上传的文件
        NSData* data = [NSData dataWithContentsOfFile:@"/Users/smartwater/Downloads/test.zip"];
        [formData appendPartWithFileData:data name:@"file" fileName:@"test.zip" mimeType:@"application/zip"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = uploadProgress.fractionCompleted;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure:%@",error);
    }];
    [uploadTask resume];
}

-(void)download
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_15.png"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [mgr downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString* file = [caches stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:file];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"file download to : %@",filePath);
    }];
    [downloadTask resume];
}

/**
 *  POST 请求
 */
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

/**
 *  GET 请求
 */
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
