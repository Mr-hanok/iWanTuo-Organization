//
//  ApiCancelAttentionRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiCancelAttentionRequest.h"

@implementation ApiCancelAttentionRequest

- (NSString *)urlAction {
    return CancelAttentionOrgAction;
    
}

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamesWithOrgId:(NSString *)organizationAccounts patriarchAccounts:(NSString *)patriarchAccounts {
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setObject:patriarchAccounts forKey:@"patriarchAccounts"];
}

@end
