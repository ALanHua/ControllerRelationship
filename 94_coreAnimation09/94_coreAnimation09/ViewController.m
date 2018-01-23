//
//  ViewController.m
//  94_coreAnimation09
//
//  Created by yhp on 2018/1/23.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage* maskImage = [UIImage imageNamed:@"Cone"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
//  添加mask
    self.imageView.layer.mask = maskLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
