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

- (void)setApiParamsWithTeacherId:(NSString *)teacherId {
    
    [self.params setValue:teacherId forKey:@"id"];
}


@end
