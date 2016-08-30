//
//  ViewController.m
//  39-网络-网页相关
//
//  Created by yhp on 16/8/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JSContextRef.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController
/**
 *  iOS: Xode
 *  Java: eclipse/MyEclipse
 *  Android: eclipse/Android Studio
 *  网页：Sublime Dreamweaver
 *  iOS App == Native + HTML5
 网页组成:
 HTML--- 内容(文字，图片)
 CSS --- 样式，美化
 JS  --- 动态效果,事件处理，交互
 */
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.webView loadRequest:[NSURLRequest requestWithURL: [[NSBundle mainBundle]URLForResource:@"index" withExtension:@"html"]]];
}

-(void)call
{
    UIApplication* app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"tell://10010"]];
}

#pragma mark - <UIWebViewDelegate>
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString* result = [webView stringByEvaluatingJavaScriptFromString:@"login();"];
    NSLog(@"%@",result);
//   self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    

}
@end
