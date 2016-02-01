//
//  ApiOrganizationDetailRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiOrganizationDetailRequest.h"

@implementation ApiOrganizationDetailRequest

- (NSString *)urlAction {
    return OrganizationDetailAction;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts currentLogin:(NSString *)currentLogin {
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    [self.params setValue:currentLogin forKey:@"currentLogin"];
}

@end
