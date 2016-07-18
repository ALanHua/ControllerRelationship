//
//  ViewController.m
//  02-多线程-pthread
//
//  Created by yhp on 16/7/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(UIButton *)sender {
    
    pthread_t threadId;
    pthread_create(&threadId, NULL, run, NULL);
    
    pthread_t threadId2;
    pthread_create(&threadId2, NULL, run, NULL);
    
}

void* run(void* param)
{
    for (NSInteger i = 0; i < 50000; i++) {
        NSLog(@"---buttonclick--%zd,%@",i,[NSThread currentThread]);
    }
    return NULL;
}

@end
