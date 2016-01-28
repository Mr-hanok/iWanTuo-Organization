//
//  ChangePasswordRequest.m
//  iStudentHosting
//
//  Created by Lisa on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ChangePasswordRequest.h"

@implementation ChangePasswordRequest


- (NSString *)urlAction {
    return kMineChangePasswordAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithDic:(NSDictionary *)dic
{
    [self.params setObject:[AccountManager sharedInstance].account.loginAccounts forKey:@"loginAccounts"];
    [self.params setObject:dic[@"oldPassword"] forKey:@"oldPassword"];
    [self.params setObject:dic[@"newPassword"] forKey:@"newPassword"];

}

@end
