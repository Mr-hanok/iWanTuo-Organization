//
//  ApiSubmitCommentRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiSubmitCommentRequest : APIRequest
- (void)setApiParamesWithEvaluatePerson:(NSString *)evaluatePerson evaluateDetails:(NSString *)evaluateDetails evaluate:(NSString *)evaluate organizationAccounts:(NSString *)organizationAccounts;
@end
