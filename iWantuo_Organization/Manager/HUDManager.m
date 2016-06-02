//
//  HUDManager.m
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/28.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "HUDManager.h"

static MBProgressHUD *HUDView;
@implementation HUDManager

+ (void)showWarningWithText:(NSString *)text {
    [HUDManager hideHUDView];
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    hud.margin = 12.f;
    [hud hide:YES afterDelay:1.0];
}

+ (void)showLoadingHUDView:(UIView*)view
{
    HUDView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDView.mode = MBProgressHUDModeIndeterminate;
    HUDView.margin = 18.f;
    HUDView.opacity = 0.55;
    HUDView.dimBackground = YES;
    HUDView.labelText = @"努力加载中";
    HUDView.minShowTime = 0.3;
    HUDView.labelFont = [UIFont boldSystemFontOfSize:14];
}

+ (void)showLoadingHUDView:(UIView*)view withText:(NSString *)text {
    HUDView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDView.mode = MBProgressHUDModeIndeterminate;
    HUDView.margin = 18.f;
    HUDView.opacity = 0.55;
    HUDView.dimBackground = YES;
    HUDView.labelText = text;
    HUDView.minShowTime = 0.3;
    HUDView.labelFont = [UIFont boldSystemFontOfSize:14];
}

+ (void)hideHUDView
{
    [HUDView hide:YES];
}

@end
