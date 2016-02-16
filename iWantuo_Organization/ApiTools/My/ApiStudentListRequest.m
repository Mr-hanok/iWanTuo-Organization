//
//  ApiStudentListRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiStudentListRequest.h"

@implementation ApiStudentListRequest

- (NSString *)urlAction {
    return StudentListByOrgAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts name:(NSString *)name page:(NSString *)page{
    
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
}

@end
