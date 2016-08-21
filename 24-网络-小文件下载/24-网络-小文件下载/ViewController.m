//
//  ViewController.m
//  24-网络-小文件下载
//
//  Created by yhp on 16/8/21.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
/** 文件数据 */
@property(nonatomic,strong)NSMutableData* fileData;
/** 文件总长度 */
@property(nonatomic,assign)NSInteger totalLength;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark - <NSURLConnectionDataDelegate>
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    
    self.totalLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    self.fileData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.fileData appendData:data];
    CGFloat progress = 1.0 * self.fileData.length / self.totalLength;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });

    NSLog(@"已下载:%.2f%%",progress*100);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%zd",self.fileData.length);
    //  将文件写入沙盒
    NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString* file = [caches stringByAppendingPathComponent:@"minion_15.mp4"];
    // 写数据
    [self.fileData writeToFile:file atomically:YES];
    self.fileData = nil;
    NSLog(@"写入完毕---%@",file);
}

-(void)connectionDownLoad
{
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_15.png"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%ld",data.length);
    }];
}

-(void)dataDownload
{
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_15.png"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSLog(@"%ld",data.length);
}


@end
