//
//  ApiTeacherListRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiTeacherListRequest.h"

@implementation ApiTeacherListRequest

- (NSString *)urlAction {
    return TeacherListAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts page:(NSString *)page{
    
    [self.params setValue:loginAccounts forKey:@"organizationAccounts"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
    
}

@end
