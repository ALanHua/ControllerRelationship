//
//  ViewController.m
//  100_coreAnimation15
//
//  Created by yhp on 2018/1/30.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION   0, 1, -0.5
#define AMBIENT_LIGHT     0.5

@interface ViewController ()

/** faces */
@property(nonatomic,strong)NSMutableArray<UIView*>* faces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//   创建一个空数组
    self.faces = [NSMutableArray array];
//  给子控件设置动画属性
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = perspective;
//  添加cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0,0,100);
    [self addFace:0 withTransform:transform];
//  添加cube face 2
    transform = CATransform3DMakeTranslation(100,0,0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
//  添加cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

-(void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView* face = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    face.backgroundColor = [UIColor whiteColor];
    face.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:60 weight:10];
    [button setTitleColor:[UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitle:@(index + 1).stringValue forState:UIControlStateNormal];
    [button setTitle:@(index + 1).stringValue forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [face addSubview:button];
    [self.view addSubview:face];
    [self.faces addObject:face];
    face.layer.transform = transform;
    [self applyLightingToFace:face.layer];
}

/**
 这个函数里面的看不懂
 @param face 图层
 */
-(void)applyLightingToFace:(CALayer*)face{
    CALayer* layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
//    转换transform到矩阵
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = [self matrixFrom3DTransformation:transform];
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
//    获取正常人脸
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
//    get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light,normal);
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor* color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

-(GLKMatrix4)matrixFrom3DTransformation:(CATransform3D)transform{
    
    GLKMatrix4 matrix = GLKMatrix4Make(transform.m11, transform.m12, transform.m13, transform.m14,transform.m21, transform.m22, transform.m23, transform.m24,
        transform.m31, transform.m32, transform.m33, transform.m34,
        transform.m41,transform.m42, transform.m43, transform.m44);
    
    return matrix;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
