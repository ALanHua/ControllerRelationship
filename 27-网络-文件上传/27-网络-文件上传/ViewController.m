//
//  ViewController.m
//  27-网络-文件上传
//
//  Created by yhp on 16/8/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  好恶心-----写过一次再也不想写了

#import "ViewController.h"

#define YHPBoundary         @"520it"   // 顺便写暂时
#define YHPEncode(string)   [string dataUsingEncoding:NSUTF8StringEncoding]
#define YHPNewLine          [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    创建请求
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    //   设置请求头，告诉服务器这是个文件上传的操作
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",YHPBoundary] forHTTPHeaderField:@"Content-Type"];
    //  设置请求体
    NSMutableData* body = [NSMutableData data];
    // 文件参数
    /*
     --分割线\r\n
     Content-Disposition: form-data; name="参数名"; filename="文件名"\r\n
     Content-Type: 文件的MIMEType\r\n
     \r\n
     文件数据
     \r\n
     */
    // 分割线
    [body appendData:YHPEncode(@"--")];
    [body appendData:YHPEncode(YHPBoundary)];
    [body appendData:YHPNewLine];
    // 文件名参数
    [body appendData:YHPEncode([NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"test.zip\""])];
    [body appendData:YHPNewLine];
    // 文件类型
    [body appendData:YHPEncode([NSString stringWithFormat:@"Content-Type: application/zip"])];
    [body appendData:YHPNewLine];
    
    // 文件数据
    [body appendData:YHPNewLine];
    [body appendData:[NSData dataWithContentsOfFile:@"/Users/smartwater/Downloads/test.zip"]];
    [body appendData:YHPNewLine];
    // 非文件参数
    /*
     --分割线\r\n
     Content-Disposition: form-data; name="参数名"\r\n
     \r\n
     参数值
     \r\n
     */
    // 分割线
    [body appendData:YHPEncode(@"--")];
    [body appendData:YHPEncode(YHPBoundary)];
    [body appendData:YHPNewLine];
    // 参数名
    [body appendData:YHPEncode([NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\""])];
    [body appendData:YHPNewLine];
    // 参数值
    [body appendData:YHPNewLine];
    [body appendData:YHPEncode(@"jack")];
    [body appendData:YHPNewLine];
    // 结束标记
    /*
     --分割线--\r\n
     */
    [body appendData:YHPEncode(@"--")];
    [body appendData:YHPEncode(YHPBoundary)];
    [body appendData:YHPEncode(@"--")];
    [body appendData:YHPNewLine];
    
    request.HTTPBody = body;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    
}



@end
