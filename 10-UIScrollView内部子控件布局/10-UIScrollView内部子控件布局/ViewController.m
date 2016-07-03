//
//  ViewController.m
//  10-UIScrollView内部子控件布局
//
//  Created by yhp on 16/7/3.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@",NSStringFromCGSize(self.scrollView.contentSize));
}

@end
