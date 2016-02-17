//
//  APNsManager.m
//  DoctorYL
//
//  Created by 张玺 on 15/1/13.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define kGtAppId           @"iMahVVxurw6BNr7XSn9EF2"
#define kGtAppKey          @"yIPfqwq6OMAPp6dkqgLpG5"
#define kGtAppSecret       @"G0aBqAD6t79JfzTB6Z5lo5"

#import "APNsManager.h"
#import "AppDeviceManager.h"


@interface APNsManager()<GeTuiSdkDelegate>
@property (nonatomic, strong) GeTuiSdk *gexin;
@end

@implementation APNsManager

static APNsManager *sharedInstance = nil;
#pragma mark Singleton Model
+ (APNsManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APNsManager alloc]init];
        sharedInstance.clientId = @"";
        sharedInstance.deviceToken = @"";
        sharedInstance.sdkStatus = SdkStatusStarting;

    });
    return sharedInstance;
}

- (void)registerDeviceToken:(NSString *)deviceToken {
    self.deviceToken = deviceToken;
    [GeTuiSdk registerDeviceToken:deviceToken];
}

- (void)startSdk
{
    if (self.sdkStatus == SdkStatusStoped)
    {
        [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];

    }
    if (self.sdkStatus == SdkStatusStarted) {
        [GeTuiSdk registerDeviceToken:self.deviceToken];
    }
}
- (void)stopSdk
{
    [GeTuiSdk destroy];
    self.sdkStatus = SdkStatusStoped;
}

#pragma mark - GexinSdkDelegate
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册
    self.clientId = clientId;
    [APNsManager sharedInstance].sdkStatus = SdkStatusStarted;
    NSLog(@"----- GexinSdkDidRegisterClient:%@",clientId);
    
//    if ([AccountManager sharedInstance].isLogin) {
//        [[SavePushTokenManager sharedInstance] executeAPIs];
//        [self startSdk];
//    }
}

- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
//    NSData *payload = [_gexin retrivePayloadById:payloadId];
//    NSString *payloadMsg = nil;
//    if (payload) {
//        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
//                                              length:payload.length
//                                            encoding:NSUTF8StringEncoding];
//    }
//    
//    NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++[APNsManager sharedInstance].lastPayloadIndex, [NSDate date], payloadMsg];
//    
//    
//    DDLogInfo(@"payloadId:%@",payloadId);
//    DDLogInfo(@"appId:%@",appId);
//    DDLogInfo(@"----GexinSdkDidReceivePayload: %@", record);
//    
//    [[PushRecordManager sharedInstance] executeAPI];
//    
//    
//    if (payloadMsg!=nil) {
//        
//        NSData *jsonData = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//        if(err) {
//            NSLog(@"json解析失败：%@",err);
//            return ;
//        }
//    }
}

- (void)GexinSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"----GexinSdkDidSendMessage: %@", record);
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    [AlertViewManager showAlertViewWithMessage:[error localizedDescription]];
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"----GexinSdkDidOccurError: %@", [error localizedDescription]);
}

#pragma mark - 收到消息处理



@end
