//
//  ApiGetStudentInfoRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiGetStudentInfoRequest.h"

@implementation ApiGetStudentInfoRequest

- (NSString *)urlAction {
    return GetStudentInfoAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithStudentId:(NSString *)studentId organizationAccounts:(NSString *)organizationAccounts
{
    [self.params setObject:studentId forKey:@"studentId"];
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
}

@end
