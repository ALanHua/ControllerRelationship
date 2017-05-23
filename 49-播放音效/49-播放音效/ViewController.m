//
//  ViewController.m
//  49-播放音效
//
//  Created by yhp on 2017/5/23.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

/** soundID */
@property(nonatomic,assign)SystemSoundID soundID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (SystemSoundID)soundID
{
    if (_soundID == 0) {
        // 创建SystemSoundID
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"win.aac" withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef _Nonnull)(url);
        AudioServicesCreateSystemSoundID(urlRef, &_soundID);
    }
    
    return _soundID;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 播放音效
    //    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlayAlertSound(self.soundID);// 带振动效果
}


@end
