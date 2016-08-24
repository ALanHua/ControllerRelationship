//
//  ViewController.m
//  33-网络-NSURLSession文件下载
//
//  Created by yhp on 16/8/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self download];
}

-(void)download
{
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:url];
    
    [task resume];
}
#pragma mark - <NSURLSessionDownloadDelegate>

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"didCompleteWithError");
}
/*
 * 写入数据到临时文件时,会调用
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"didResumeAtOffset");
}
/**
 *  将数据写入到临时文件
 *
 *  @param session
 *  @param downloadTask
 *  @param bytesWritten              这一次写入大小
 *  @param totalBytesWritten         已经写入的大小
 *  @param totalBytesExpectedToWrite 期望的大小 --- 总长度
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
//     NSLog(@"didWriteData");
    NSLog(@"--------%f",1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}
/*
 * 下载完毕调用
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // 将临时文件复制到目的文件位置
    NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString* file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager* mgr = [NSFileManager defaultManager];
    [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
    
}

@end
