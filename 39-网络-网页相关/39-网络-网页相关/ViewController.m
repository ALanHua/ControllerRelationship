//
//  ViewController.m
//  39-网络-网页相关
//
//  Created by yhp on 16/8/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JSContextRef.h>
#import "NSObject+YHPExtension.h"
// 去除Xcode编译警告
//#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//#pragma clang diagnostic pop
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
//    [self performSelector:@selector(call:) withObjects:@[@"10086"]];
//    [self performSelector:@selector(sendMessage:number2:number3:) withObjects:
//                    @[[NSNull null],@"200",@"300"]];
}

-(void)call:(NSString*)number
{
//    UIApplication* app = [UIApplication sharedApplication];
//    [app openURL:[NSURL URLWithString:@"tell://10010"]];
    NSLog(@"%s,%@",__func__,number);
}

-(void)sendMessage:(NSString*)number number2:(NSString*)number2 number3:(NSString*)number3
{
    NSLog(@"%s,%@,%@,%@",__func__,number,number2,number3);
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
        
        NSArray* subParams = nil;
        NSString* param = [subPaths lastObject];
        if ([param containsString:@"&"]) {
            subParams = [param componentsSeparatedByString:@"&"];
        }
        [self performSelector:NSSelectorFromString(methodName) withObjects:subParams];
        return  NO;
    }
    
    return YES;
}

@end
