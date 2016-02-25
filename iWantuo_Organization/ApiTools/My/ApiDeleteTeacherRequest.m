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

- (void)setApiParamsWithTeacherId:(NSString *)teacherId login:(NSString *)login {
    
    [self.params setValue:teacherId forKey:@"id"];
    [self.params setObject:login forKey:@"login"];
}


@end
