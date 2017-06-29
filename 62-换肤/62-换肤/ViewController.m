//
//  ViewController.m
//  62-换肤
//
//  Created by yhp on 2017/6/29.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

//NSString* const skinColor = @"skinColor";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceIageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* skinColor = [[NSUserDefaults standardUserDefaults]objectForKey:@"skinColor"];
    if (skinColor == nil) {
        skinColor = @"blue";
    }
    [self changeSkinWithSkinColor:skinColor];
}


- (IBAction)changeToBlueSkin {
    [self changeSkinWithSkinColor:@"blue"];
}

- (IBAction)changeToRedSkin {
    [self changeSkinWithSkinColor:@"red"];
}

- (IBAction)changeToGreenSkin {
    [self changeSkinWithSkinColor:@"green"];
}


/**
 设置不同颜色的图片
 @param skinColor 颜色
 */
-(void)changeSkinWithSkinColor:(NSString*)skinColor
{
    NSString* faceImageName = [NSString stringWithFormat:@"skin/%@/face",skinColor];
    NSString* heartImageName = [NSString stringWithFormat:@"skin/%@/heart",skinColor];
    NSString* rectImageName = [NSString stringWithFormat:@"skin/%@/rect",skinColor];
    self.faceIageView.image = [UIImage imageNamed:faceImageName];
    self.heartImageView.image = [UIImage imageNamed:heartImageName];
    self.rectImageView.image = [UIImage imageNamed:rectImageName];
    // 记录选中的颜色
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:@"skinColor"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
