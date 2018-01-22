//
//  ViewController.m
//  91_coreAnimation06
//
//  Created by yhp on 2018/1/20.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong,nonatomic)CALayer* blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    添加图层
    [self.layerView.layer addSublayer:self.blueLayer];
}

- (void)pointChange:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //     获取 touch position
    CGPoint point = [[touches anyObject]locationInView:self.view];
    //    转换坐标
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    //    如果点在elf.layerView.layer 中
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.layerView.layer containsPoint:point]) {
            UIAlertController* vc = [UIAlertController alertControllerWithTitle:@"Inside Blue Layer" message:@"Blue" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
            [vc addAction:cancelAction];
            
            [self presentViewController:vc animated:YES completion:nil];
        }else{
            UIAlertController* vc = [UIAlertController alertControllerWithTitle:@"Inside White Layer" message:@"White" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
            [vc addAction:cancelAction];
            
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//     获取 touch position
    CGPoint point = [[touches anyObject]locationInView:self.view];
//    转换坐标
    CALayer* layer = [self.layerView.layer hitTest:point];
//    如果点在elf.layerView.layer 中
    if (layer == self.blueLayer) {
            UIAlertController* vc = [UIAlertController alertControllerWithTitle:@"Inside Blue Layer" message:@"Blue" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
            [vc addAction:cancelAction];
            
            [self presentViewController:vc animated:YES completion:nil];
    }else if (layer == self.layerView.layer){
        UIAlertController* vc = [UIAlertController alertControllerWithTitle:@"Inside White Layer" message:@"White" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [vc addAction:cancelAction];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
