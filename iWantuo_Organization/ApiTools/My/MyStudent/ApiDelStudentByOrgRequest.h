//
//  ApiDelStudentByOrgRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  删除学员api
 */
@interface ApiDelStudentByOrgRequest : APIRequest

- (void)setApiParmsWithOrganizationAccounts:(NSString *)organizationAccounts
                                  studentId:(NSString *)studentId
                                      login:(NSString *)login;

@end
