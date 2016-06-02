//
//  ApiOrganizationInfoRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiOrganizationInfoRequest.h"

@implementation ApiOrganizationInfoRequest
- (NSString *)urlAction {
    return OrganizationPhoneGetById;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts
                         currentLogin:(NSString *)currentLogin{
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    [self.params setValue:currentLogin forKey:@"currentLogin"];
}

@end
