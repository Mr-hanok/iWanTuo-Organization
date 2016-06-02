//
//  ApiFollowCheckRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  追踪查询接口
 */
@interface ApiFollowCheckRequest : APIRequest

- (void)setApiParamsWithCreateDate:(NSString *)createDate
                         studentId:(NSString *)studentId
              organizationAccounts:(NSString *)organizationAccounts;
@end
