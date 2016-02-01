//
//  AttentionHandler.m
//  StudyChina
//
//  Created by 月 吴 on 15/10/13.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import "AttentionHandler.h"
#import "ApiAttentionRequest.h"

@interface AttentionHandler()<APIRequestDelegate>

@property(nonatomic, strong) ApiAttentionRequest *attentionApi;
@property(nonatomic, strong) void (^success)(NSString *result);
@property(nonatomic, strong) void (^failure)(NSString *message);

@end

@implementation AttentionHandler

static AttentionHandler *sharedInstance = nil;
#pragma mark Singleton Model
+ (AttentionHandler *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AttentionHandler alloc]init];
        sharedInstance.attentionApi = [[ApiAttentionRequest alloc] initWithDelegate:sharedInstance];
    });
    return sharedInstance;
}

- (void)attentionWithOrgId:(NSString *)orgId
                         success:(void (^)(NSString *result))success
                         failure:(void (^)(NSString *message))failure {
    
    self.success = success;
    self.failure = failure;
    [self.attentionApi setApiParamesWithOrgId:orgId patriarchAccounts:[AccountManager sharedInstance].account.loginAccounts];
    [APIClient execute:self.attentionApi];
}

#pragma mark - APIRequestDelegate

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    if (sr.success) {
        if (self.attentionApi == api) {
            self.success(@"收藏成功");
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
