//
//  ViewController.m
//  29-网络-大文件下载OutPutStream
//
//  Created by yhp on 16/8/23.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
/** 输出流 */
@property(nonatomic,strong)NSOutputStream* stream;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - <NSURLConnectionDataDelegate>
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // 想文件中写入数据
    NSString* caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString* file = [caches stringByAppendingPathComponent:@"minion_15.mp4"];
    NSString* file = [caches stringByAppendingPathComponent:response.suggestedFilename];// 和服务器文件名一直
    NSLog(@"%@",file);
    self.stream = [NSOutputStream outputStreamToFileAtPath:file append:YES];
    // 文件不存在，会自动创建
    [self.stream open];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.stream write:[data bytes] maxLength:data.length];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.stream close];
    NSLog(@"finish!");
}

@end
