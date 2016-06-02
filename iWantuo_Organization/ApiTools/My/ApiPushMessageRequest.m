//
//  ApiPushMessageRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiPushMessageRequest.h"

@implementation ApiPushMessageRequest

- (NSString *)urlAction {
    return kMinePushMsgAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithContent:(NSString *)content 
{
    [self.params setObject:[AccountManager sharedInstance].account.loginAccounts forKey:@"push_login_accounts"];
    [self.params setObject:[AccountManager sharedInstance].account.organizationAbbreviation forKey:@"push_name"];
    [self.params setObject:content forKey:@"push_details"];
    
    
}

@end
