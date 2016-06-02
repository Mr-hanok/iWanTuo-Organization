//
//  ApiEditTeacherRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiEditTeacherRequest.h"

@implementation ApiEditTeacherRequest
- (NSString *)urlAction {
    return EditTeacherAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithTeacherId:(NSString *)teacherId
                             name:(NSString *)name
                            phone:(NSString *)phone
                            login:(NSString *)login{
    
    [self.params setValue:teacherId forKey:@"id"];
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:phone forKey:@"phone"];
    [self.params setValue:login forKey:@"login"];
    [self.params setValue:login forKey:@"login"];
    
}

@end
