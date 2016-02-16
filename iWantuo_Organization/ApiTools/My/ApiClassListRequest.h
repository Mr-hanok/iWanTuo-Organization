//
//  ApiClassListRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiClassListRequest : APIRequest

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts page:(NSString *)page organizationClass:(NSString *)organizationClass;

@end
