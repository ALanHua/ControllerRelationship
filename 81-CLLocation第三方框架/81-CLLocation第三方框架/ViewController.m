//
//  ViewController.m
//  81-CLLocation第三方框架
//
//  Created by yhp on 2017/7/26.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "INTULocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
            timeout:10.0
            delayUntilAuthorized:YES
            block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
             if (status == INTULocationStatusSuccess) {
                 NSLog(@"%ld",achievedAccuracy);
             }
             else if (status == INTULocationStatusTimedOut) {

             }
             else {
                 
             }
    }];
}


@end
