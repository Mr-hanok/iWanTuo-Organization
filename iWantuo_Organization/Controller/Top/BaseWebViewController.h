//
//  BaseWebViewController.h
//  DoctorYL
//
//  Created by chenTengfei on 15/6/4.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

@property (nonatomic ,strong) NSString *webUrl;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, assign) id<UIWebViewDelegate> webViewDelegate;

@property (nonatomic, assign) BOOL scalesPageToFit;

@end
