//
//  ViewController.m
//  103_coreAnimation18
//
//  Created by yhp on 2018/2/2.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建一个CATextLayer
    CATextLayer* textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(23, 100, 300, 200);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:textLayer];
//    设置文本属性
    textLayer.alignmentMode = kCAAlignmentJustified;
//    设置内容被包裹在接收方内，及不要超出view
    textLayer.wrapped = YES;
//    选择字体
    UIFont* font = [UIFont systemFontOfSize:15];
//    创建文字
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
    elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
//    创建字符串属性
    NSMutableAttributedString*string = [[NSMutableAttributedString alloc]initWithString:text];
//   UIFont -> CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
//    设置文本属性
    NSDictionary* attribs = @{
        (__bridge id)kCTForegroundColorAttributeName:
        (__bridge id)[UIColor blueColor].CGColor,
        (__bridge id)kCTFontAttributeName:
        (__bridge id)fontRef
    };
    [string setAttributes:attribs range:NSMakeRange(0, text.length)];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:
                    (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName:
                    @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    CFRelease(fontRef);
    
    textLayer.string = string;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
