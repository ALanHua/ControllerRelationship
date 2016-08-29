//
//  ViewController.m
//  36-网络-数据安全
//
//  Created by yhp on 16/8/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加salt
    /**
     *  加密 21bfcc4c2625469d8ec6f3d710dcb0fe
     *  乱续 c6f3d710dcb0fe21bfcc4c2625469d8e
     */
    NSString* test = @"520it";
    NSString* md = [test md5String];
    
    NSLog(@"%@",md);
    
}

@end
