//
//  ApiAttentionRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiAttentionRequest : APIRequest
- (void)setApiParamesWithOrgId:(NSString *)organizationAccounts patriarchAccounts:(NSString *)patriarchAccounts;
@end
