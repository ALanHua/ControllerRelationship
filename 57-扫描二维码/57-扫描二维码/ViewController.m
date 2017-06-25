//
//  ViewController.m
//  57-扫描二维码
//
//  Created by yhp on 2017/6/25.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
/** session */
@property(nonatomic,strong)AVCaptureSession* session;
@property(nonatomic,weak)AVCaptureVideoPreviewLayer* layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1,创建一个捕捉会话
    AVCaptureSession* session = [[AVCaptureSession alloc]init];
    self.session = session;
    // 2,添加输入设备
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    // 3,添加输出数据
    AVCaptureMetadataOutput* output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 4,添加扫描图层
    AVCaptureVideoPreviewLayer* layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.frame = self.view.bounds;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
    // 开始扫描
    [session startRunning];
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        // 获取扫描结果
        AVMetadataMachineReadableCodeObject* object = [metadataObjects lastObject];
        NSLog(@"%@",object.stringValue);
        self.textLabel.text = object.stringValue;
        // 停止扫描
        [self.session stopRunning];
        // 移除图层
        [self.layer removeFromSuperlayer];
    }else{
       NSLog(@"no data");
    }
}


@end
