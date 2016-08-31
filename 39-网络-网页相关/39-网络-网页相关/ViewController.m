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

-(void)call:(NSString*)number
{
//    UIApplication* app = [UIApplication sharedApplication];
//    [app openURL:[NSURL URLWithString:@"tell://10010"]];
    NSLog(@"%s,%@",__func__,number);
}

-(void)sendMessage:(NSString*)number
{
    NSLog(@"%s,%@",__func__,number);
}

-(void)openCamera:(NSString*)number
{
    NSLog(@"%s,%@",__func__,number);
}

#pragma mark - <UIWebViewDelegate>
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSString* result = [webView stringByEvaluatingJavaScriptFromString:@"login();"];
//    NSLog(@"%@",result);
//   self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    

}

/*JS 调用OC代码
 * JS 第三方框架:webViewJavaScriptBridge
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    NSLog(@"%@",request.URL);
    NSString* url = request.URL.absoluteString;
    NSString* scheme = @"yhp://";
    if ([url hasPrefix:scheme]) {
        NSString* path = [url substringFromIndex:scheme.length];
        NSArray* subPaths = [path componentsSeparatedByString:@"?"];
        // 方法名
        NSString* methodName = [[subPaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        NSString* params = [subPaths lastObject];
        [self performSelector:NSSelectorFromString(methodName) withObject:params];
        return  NO;
    }
    
    return YES;
}

@end
