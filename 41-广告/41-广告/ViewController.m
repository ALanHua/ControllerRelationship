//
//  ViewController.m
//  41-广告
//
//  Created by yhp on 2017/4/21.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController ()<ADBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
     NSLog(@"%s",__func__);
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
     NSLog(@"%s",__func__);
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
     NSLog(@"%s",__func__);
}

@end
