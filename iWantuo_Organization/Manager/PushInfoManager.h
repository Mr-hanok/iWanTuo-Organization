//
//  PushInfoManager.h
//  DoctorYL
//
//  Created by chenTengfei on 15/6/3.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 推送信息管理类
@interface PushInfoManager : NSObject

+ (PushInfoManager *)sharedInstance;

- (void)offLineReceivePushInfoWithDict:(NSDictionary *)userInfo;

- (void)onLineReceivePushInfoWithDict:(NSDictionary *)userInfo;
@end
