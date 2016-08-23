//
//  ViewController.m
//  30-网络-RunLoop相关
//
//  Created by yhp on 16/8/23.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
/** runloop */
@property(nonatomic,assign)CFRunLoopRef runLoop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  这里有坑 子线程RunLoop默认不开启
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_15.mp4"];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        NSURLConnection* connection = [NSURLConnection connectionWithRequest:request delegate:self];
        // 将代理方法放在子队列执行
        [connection setDelegateQueue:[[NSOperationQueue alloc]init]];
        // 启动子线程RunLoop
        // [[NSRunLoop currentRunLoop]run];
        self.runLoop = CFRunLoopGetCurrent();
        CFRunLoopRun();
    });
    
}

#pragma mark - <NSURLConnectionDataDelegate>
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"--11---%@",[NSThread currentThread]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"--11---%@",[NSThread currentThread]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
   // 停止runloop
    CFRunLoopStop(self.runLoop);
}

@end