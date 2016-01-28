//
//  ApiFollowAddRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  追踪增加接口 
 */
@interface ApiFollowAddRequest : APIRequest
/**
 *  追踪增加接口参数
 *
 *  @param createDate           时间
 *  @param studentId            学生id
 *  @param organizationAccounts 机构帐号
 *  @param signIn               签到文字
 *  @param signInImage          签到图片
 *  @param status               状态0删除1签到2总结3离校
 *  @param statusName           状态0删除1签到2总结3离校
 */
- (void)setApiParamsWithCreateDate:(NSString *)createDate
                         studentId:(NSString *)studentId
              organizationAccounts:(NSString *)organizationAccounts
                            signIn:(NSString *)signIn
                       signInImage:(NSString *)signInImage
                            status:(NSString *)status
                        statusName:(NSString *)statusName
                      signInPerson:(NSString *)signInPerson;
@end
