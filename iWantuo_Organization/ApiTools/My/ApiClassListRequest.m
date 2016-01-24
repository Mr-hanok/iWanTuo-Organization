//
//  ApiClassListRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiClassListRequest.h"

@implementation ApiClassListRequest

- (NSString *)urlAction {
    return ClassListAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts page:(NSString *)page{
    
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
}

@end
