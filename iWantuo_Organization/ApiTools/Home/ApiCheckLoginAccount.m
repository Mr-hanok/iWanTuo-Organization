//
//  ApiCheckLoginAccount.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/3/9.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiCheckLoginAccount.h"
#import "UUIDManager.h"

@implementation ApiCheckLoginAccount

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}

- (NSString *)urlAction {
    return CheckLoginAccount;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts
{
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    NSString *uuid = [UUIDManager deviceUUID];
    [self.params setValue:uuid forKey:@"phoneUuid"];
}

@end
