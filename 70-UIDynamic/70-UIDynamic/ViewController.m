//
//  ViewController.m
//  70-UIDynamic
//
//  Created by yhp on 2017/7/11.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
/** 仿真器 */
@property(nonatomic,strong)UIDynamicAnimator* animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.animator removeAllBehaviors];
    // 创建捕捉行为
    CGPoint point = [[touches anyObject]locationInView:self.view];
    
    UISnapBehavior* snap = [[UISnapBehavior alloc]initWithItem:self.redView snapToPoint:point];
    // 设置阻力系数
    snap.damping = 0.5;
    // 添加到仿真器
    [self.animator addBehavior:snap];
    
}

-(void)gravityAndCollision
{
    // 创建仿真行为，并指定仿真元素
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    // 设置重力的向量值
    gravity.gravityDirection = CGVectorMake(1.0, 3.0);
    // 设置碰撞行为
    UICollisionBehavior* collision = [[UICollisionBehavior alloc]initWithItems:@[self.redView,self.blueView]];
    // 设置碰撞边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    // 给碰撞行为添加边界
    CGPoint startPoint = CGPointMake(0, self.view.bounds.size.height * 2 / 3);
    CGPoint endPoint   = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height * 2 / 3);
    [collision addBoundaryWithIdentifier:@"lineBoundary" fromPoint:startPoint toPoint:endPoint];
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    [collision addBoundaryWithIdentifier:@"bezierPath" forPath:bezierPath];
    // 将仿真行为加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}


#pragma mark - 懒加载
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

@end
