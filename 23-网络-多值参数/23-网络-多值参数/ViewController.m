//
//  ViewController.m
//  23-网络-多值参数
//
//  Created by yhp on 16/8/21.
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
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/weather?place=Beijing&place=Guangzhou&place=Shanghai"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@\n",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
}

@end
