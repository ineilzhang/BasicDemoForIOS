//
//  NZWebViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/10/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZWebViewController.h"
#import "Security/SecureTransport.h"

@interface NZWebViewController ()

@end

@implementation NZWebViewController

#pragma mark - Override super method

- (void)loadView
{
    UIWebView *webView = [UIWebView new];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy load

- (void)setUrl:(NSURL *)url
{
    _url = url;
    if (_url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [(UIWebView *)self.view loadRequest:request];
    }
}

@end
