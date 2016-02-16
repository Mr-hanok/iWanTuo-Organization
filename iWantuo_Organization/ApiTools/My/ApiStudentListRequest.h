//
//  ApiStudentListRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiStudentListRequest : APIRequest
- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts name:(NSString *)name page:(NSString *)page;
@end
