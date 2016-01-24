//
//  ApiStudentByClassRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiStudentByClassRequest.h"

@implementation ApiStudentByClassRequest

- (NSString *)urlAction {
    return StudentByClassAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithClassId:(NSString *)classId name:(NSString *)name page:(NSString *)page{
    
    [self.params setValue:classId forKey:@"classId"];
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
    
}

@end
