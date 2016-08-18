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
#import "GDataXMLNode.h"

@interface ViewController () <NSXMLParserDelegate>

/** 视频数据 */
@property(nonatomic,strong)NSMutableArray* videos;
#if 0     // JSON
@property(nonatomic,strong)NSArray* videos;
#endif

@end

@implementation ViewController

- (NSMutableArray *)videos
{
    if (!_videos) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 1,路径
#if 0 // JSON
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/video"];
#endif
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=XML"];
    // 2，请求对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    // 3，发送请求
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
#if 0   // JSON 解析方式
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        self.videos = [YHPVideo mj_objectArrayWithKeyValuesArray:dict[@"videos"]];
#endif
#if 0  // NSXMLParser
        NSXMLParser* parser = [[NSXMLParser alloc]initWithData:data];
        // 设置代理 ，监听解析
        parser.delegate = self;
        // 开始解析
        [parser parse]; // 阻塞方式
#endif
        GDataXMLDocument* doc = [[GDataXMLDocument alloc]initWithData:data error:nil];
        //  获取vide 元素
        NSArray* elements = [doc.rootElement elementsForName:@"video"];
        for (GDataXMLElement* ele in elements) {
            YHPVideo* video = [[YHPVideo alloc]init];
            video.name = [[ele attributeForName:@"name"]stringValue];
            video.image = [[ele attributeForName:@"image"]stringValue];
            video.url = [[ele attributeForName:@"url"]stringValue];
            video.length = [[[ele attributeForName:@"length"]stringValue]integerValue];
            
            [self.videos addObject:video];
        }
        
        // 刷新表格
        [self.tableView reloadData];
    }];
}

#pragma mark - <NSXMLParserDelegate>
#if 0
/*
 *  解析到某个元素结尾
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

/*
 *  解析到某个元素
 */
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }
    NSLog(@"%@",attributeDict);
    YHPVideo* video = [YHPVideo mj_objectWithKeyValues:attributeDict];
    
    [self.videos addObject:video];
    
    
}
/*
 *  开始解析
 */
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}
/**
 *  解析完毕
 */
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}
#endif
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
