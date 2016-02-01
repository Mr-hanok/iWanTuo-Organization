//
//  ApiOrganizationDetailRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiOrganizationDetailRequest : APIRequest

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts currentLogin:(NSString *)currentLogin;

@end
