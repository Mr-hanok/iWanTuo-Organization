//
//  ApiFollowCheckRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiFollowCheckRequest.h"

@implementation ApiFollowCheckRequest
- (NSString *)urlAction {
    return FollowCheckRequest;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithCreateDate:(NSString *)createDate
                         studentId:(NSString *)studentId
              organizationAccounts:(NSString *)organizationAccounts
                     {
    [self.params setValue:createDate forKey:@"createDate"];
    [self.params setValue:studentId forKey:@"studentId"];
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
}

@end
