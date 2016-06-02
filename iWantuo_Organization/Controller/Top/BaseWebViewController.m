//
//  BaseWebViewController.m
//  DoctorYL
//
//  Created by chenTengfei on 15/6/4.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "BaseWebViewController.h"


@interface BaseWebViewController ()



@end

@implementation BaseWebViewController

@synthesize webViewDelegate = _webViewDelegate;
@synthesize scalesPageToFit = _scalesPageToFit;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenBoundWidth, kScreenBoundHeight - kNavigationHeight)];
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL: url];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Get/Set方法
- (BOOL)scalesPageToFit {
    return self.webView.scalesPageToFit;
}

- (void)setScalesPageToFit:(BOOL)scalesPageToFit {
    self.webView.scalesPageToFit = scalesPageToFit;
}

- (id<UIWebViewDelegate>)webViewDelegate {
    return self.webView.delegate;
}

- (void)setWebViewDelegate:(id<UIWebViewDelegate>)webViewDelegate {
    self.webView.delegate = webViewDelegate;
}

@end
