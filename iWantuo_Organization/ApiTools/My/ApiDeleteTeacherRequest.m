//
//  ApiDeleteTeacherRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiDeleteTeacherRequest.h"

@implementation ApiDeleteTeacherRequest

- (NSString *)urlAction {
    return DeleteTeacherAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithTeacherId:(NSString *)teacherId login:(NSString *)login loginAccounts:(NSString *)loginAccounts {
    
    [self.params setValue:teacherId forKey:@"id"];
    [self.params setValue:login forKey:@"login"];
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
}


@end
