//
//  ViewController.m
//  01-网络-NSURLConnection
//
//  Created by yhp on 16/8/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

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
