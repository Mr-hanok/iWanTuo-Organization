//
//  ApiFollowSubject.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiFollowSubject.h"

@implementation ApiFollowSubject
- (NSString *)urlAction {
    return SyscodePhoneQueryByList;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParams
{
    [self.params setValue:@"2" forKey:@"Type"];
}

@end
