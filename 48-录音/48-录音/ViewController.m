//
//  ViewController.m
//  48-录音
//
//  Created by yhp on 2017/5/22.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
/** 录音对象 */
@property(nonatomic,strong)AVAudioRecorder* recorder;
@end

@implementation ViewController

- (AVAudioRecorder *)recorder
{
    if (_recorder == nil) {
        NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",path);
        NSString* filePath = [path stringByAppendingPathComponent:@"ext.caf"];
        // 1,创建录音文件的地址
        NSURL* url = [NSURL URLWithString:filePath];
        // 2，创建录音对象
        NSDictionary* dict = [NSDictionary dictionary];
        _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:dict error:nil];
        [self.recorder prepareToRecord];
    }
    return _recorder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)startRecord:(UIButton *)sender {
    // 4,开始录音
    [self.recorder record];
}
- (IBAction)stopRecord:(UIButton *)sender {
    [self.recorder stop];
}

@end
