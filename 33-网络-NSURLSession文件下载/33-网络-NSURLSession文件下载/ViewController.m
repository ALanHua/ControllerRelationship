//
//  ViewController.m
//  33-网络-NSURLSession文件下载
//
//  Created by yhp on 16/8/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

#define YHPMp4File          [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"test.mp4"]
// 文件下载长度
#define YHPDownloadLength   [[[NSFileManager defaultManager]attributesOfItemAtPath:YHPMp4File error:nil][NSFileSize] integerValue]

@interface ViewController () <NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 下载任务 */
@property(nonatomic,strong)NSURLSessionDataTask* task;
/** NSSession */
@property(nonatomic,strong)NSURLSession* session;
/** 写入文件的流对象 */
@property(nonatomic,strong)NSOutputStream* stream;
/** 文件总长度 */
@property(nonatomic,assign)NSInteger totalLength;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSFileManager defaultManager] removeItemAtPath:YHPMp4File error:nil];
}

- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    }
    return _session;
}

-(NSOutputStream *)stream
{
    if (_stream == nil) {
        _stream = [NSOutputStream outputStreamToFileAtPath:YHPMp4File append:YES];
    }
    return _stream;
}

- (IBAction)start:(UIButton *)sender {

    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    // 创建请求
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求头
    // Range:bytes=xxx-xxx
    NSString* range = [NSString stringWithFormat:@"bytes=%ld-",YHPDownloadLength];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    self.task = [self.session dataTaskWithRequest:request];
    [self.task resume];


}

- (IBAction)goOn:(UIButton *)sender {
    [self.task resume];
    
}
/**
 *  暂停下载
 */
- (IBAction)pause:(UIButton *)sender {
    
    [self.task suspend];
}

#pragma mark -<NSURLSessionDataDelegate>
/**
 *  接收响应
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    // 打开流
    [self.stream open];
    // 获得服务器这一返回文件的总长度
    self.totalLength = [response.allHeaderFields[@"Content-Length"]integerValue] + YHPDownloadLength;
    // 接收响应,允许接收服务器数据
    completionHandler(NSURLSessionResponseAllow);
    
}
/**
 *  接收服务器的数据
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // 写入数据
    [self.stream write:data.bytes maxLength:data.length];
    // 下载进度
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = 1.0 * YHPDownloadLength  / self.totalLength;
    });

}
/**
 *  请求完毕
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self.stream close];
    self.stream = nil;
}

/**
 请求:http://120.25.226.186:32812/resources/videos/minion_15.mp4
 设置请求头
 Range:1024 ---
 *  响应头
 */

-(void)scaveFile
{
    // 将resumeData写入沙盒保存起来，继续下载，下次读取数据继续下载
    //       [resumeData writeToFile:YHPResumeDataFile atomically:YES];
    //
    //        // 临时文件
    //       NSString* tmp = NSTemporaryDirectory();
    //       NSFileManager* mgr = [NSFileManager defaultManager];
    //       NSArray* subpath = [mgr subpathsAtPath:tmp];
    //       NSString* file = [tmp stringByAppendingPathComponent:[subpath lastObject]];
    //
    //       NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //       NSString* cachesTempFile = [caches stringByAppendingPathComponent:[file lastPathComponent]];
    //       [mgr moveItemAtPath:file toPath:cachesTempFile error:nil];
    //
    //       [@{@"tempFile":cachesTempFile} writeToFile:[caches stringByAppendingPathComponent:@"tempFile.plist"] atomically:YES];
}

//#pragma mark - <NSURLSessionDownloadDelegate>
//
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
//{
////    NSLog(@"didCompleteWithError");
//    self.resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
//}
///*
// * 写入数据到临时文件时,会调用
// */
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
//{
//    NSLog(@"didResumeAtOffset");
//}
///**
// *  将数据写入到临时文件
// *
// *  @param session
// *  @param downloadTask
// *  @param bytesWritten              这一次写入大小
// *  @param totalBytesWritten         已经写入的大小
// *  @param totalBytesExpectedToWrite 期望的大小 --- 总长度
// */
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
//{
////    NSLog(@"--------%f",1.0 * totalBytesWritten / totalBytesExpectedToWrite);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.progressView.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
//    });
//}
///*
// * 下载完毕调用
// */
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
//{
//    // 将临时文件复制到目的文件位置
//    NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    NSString* file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
//    
//    NSFileManager* mgr = [NSFileManager defaultManager];
//    [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
//    
//}


@end
