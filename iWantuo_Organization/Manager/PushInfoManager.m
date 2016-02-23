//
//  PushInfoManager.m
//  DoctorYL
//
//  Created by chenTengfei on 15/6/3.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "PushInfoManager.h"

//#import "MsgPlaySound.h"
#import "MsgModel.h"
#import "MyNewsDetailViewController.h"
#import "SystemHandler.h"

//#import "MyChildModel.h"
//#import "FollowBaseViewController.h"

@interface PushInfoManager ()

@end

@implementation PushInfoManager

static PushInfoManager *sharedInstance;
#pragma mark Singleton Model
+ (PushInfoManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PushInfoManager alloc]init];
    });
    return sharedInstance;
}


// 在线收到信息
- (void)onLineReceivePushInfoWithDict:(NSDictionary *)userInfo {
    
    NSData *jsonData = [[userInfo objectForKey:@"payload"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return ;
    }
    
    NSString *title = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
    title = [NSString stringWithFormat:@"%@...", title];
    if ([[dic objectForKey:@"type"] integerValue] == 0) {
        //跳转我的消息详情页
        [AlertViewManager showAlertViewWithTitle:@"消息提醒" Message:title cancelTitle:@"取消" confirmTitle:@"跳转" handlerBlock:^{
            MsgModel *model = [[MsgModel alloc] init];
            model.push_name = [ValueUtils stringFromObject:[dic objectForKey:@"pushName"]];
            model.push_details = [ValueUtils stringFromObject:[dic objectForKey:@"pushDetail"]];
            model.create_date = [ValueUtils stringFromObject:[dic objectForKey:@"createTime"]];
            
            MyNewsDetailViewController *detailVC = [[MyNewsDetailViewController alloc] init];
            detailVC.model = model;
            detailVC.hidesBottomBarWhenPushed = YES;
            //跳转啊~~~
            UINavigationController *nav = [self getCurrentNavigationController];
            [nav pushViewController:detailVC animated:YES];
        }];
        
    } else if ([[dic objectForKey:@"type"] integerValue] == 3) {
        //踢人
        [AlertViewManager showAlertViewSuccessedMessage:@"您的账号已在别处登录." handlerBlock:^{
            //保存用户信息
            [AccountManager sharedInstance].account.isLogin = @"no";
            [[AccountManager sharedInstance] saveAccountInfoToDisk];
            kRootViewController = [SystemHandler rootViewController];
        }];
    }

}

// 不在线收到信息
- (void)offLineReceivePushInfoWithDict:(NSDictionary *)userInfo {
    
    NSData *jsonData = [[userInfo objectForKey:@"payload"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return ;
    }
    if ([[dic objectForKey:@"type"] integerValue] == 0) {
        //跳转我的消息详情页
        MsgModel *model = [[MsgModel alloc] init];
        model.push_name = [ValueUtils stringFromObject:[dic objectForKey:@"pushName"]];
        model.push_details = [ValueUtils stringFromObject:[dic objectForKey:@"pushDetail"]];
        model.create_date = [ValueUtils stringFromObject:[dic objectForKey:@"createTime"]];
        
        MyNewsDetailViewController *detailVC = [[MyNewsDetailViewController alloc] init];
        detailVC.model = model;
        detailVC.hidesBottomBarWhenPushed = YES;
        //跳转啊~~~
        UINavigationController *nav = [self getCurrentNavigationController];
        [nav pushViewController:detailVC animated:YES];
        
    } else if ([[dic objectForKey:@"type"] integerValue] == 3) {
        //踢人
        
        //保存用户信息
        [AccountManager sharedInstance].account.isLogin = @"no";
        [[AccountManager sharedInstance] saveAccountInfoToDisk];
        kRootViewController = [SystemHandler rootViewController];
        [HUDManager showWarningWithText:@"您的账号已在别处登录."];

    }
}

- (UINavigationController *)getCurrentNavigationController {

    UITabBarController * tabBarVC = (UITabBarController *)kRootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    return nav;
}

@end
