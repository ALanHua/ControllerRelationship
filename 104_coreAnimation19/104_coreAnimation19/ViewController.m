//
//  ViewController.m
//  104_coreAnimation19
//
//  Created by yhp on 2018/2/10.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500;
    self.view.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer* cub1 = [self cubeWithTransform:c1t];
    [self.view.layer addSublayer:cub1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.view.layer addSublayer:cube2];
    
}

- (CALayer*)faceWithTransform:(CATransform3D)transform
{
    CALayer* face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red   = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue  = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    face.transform = transform;
    
    return face;
}

-(CALayer*)cubeWithTransform:(CATransform3D)transform
{
    CATransformLayer* cube = [CATransformLayer layer];
//  z轴 平移 50个单位
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
//  x轴 平移 50个单位 y轴旋转90度
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//  y轴 平移 -50个单位，x轴旋转90度
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//  y轴 平移 50个单位，x轴旋转-90度
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//  add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//  add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//  锚点
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
//  添加transform
    cube.transform = transform;
    
    return cube;
}


@end
