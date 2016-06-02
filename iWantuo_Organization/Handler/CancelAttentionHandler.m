//
//  CancelAttentionHandler.m
//  StudyChina
//
//  Created by 月 吴 on 15/10/14.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import "CancelAttentionHandler.h"

#import "ApiCancelAttentionRequest.h"

@interface CancelAttentionHandler()<APIRequestDelegate>

@property(nonatomic, strong) ApiCancelAttentionRequest *cancelApi;
@property(nonatomic, strong) void (^success)(NSString *result);
@property(nonatomic, strong) void (^failure)(NSString *message);

@end

@implementation CancelAttentionHandler
static CancelAttentionHandler *sharedInstance = nil;
#pragma mark Singleton Model
+ (CancelAttentionHandler *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CancelAttentionHandler alloc]init];
        sharedInstance.cancelApi = [[ApiCancelAttentionRequest alloc] initWithDelegate:sharedInstance];
    });
    return sharedInstance;
}

- (void)cancelAttentionWithOrgId:(NSString *)orgId
                          success:(void (^)(NSString *result))success
                          failure:(void (^)(NSString *message))failure {
    
    self.success = success;
    self.failure = failure;
    [self.cancelApi setApiParamesWithOrgId:orgId patriarchAccounts:[AccountManager sharedInstance].account.loginAccounts];
    [APIClient execute:self.cancelApi];
}

#pragma mark - APIRequestDelegate

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    if (sr.success) {
        if (self.cancelApi == api) {
            self.success(@"取消收藏成功");
        }
    }
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr
{
    NSString *message = sr.msg;
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    self.failure(message);
}

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    self.failure(kDefaultNetWorkErrorString);
}

@end
