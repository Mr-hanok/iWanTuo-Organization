//
//  ApiFollowChangeRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  追踪修改接口
 */
@interface ApiFollowChangeRequest : APIRequest
/**
 *  修改追踪接口 离校 总结需要
 *
 *  @param kid            每日跟踪id
 *  @param leave          离校文字
 *  @param leaveImage     离校图片
 *  @param workStatus     作业状态
 *  @param workStatusName 作业状态名字
 *  @param behavior       行为评价
 *  @param study          学习评价
 *  @param grade          成绩
 *  @param subject        学科id
 *  @param subjectName    学科name
 *  @param status         状态0删除1签到2总结3离校
 *  @param statusName     状态0删除1签到2总结3离校
 *  @param subject        签到文字
 *  @param subjectName    签到图片
 *  @param note    总结文字
 */
- (void)setApiParamsWithId:(NSString *)kid
                     leave:(NSString *)leave
                leaveImage:(NSString *)leaveImage
                workStatus:(NSString *)workStatus
            workStatusName:(NSString *)workStatusName
                  behavior:(NSString *)behavior
                     study:(NSString *)study
                     grade:(NSString *)grade
                   subject:(NSString *)subject
               subjectName:(NSString *)subjectName
                    status:(NSString *)status
                statusName:(NSString *)statusName
                    signIn:(NSString *)signIn
               signInImage:(NSString *)signInImage
                      note:(NSString *)note
             summaryPerson:(NSString *)summaryPerson
               leavePerson:(NSString *)leavePerson
                   loginin:(NSString *)loginin
                 studentId:(NSString *)studentId;
@end
