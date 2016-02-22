//
//  HudWebViewController.m
//  DoctorYL
//
//  Created by chenTengfei on 15/6/4.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "WebHudViewController.h"

@interface WebHudViewController ()<UIWebViewDelegate>

@end

@implementation WebHudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webViewDelegate = self;
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

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [HUDManager showLoadingHUDView:self.webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [HUDManager hideHUDView];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [HUDManager showWarningWithText:kDefaultWebErrorString];
}

@end
