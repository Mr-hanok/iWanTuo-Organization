//
//  ApiSubmitCommentRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSubmitCommentRequest.h"

@implementation ApiSubmitCommentRequest
- (NSString *)urlAction {
    return SubmitCommentAction;
    
}

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamesWithEvaluatePerson:(NSString *)evaluatePerson evaluateDetails:(NSString *)evaluateDetails evaluate:(NSString *)evaluate organizationAccounts:(NSString *)organizationAccounts{
    [self.params setObject:evaluatePerson forKey:@"evaluatePerson"];
    [self.params setObject:evaluateDetails forKey:@"evaluateDetails"];
    [self.params setObject:evaluate forKey:@"evaluate"];
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
}

@end
