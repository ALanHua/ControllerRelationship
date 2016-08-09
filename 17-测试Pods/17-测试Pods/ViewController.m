//
//  ViewController.m
//  17-测试Pods
//
//  Created by yhp on 16/8/8.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png"] placeholderImage:nil];
}

@end
