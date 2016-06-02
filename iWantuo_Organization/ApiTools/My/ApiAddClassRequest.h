//
//  ApiAddClassRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiAddClassRequest : APIRequest

- (void)setApiParamsWithOrganizationAccounts:(NSString *)organizationAccounts organizationClass:(NSString *)organizationClass;

@end
