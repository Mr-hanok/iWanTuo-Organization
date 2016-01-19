//
//  ApiRegisterRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiRegisterRequest.h"

@implementation ApiRegisterRequest

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return RegisterOganiza;
}

-(void)setApiParamsWithLoginAccount:(NSString *)loginAccount
                           password:(NSString *)Password
                            address:(NSString *)address
                              email:(NSString *)email
                    organizatioType:(NSString *)organizatioType
           organizationAbbreviation:(NSString *)organizationAbbreviation
                       organization:(NSString *)organization
               organizationContacts:(NSString *)organizationContacts
                        idCardImage:(NSString *)idCardImage{
    
    [self.params setValue:loginAccount forKey:@"loginAccounts"];
    [self.params setValue:Password forKey:@"newPassword"];
}

@end
