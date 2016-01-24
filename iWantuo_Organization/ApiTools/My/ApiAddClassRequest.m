//
//  ApiAddClassRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiAddClassRequest.h"

@implementation ApiAddClassRequest

- (NSString *)urlAction {
    return AddClassAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts organizationClass:(NSString *)organizationClass{
    
    [self.params setValue:organizationClass forKey:@"organizationClass"];
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
}

@end
