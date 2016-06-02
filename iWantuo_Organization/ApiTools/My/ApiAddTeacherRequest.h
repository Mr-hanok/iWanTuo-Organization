//
//  ApiAddTeacherRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiAddTeacherRequest : APIRequest

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts password:(NSString *)password organizationAccounts:(NSString *)organizationAccounts name:(NSString *)name phone:(NSString *)phone ;

@end
