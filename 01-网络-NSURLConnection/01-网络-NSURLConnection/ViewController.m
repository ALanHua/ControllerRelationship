//
//  ViewController.m
//  01-网络-NSURLConnection
//
//  Created by yhp on 16/8/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

/** <#注释#> */
@property(nonatomic,strong)NSMutableData* responsedata;
@end

@implementation ViewController
- (IBAction)login {

    NSString* username = self.usernameField.text;
    NSString* pwd = self.pwdField.text;
    
    if (username.length == 0) {
        [SVProgressHUD showErrorWithStatus:self.usernameField.placeholder];
        return;
    }
    if (pwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:self.pwdField.placeholder];
        return;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"正在登录"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.25.226.186:32812/login?username=%@&pwd=%@",username,pwd]];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //  请求完毕
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//            [SVProgressHUD dismiss]; 可以不写
            NSInteger loc = [str rangeOfString:@"\":\""].location + 3;
            NSUInteger len = [str rangeOfString:@"\"}"].location - loc;
            NSString* msg = [str substringWithRange:NSMakeRange(loc, len)];
            if ([str containsString:@"Success"]) {
                [SVProgressHUD showSuccessWithStatus:msg];
            }else{
                [SVProgressHUD showErrorWithStatus:msg];
            }
  
        }];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self delegateAsync];
}

-(void)delegateAsync
{
    // 1,路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3,创建连接对象
    NSURLConnection* conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    /**
     *  取消请求
     */
//    [conn cancel];
}

-(void)AsyncGet
{
    // 1,路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //  请求完毕
        // 解析数据
        NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];
}
#pragma mark --<NSURLConnectionDataDelegate>--begin

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   NSLog(@"didFailWithError----%@",error);
}
/**
 *  接收到服务器的相应
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responsedata = [NSMutableData data];
    NSLog(@"didReceiveResponse----%@",response);
}
/**
 *  接收数据，如果数据量比较大，这个函数会调用多次
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    大文件不能用这种方法
    [self.responsedata appendData:data];
    NSLog(@"didReceiveData----%zd",data.length);
}
/**
 *  数据接收完毕
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     NSLog(@"DidFinishLoading----%@",connection);
    NSString* str = [[NSString alloc]initWithData:self.responsedata encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    self.responsedata = nil;
}

#pragma mark --<NSURLConnectionDataDelegate>---end
-(void)get
{
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=1"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 发送请求,阻塞方法
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // 解析数据
    NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}
@end
