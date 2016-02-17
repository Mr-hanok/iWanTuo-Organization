//
//  ApiSystemMsgRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSystemMsgRequest.h"

@implementation ApiSystemMsgRequest

- (NSString *)urlAction {
    return kMineSystemMsgAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithPage:(NSString *)page
{
    [self.params setObject:[AccountManager sharedInstance].account.loginAccounts forKey:@"login_accounts"];
    [self.params setObject:page forKey:@"page"];
    [self.params setObject:kRequestDataRows forKey:@"rows"];
    
}

@end
