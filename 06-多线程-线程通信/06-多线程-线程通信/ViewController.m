//
//  ViewController.m
//  06-多线程-线程通信
//
//  Created by yhp on 16/7/19.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelectorInBackground:@selector(download3) withObject:nil];
}


-(void)download3
{
    //  网络图片路径
    NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    // 加载图片
    NSData* data =  [NSData dataWithContentsOfURL:url];
    // 生成图片
    UIImage* image = [UIImage imageWithData:data];
    // 回到主线程，显示图片
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];// YES 表示等主线程完成在执行其他线程


}

-(void)showImage:(UIImage*)image
{
    self.imageView.image = image;
    NSLog(@"YHP--%d",[NSThread isMainThread]);
}

-(void)download2
{
    //  网络图片
    NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();// 单位s
    NSData* data =  [NSData dataWithContentsOfURL:url];
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end - begin);
    
    self.imageView.image = [UIImage imageWithData:data];
}

-(void)download
{
    //  网络图片
    NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    NSDate* begin = [NSDate date];
    NSData* data =  [NSData dataWithContentsOfURL:url];
    NSDate* end = [NSDate date];
    NSLog(@"%f",[end timeIntervalSinceDate:begin]);
    
    self.imageView.image = [UIImage imageWithData:data];
}

@end
