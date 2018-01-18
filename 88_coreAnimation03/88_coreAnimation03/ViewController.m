//
//  ViewController.m
//  88_coreAnimation03
//
//  Created by yhp on 2018/1/18.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *button1;
@property (weak, nonatomic) IBOutlet UIView *button2;

@end

@implementation ViewController

-(void) addStretchableImage:(UIImage*)image
              withContenter:(CGRect)rect
                    toLayer:(CALayer*)layer
{
    layer.contents = (__bridge id)image.CGImage;
    
    layer.contentsCenter = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* image = [UIImage imageNamed:@"Button"];
    CGRect rect = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    [self addStretchableImage:image withContenter:rect toLayer:self.button1.layer];

//    [self addStretchableImage:image withContenter:rect toLayer:self.button2.layer];
    
    CALayer* blueLayer = [CALayer layer];
    blueLayer.frame = self.button2.bounds;
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.button2.layer addSublayer:blueLayer];
//   绘制layer
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
//    画一个红色的圆
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
