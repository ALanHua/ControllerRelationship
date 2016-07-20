//
//  ViewController.m
//  08-多线程-GCD线程通信
//
//  Created by yhp on 16/7/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //  下载图片
        NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData* data =  [NSData dataWithContentsOfURL:url];
        // 生成图片
        UIImage* image = [UIImage imageWithData:data];
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
    });
}


@end
