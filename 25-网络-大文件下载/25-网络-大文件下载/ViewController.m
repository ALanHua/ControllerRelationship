//
//  ViewController.m
//  25-网络-大文件下载
//
//  Created by yhp on 16/8/21.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/** 文件总长度 */
@property(nonatomic,assign)NSInteger totalLength;
/** 文件句柄对象 */
@property(nonatomic,strong)NSFileHandle* handle;
/** 当前下载总长度 */
@property(nonatomic,assign)NSInteger currentLength;

@end

#define YHPFile   [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"minion_15.mp4"]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark - <NSURLConnectionDataDelegate>
/*
 接收到数据就创建一个空文件
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    // 文件总长度
    self.totalLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    // 创建一个空文件
    [[NSFileManager defaultManager]createFileAtPath:YHPFile contents:nil attributes:nil];
    
    self.handle = [NSFileHandle fileHandleForWritingAtPath:YHPFile];
}

/*
    接收数据,写入文件夹
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.handle seekToEndOfFile];
    // 写入数据
    [self.handle writeData:data];
    // 拼接总长度
    self.currentLength += data.length;
    // 进度
    self.progressView.progress = 1.0 *  self.currentLength / self.totalLength;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    关闭handle
    [self.handle closeFile];
    self.handle = nil;
    self.currentLength = 0;
}


@end
