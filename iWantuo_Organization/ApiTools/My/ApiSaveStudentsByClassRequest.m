//
//  ApiSaveStudentsByClassRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSaveStudentsByClassRequest.h"

@implementation ApiSaveStudentsByClassRequest

- (NSString *)urlAction {
    return SaveStudentsByClassAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithStudentIds:(NSString *)studentIds classId:(NSString *)classId {
    
    [self.params setValue:studentIds forKey:@"studentIds"];
    [self.params setValue:classId forKey:@"classId"];
}

@end
