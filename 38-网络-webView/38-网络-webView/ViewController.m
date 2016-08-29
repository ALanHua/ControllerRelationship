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
    
    // Native + HTML5
    NSURL* url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate =self;
    [self.webView loadRequest:request];
    
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


@end
