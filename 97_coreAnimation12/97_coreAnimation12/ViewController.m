//
//  ViewController.m
//  97_coreAnimation12
//
//  Created by yhp on 2018/1/25.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *layerView;

// nonnull setter 和 getter 方法不能为nil
//@property(nonatomic,strong,nonnull)NSArray* names;
//@property(nonatomic,strong)NSArray* __nonnull names;

// nullable setter 和 getter 方法能为nil
// 默认是不加 nullable ，更多的作用在于程序员之间的交流，提醒某个属性是nil
//@property(nonatomic,strong,nullable)NSArray* names;
//@property(nonatomic,strong)NSArray* __nullable names;


// null_resettable setter 可以为空，getter 方法不能为空
//@property(null_resettable,nonatomic,strong)NSArray* names;

//NS_ASSUME_NONNULL_BEGIN
//// 中间的属性都是nonnull
//NS_ASSUME_NONNULL_END

@end

@implementation ViewController

- (void)tranform2D
{
    //    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    CGAffineTransform transform = CGAffineTransformIdentity;
    //    缩小50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    //   旋转 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI_2);
    //   平移200 point
    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    self.layerView.layer.affineTransform = transform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D transform = CATransform3DIdentity;
//    想象中视角相机和屏幕之间的距离 通常500 - 1000 已经很好了
    transform.m34 = - 1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1.0, 0);
    self.layerView.layer.transform = transform;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
