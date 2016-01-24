//
//  ApiStudentByOrgRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiStudentByOrgRequest : APIRequest

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts name:(NSString *)name page:(NSString *)page;

@end
