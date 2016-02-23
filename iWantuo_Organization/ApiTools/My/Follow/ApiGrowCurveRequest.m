//
//  ApiGrowCurveRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiGrowCurveRequest.h"

@implementation ApiGrowCurveRequest
- (NSString *)urlAction {
    return GrowCurveAction;
    
}

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamesWithStudentId:(NSString *)studentId createDate:(NSString *)createDate {
    [self.params setObject:studentId forKey:@"studentId"];
    [self.params setObject:createDate forKey:@"createDate"];
}
@end
