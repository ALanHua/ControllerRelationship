//
//  ViewController.m
//  09-多线程-GCD其他函数
//
//  Created by yhp on 16/7/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPPerson.h"

@interface ViewController ()
/** 图片 */
@property(nonatomic,strong)UIImage* image1;
@property(nonatomic,strong)UIImage* image2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    YHPPerson* p1 = [[YHPPerson alloc]init];
//    NSLog(@"%@",p1.books);
//    YHPPerson* p2 = [[YHPPerson alloc]init];
//    NSLog(@"%@",p2.books);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


-(void)group
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    //  1，下载图片1
    dispatch_group_async(group, queue, ^{
        NSURL* url = [NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"];
        // 加载图片
        NSData* data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        self.image1 = [UIImage imageWithData:data];
    });
    //  2，下载图片2
    dispatch_group_async(group, queue, ^{
        NSURL* url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData* data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        self.image2 = [UIImage imageWithData:data];
        
    });
    //  3，将图片1和图片2进行合成
    dispatch_group_notify(group, queue, ^{
        //  开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        //  绘制图片
        [self.image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [self.image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        //  取得上下文图片
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        //  结束上下文
        UIGraphicsEndImageContext();
        //  回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //  4，将新图片显示出来
            self.imageView.image = image;
        });
    });
}

/**
 *  快熟迭代
 */
-(void)apply
{
    NSString* from = @"/Users/smartwater/Downloads/11";
    NSString* to = @"/Users/smartwater/Downloads/22";
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSArray* subPaths = [mgr subpathsAtPath:from];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(subPaths.count, queue, ^(size_t index) {
        NSString* subPath = subPaths[index];
        NSString* fromFullPath = [from stringByAppendingPathComponent:subPath];
        NSString* toFullpath = [to stringByAppendingPathComponent:subPath];
        [mgr moveItemAtPath:fromFullPath toPath:toFullpath error:nil];
        NSLog(@"---%@",subPath);
    });

}

-(void)moveFile
{
 
    NSString* from = @"/Users/smartwater/Downloads/11";
    NSString* to = @"/Users/smartwater/Downloads/22";
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSArray* subPaths = [mgr subpathsAtPath:from];
    for (NSString* subPath in subPaths) {
        NSString* fromFullPath = [from stringByAppendingPathComponent:subPath];
        NSString* toFullpath = [to stringByAppendingPathComponent:subPath];
        // 剪切
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           [mgr moveItemAtPath:fromFullPath toPath:toFullpath error:nil];
        });
    }
}

-(void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"run------");// 只执行一次
    });// 线程安全，有锁
}
/**
 *  延时执行方式
 */
-(void)delay
{
    NSLog(@"rbegian------");
    // [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    //  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"run------");
    });
}

-(void)run
{
    NSLog(@"run------");
}

-(void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"----barrier-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@",[NSThread currentThread]);
    });
}


@end
