//
//  ViewController.m
//  22-网络-JSON解析
//
//  Created by yhp on 16/8/16.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YHPVideo.h"
#import "MJExtension.h"


@interface ViewController ()

/** 视频数据 */
@property(nonatomic,strong)NSArray* videos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1,路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/video"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        self.videos = dict[@"videos"];
        self.videos = [YHPVideo mj_objectArrayWithKeyValuesArray:dict[@"videos"]];
        // 刷新表格
        [self.tableView reloadData];
    }];
}

#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"video";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    YHPVideo* video = self.videos[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长:%zd",video.length];
    NSString* image = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:video.image];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"小新"]];
    
    return cell;
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHPVideo* video = self.videos[indexPath.row];
    NSString* urlString = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:video.url];
    //  创建视频播放器
   MPMoviePlayerViewController* vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlString]];
    //  显示视频
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)parseJSON
{
    // 1,路径
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 解析JSON
        /*
         NSJSONReadingMutableContainers  NSMutableDictionary
         NSJSONReadingMutableLeaves      里面的也是可变
         NSJSONReadingAllowFragments     允许返回不是数组和字典
         */
        NSDictionary* dict = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict[@"success"]);
        NSData* d = [NSJSONSerialization dataWithJSONObject:@{@"name":@"YHP"} options:NSJSONWritingPrettyPrinted error:nil];
        NSString* str = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        //        NSLog(@"%@",dict);
        //        [dict writeToFile:@"/Users/smartwater/Desktop/video.plist" atomically:YES];
    }];
}
@end
