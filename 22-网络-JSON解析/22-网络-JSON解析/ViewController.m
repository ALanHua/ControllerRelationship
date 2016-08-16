//
//  ViewController.m
//  22-网络-JSON解析
//
//  Created by yhp on 16/8/16.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1,路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 解析JSON
        /*
         NSJSONReadingMutableContainers  NSMutableDictionary
         NSJSONReadingMutableLeaves      里面的也是可变
         NSJSONReadingAllowFragments     允许返回不是数组和字典
         */
        NSDictionary* dict = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict[@"success"]);
        NSData* d = [NSJSONSerialization dataWithJSONObject:@{@"name":@"YHP"} options:NSJSONWritingPrettyPrinted error:nil];
        NSString* str = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];
}

@end
