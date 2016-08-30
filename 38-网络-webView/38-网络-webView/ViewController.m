//
//  ViewController.m
//  38-网络-webView
//
//  Created by yhp on 16/8/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation ViewController
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)forword:(UIBarButtonItem*)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(UIBarButtonItem*)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.webView.delegate =self;
//    [self.webView loadHTMLString:@"<html><body>哈哈哈</body></html>" baseURL:nil];
//    NSURL* url = [NSURL fileURLWithPath:@"/Users/smartwater/Downloads/01.pptx"];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    [self loadRequest2];
  
}
-(void)loadRequest2
{

    self.webView.delegate =self;
    
    // 检测各种特殊字符串
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSURL* url = [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    // 距离顶部下拉20
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

-(void)loadRequest
{
    // Native + HTML5
    NSURL* url = [NSURL URLWithString:@"http://www.520it.com/"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate =self;
    // 网页内容自适应
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:request];
    // 距离顶部下拉20
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}
/**
 *  每当webView即将发送一个请求之间，都会调用这个方法
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return YES: 允许加载这个请求
             NO:  静止加载这个请求
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    if ([request.URL.absoluteString containsString:@"video"]) {
        return NO;
    }
    
    return YES;
}

@end
