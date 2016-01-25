//
//  FollowSummaryController.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "BaseViewController.h"
#import "FollowModel.h"
/**
 *  追踪总结
 */
@interface FollowSummaryController : BaseViewController

@property (nonatomic, copy) NSString *createDate;//记录时间
@property (nonatomic, copy) NSString *status;//状态0删除1签到2总结3离校
@property (nonatomic, copy) NSString *statusName;//状态0删除1签到2总结3离校
@property (nonatomic, copy) NSString *studentId;
@property (nonatomic, strong) FollowModel *followmodel;//追踪模型
@end
