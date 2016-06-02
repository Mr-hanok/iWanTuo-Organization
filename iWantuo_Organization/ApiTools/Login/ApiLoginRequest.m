//
//  ApiLoginRequest.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiLoginRequest.h"
#import "APNsManager.h"
#import "UUIDManager.h"

@implementation ApiLoginRequest
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return LoginAction;
}

-(void)setApiParamsWithLoginAccount:(NSString *)loginAccount Password:(NSString *)Password{
    [self.params setValue:loginAccount forKey:@"loginAccounts"];
    [self.params setValue:Password forKey:@"password"];
    [self.params setValue:[APNsManager sharedInstance].deviceToken forKey:@"deviceToken"];
    NSString *uuid = [UUIDManager deviceUUID];
    [self.params setValue:uuid forKey:@"phoneUuid"];
    //[self.params setValue:loginAccount forKey:@"deviceToken"];
    // [self.params setValue:[AccountManager sharedInstance].uuid forKey:@"uuId"];
}

@end
