//
//  ViewController.m
//  87_coreAnimation02
//
//  Created by yhp on 2018/1/17.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *coneView;
@property (weak, nonatomic) IBOutlet UIView *shipView;
@property (weak, nonatomic) IBOutlet UIView *iglooView;
@property (weak, nonatomic) IBOutlet UIView *anchorView;

@end

@implementation ViewController

-(void)addSpriteImage:(UIImage*)image
      withContentRect:(CGRect)rect
              toLayer:(CALayer*)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
//    设置显示区域
    layer.contentsRect = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* image = [UIImage imageNamed:@"Sprites"];
//  将一张图片切成4块在4个View上显示
    CGRect rect = CGRectMake(0, 0, 0.5, 0.5);
    [self addSpriteImage:image withContentRect:rect toLayer:self.coneView.layer];
    rect = CGRectMake(0.5, 0, 0.5, 0.5);
    [self addSpriteImage:image withContentRect:rect toLayer:self.shipView.layer];
    rect = CGRectMake(0, 0.5, 0.5, 0.5);
    [self addSpriteImage:image withContentRect:rect toLayer:self.iglooView.layer];
    rect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    [self addSpriteImage:image withContentRect:rect toLayer:self.anchorView.layer];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
