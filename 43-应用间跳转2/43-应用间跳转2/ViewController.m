//
//  ViewController.m
//  43-应用间跳转2
//
//  Created by yhp on 2017/4/22.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "TimeLineViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"honeToTimeline"]) {
        TimeLineViewController* timeLineVc = segue.destinationViewController;
        timeLineVc.urlString = self.urlString;
    }
}


@end
