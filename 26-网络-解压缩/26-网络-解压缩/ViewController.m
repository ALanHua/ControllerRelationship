//
//  ViewController.m
//  26-网络-解压缩
//
//  Created by yhp on 16/8/22.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createZipFile];
    
}

-(void)createZipFile
{
    [SSZipArchive createZipFileAtPath:@"/Users/smartwater/Downloads/test.zip" withContentsOfDirectory:@"/Users/smartwater/Downloads/Lucky"];
}

-(void)unZipFile
{
   [SSZipArchive unzipFileAtPath:@"/Users/smartwater/Downloads/test.zip"  toDestination:@"/Users/smartwater/Downloads/Luck"];
}

@end
