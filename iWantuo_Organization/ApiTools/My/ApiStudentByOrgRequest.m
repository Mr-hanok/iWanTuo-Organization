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
    return StudentByOrgAndClassAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts classId:(NSString *)classId name:(NSString *)name{
    
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:classId forKey:@"classId"];
    [self.params setValue:name forKey:@"name"];
//    [self.params setValue:page forKey:@"page"];
//    [self.params setValue:kRequestDataRows forKey:@"rows"];
}

@end
