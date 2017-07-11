//
//  ViewController.m
//  69-l蓝牙
//
//  Created by yhp on 2017/7/10.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKPeerPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** session */
@property(nonatomic,strong)GKSession* session;
@end

@implementation ViewController

#pragma mark - 选择照片
- (IBAction)pickImage {
    // 照片源是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        return;
    }
    // 创建照片选择控制器
    UIImagePickerController* ipc = [[UIImagePickerController alloc]init];
    // 设置代理
    ipc.delegate = self;
    // 设置照片源
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 弹出控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
- (IBAction)conectDevice {
    // 创建连接控制器
    GKPeerPickerController* ppc = [[GKPeerPickerController alloc]init];
    // 设置代理，可用监听是否连接成功
    ppc.delegate = self;
    // 弹出控制器
    [ppc show];
}

- (IBAction)sendImage {
    
    NSData* imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
    // 发送照片
    [self.session sendDataToAllPeers:imageData withDataMode:GKSendDataReliable error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    // 退出控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <GKPeerPickerControllerDelegate>
/**
 当建立连接成功时，会调用该方法
 @param picker 控制器
 @param peerID 节点ID
 @param session 建立连接之后可以通过会话传输数据
 */
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
//    NSLog(@"连接成功");
    self.session = session;
    // 设置句柄
    [self.session setDataReceiveHandler:self withContext:nil];
    
    [picker dismiss];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;
{
    // 直接转成imge
    self.imageView.image = [UIImage imageWithData:data];
}

@end
