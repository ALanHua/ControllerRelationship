//
//  ViewController.m
//  62-换肤
//
//  Created by yhp on 2017/6/29.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "YHPSkinTool.h"
//NSString* const skinColor = @"skinColor";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceIageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;

@end

@implementation ViewController

-(void)setUpSkinColor
{
    NSString* skinColor = [[NSUserDefaults standardUserDefaults]objectForKey:@"skinColor"];
    if (skinColor == nil) {
        skinColor = @"blue";
    }
    [self changeSkinWithSkinColor:skinColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeImage];
}


- (IBAction)changeToBlueSkin {
    [YHPSkinTool setSkinColor:@"blue"];
    [self changeImage];
//    [self changeSkinWithSkinColor:@"blue"];
}

- (IBAction)changeToRedSkin {
    [YHPSkinTool setSkinColor:@"red"];
    [self changeImage];
//    [self changeSkinWithSkinColor:@"red"];
}

- (IBAction)changeToGreenSkin {
    [YHPSkinTool setSkinColor:@"green"];
    [self changeImage];
//    [self changeSkinWithSkinColor:@"green"];
}
- (IBAction)changeToOrangeSkin {
    
    [YHPSkinTool setSkinColor:@"orange"];
    [self changeImage];
}


-(void)changeImage
{
    self.faceIageView.image = [YHPSkinTool skinToolWithImageName:@"face"];
    self.heartImageView.image = [YHPSkinTool skinToolWithImageName:@"heart"];
    self.rectImageView.image = [YHPSkinTool skinToolWithImageName:@"rect"];
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
}


@end
