//
//  TwoViewController.m
//  62-换肤
//
//  Created by yhp on 2017/7/1.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "TwoViewController.h"
#import "YHPSkinTool.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceIageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.faceIageView.image = [YHPSkinTool skinToolWithImageName:@"face"];
    self.heartImageView.image = [YHPSkinTool skinToolWithImageName:@"heart"];
    self.rectImageView.image = [YHPSkinTool skinToolWithImageName:@"rect"];
}

@end
