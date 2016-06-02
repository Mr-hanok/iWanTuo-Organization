//
//  ApiDeleteClassRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiDeleteClassRequest.h"

@implementation ApiDeleteClassRequest

- (NSString *)urlAction {
    return DeleteClassAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithClassId:(NSString *)classId login:(NSString *)login {
    
    [self.params setValue:classId forKey:@"id"];
    [self.params setValue:login forKey:@"login"];
}

@end
