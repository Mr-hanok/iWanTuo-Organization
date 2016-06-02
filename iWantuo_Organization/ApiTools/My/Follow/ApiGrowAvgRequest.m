//
//  ApiGrowAvgRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiGrowAvgRequest.h"

@implementation ApiGrowAvgRequest


- (NSString *)urlAction {
    return kMineGrowAvgAction;
    
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
