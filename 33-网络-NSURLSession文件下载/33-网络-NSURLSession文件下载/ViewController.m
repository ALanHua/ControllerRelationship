//
//  ViewController.m
//  33-网络-NSURLSession文件下载
//
//  Created by yhp on 16/8/24.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

#define YHPResumeDataFile   [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"resumeData.tmp"]
@interface ViewController () <NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 下载任务 */
@property(nonatomic,strong)NSURLSessionDownloadTask* task;
/** 保存上一次的下载信息 */
@property(nonatomic,strong)NSData* resumeData;
/** NSSession */
@property(nonatomic,strong)NSURLSession* session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    }
    return _session;
}

-(NSData *)resumeData
{
    if (_resumeData == nil) {
        _resumeData = [NSData dataWithContentsOfFile:YHPResumeDataFile];
    }
    return _resumeData;
}

- (IBAction)start:(UIButton *)sender {
    if (self.resumeData) {
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
        [self.task resume];
    }else{
        [self download];
    }

}

- (IBAction)goOn:(UIButton *)sender {
//    [self.task resume]; //
    // 断点下载
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.task resume];
}

- (IBAction)pause:(UIButton *)sender {
//    [self.task suspend];
    // 取消下载任务
   [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
       self.resumeData = resumeData;
       // 将resumeData写入沙盒保存起来，继续下载，下次读取数据继续下载
       [resumeData writeToFile:YHPResumeDataFile atomically:YES];
   }];
}

-(void)download
{
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    self.task = [self.session downloadTaskWithURL:url];
    
    [self.task resume];
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
//    NSLog(@"--------%f",1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    });
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
