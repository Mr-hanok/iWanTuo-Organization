//
//  ApiDelStudentByOrgRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiDelStudentByOrgRequest.h"

@implementation ApiDelStudentByOrgRequest

- (NSString *)urlAction {
    return DeleteStudentByOrgAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithOrganizationAccounts:(NSString *)organizationAccounts studentId:(NSString *)studentId
{
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setObject:studentId forKey:@"studentId"];
}



@end
