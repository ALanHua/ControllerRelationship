//
//  ViewController.m
//  14-多线程-NSoperation通信
//
//  Created by yhp on 16/7/26.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property(nonatomic,strong)UIImage* image1;
//@property(nonatomic,strong)UIImage* image2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    __block UIImage* image1 = nil;
    __block UIImage* image2 = nil;
    //  下载图片1
    NSOperation* download1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"];
        // 加载图片
        NSData* data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        image1 = [UIImage imageWithData:data];
    }];
    //  下载图片2
    NSOperation* download2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData* data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        image2 = [UIImage imageWithData:data];
    }];
    //  合成图片
    NSOperation* combine = [NSBlockOperation blockOperationWithBlock:^{
        //  开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        //  绘制图片
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        image1 = nil;
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        //  取得上下文图片
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        //  结束上下文
        UIGraphicsEndImageContext();
        
        //  主线程显示
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             self.imageView.image = image;
        }];
    }];
    // 依赖
    [combine addDependency:download1];
    [combine addDependency:download2];
    
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combine];
}


-(void)test2
{
    
}
/**
 *  线程间通信
 */
-(void)test
{
    [[[NSOperationQueue alloc]init] addOperationWithBlock:^{
        //  下载图片
        NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData* data =  [NSData dataWithContentsOfURL:url];
        // 生成图片
        UIImage* image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
    }];
}

@end
