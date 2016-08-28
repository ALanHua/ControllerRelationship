//
//  ViewController.m@
//  35-网络-AFNetworking
//
//  Created by yhp on 16/8/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import <AFNetworking.h>

@interface ViewController ()<NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 监控网路 */
@property(nonatomic,strong)Reachability* reachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self appleMonitoring];
}

-(void)appleMonitoring
{
    // 监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetWorkStatus:) name:kReachabilityChangedNotification object:nil];
    
    // 监控网络
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
      
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.reachability stopNotifier];
    self.reachability = nil;
}

-(void)getNetWorkStatus:(NSNotification*)note
{
    NSLog(@"%@",note);
    
    if([Reachability reachabilityForLocalWiFi].currentReachabilityStatus !=
       NotReachable){
        NSLog(@"status is wifi network");
    }else if([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable){
        NSLog(@"status is Phone local network");
    }else{
        NSLog(@"UnKnow NetWork");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self upload];
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    /**
     *  [AFJSONResponseSerializer serializer];         //JSON解析器
     *  [AFXMLParserResponseSerializer serializer];    //XML解析器
     *  [AFHTTPResponseSerializer serializer];         //不做任何解析
     */

    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString* urlString = @"http://120.25.226.186:32812/resources/images/minion_15.png";
    
    [mgr GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData* responseObject) {
        NSLog(@"---succcess:%ld",responseObject.length);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---failure--");
    }];
}

-(void)AFCheckNetWorkMemthod
{
    // 开始网络监控
    AFNetworkReachabilityManager* mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"----now status:%zd",status);
    }];
    
    [mgr startMonitoring];
    // 拿到当前网络状态
    [mgr networkReachabilityStatus];
}

-(void)xmlGet
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    // 已XML形式解析
    mgr.responseSerializer  = [AFXMLParserResponseSerializer serializer];
    
    NSString* urlString = @"http://120.25.226.186:32812/login";
    NSDictionary* params =  @{
                              @"username":@"520it",
                              @"pwd" : @"520it",
                              @"type" : @"XML"
                              };
    
    [mgr GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSXMLParser* parser) {
        //        NSLog(@"---succcess:%@",responseObject);
        parser.delegate = self;
        [parser parse];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---failure--");
    }];
    
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
