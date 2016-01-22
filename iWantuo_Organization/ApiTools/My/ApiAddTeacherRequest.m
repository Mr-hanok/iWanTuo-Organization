//
//  ApiAddTeacherRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiAddTeacherRequest.h"

@implementation ApiAddTeacherRequest
- (NSString *)urlAction {
    return AddTeacherAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts password:(NSString *)password organizationAccounts:(NSString *)organizationAccounts name:(NSString *)name phone:(NSString *)phone {
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    [self.params setValue:password forKey:@"password"];
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:phone forKey:@"phone"];
    
}
@end
