//
//  ApiStudentByOrgRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiStudentByOrgRequest.h"

@implementation ApiStudentByOrgRequest

- (NSString *)urlAction {
    return StudentByOrgAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts name:(NSString *)name page:(NSString *)page {
    
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
}

@end
