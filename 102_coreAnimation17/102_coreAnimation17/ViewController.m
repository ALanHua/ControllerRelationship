//
//  ViewController.m
//  102_coreAnimation17
//
//  Created by yhp on 2018/1/31.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CATextLayer* textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
//    设置图层属性
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
//   选择字体
    UIFont* font = [UIFont systemFontOfSize:20];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef   fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
    elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    textLayer.string = text;
    
    [self.view.layer addSublayer:textLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
