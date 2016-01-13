//
//  NetworkMacro.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#ifndef StudyChina_NetworkMacro_h
#define StudyChina_NetworkMacro_h

//#define SERVER_HOST_PRODUCT             @"http://192.168.1.208/ThinkSNS_V4_Beta_Full/api.php?app=api&"           // 内网地址
#define SERVER_HOST_PRODUCT             @"http://www.v2099.com.cn/api.php?app=api"           // 外网地址
#define SERVER_FILE_PRODUCT             @"http://img.yilingboshi.com/"              // 图片服务器地址

#define SDKKey_Msg                  @"msg"
#define SDKKey_Status               @"status"

#define kDefaultServerErrorString               @"服务器异常，请稍后再试"
#define kDefaultNetWorkErrorString              @"网络连接异常"
#define kDefaultQuitErrorString                 @"您的账号已经在别处登录!"
#define kDefaultWebErrorString                  @"抱歉,此网页出现了问题"

#pragma mark - 请求地址

#define kRequestKey                         @"THINKSNS"

#define kRequestTokenAction                 @"index.php?app=api&mod=Oauth&act=authorize"    // 获取用户token

#define LoginSucessedNotification   @"LoginSucessedNotification"
#define LoginOutNotification        @"LoginOutNotification"
#define kRequestDataRows  @"15"




#endif
