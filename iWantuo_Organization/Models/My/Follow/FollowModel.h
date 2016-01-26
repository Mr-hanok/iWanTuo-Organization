//
//  FollowModel.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowModel : NSObject
/**id*/
@property (nonatomic, copy) NSString *kid;
/**机构帐号*/
@property (nonatomic, copy) NSString *organizationAccounts;
/**学生id*/
@property (nonatomic, copy) NSString *studentId;
/**跟踪日期*/
@property (nonatomic, copy) NSString *createDate;
/**签到文字*/
@property (nonatomic, copy) NSString *signIn;
/**签到图片*/
@property (nonatomic, copy) NSString *signInImage;
/**离校文字*/
@property (nonatomic, copy) NSString *leave;
/**离校图片*/
@property (nonatomic, copy) NSString *leaveImage;
/**作业状态*/
@property (nonatomic, copy) NSString *workStatus;
/**作业状态*/
@property (nonatomic, copy) NSString *workStatusName;
/**行为评价*/
@property (nonatomic, copy) NSString *behavior;
/**学习评价*/
@property (nonatomic, copy) NSString *study;
/**成绩*/
@property (nonatomic, copy) NSString *grade;
/**学科id*/
@property (nonatomic, copy) NSString *subject;
/**学科*/
@property (nonatomic, copy) NSString *subjectName;
/**状态*/
@property (nonatomic, copy) NSString *status;
/**状态名称*/
@property (nonatomic, copy) NSString *statusName;
/**总结文字*/
@property (nonatomic, copy) NSString *note;


+ (FollowModel *)initWithDic:(NSDictionary *)dic;

@end
