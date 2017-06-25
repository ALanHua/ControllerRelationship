//
//  ViewController.m
//  56-二维码
//
//  Created by yhp on 2017/6/15.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+YHPExtension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建过滤器
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复默认设置
    [filter setDefaults];
    // 给过滤器添加数据
    NSString* dataString = @"youhuapei smart";
    NSData* data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 获取输出二维码
    CIImage* outputImage = [filter outputImage];
    self.imageView.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

@end
