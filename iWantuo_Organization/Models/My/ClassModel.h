//
//  ClassModel.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

@property (nonatomic, copy) NSString *classId; //
@property (nonatomic, copy) NSString *organizationAccounts; //
@property (nonatomic, copy) NSString *organizationClass; // 班级名称
@property (nonatomic, copy) NSString *createDate; //
@property (nonatomic, copy) NSString *subject; //
@property (nonatomic, copy) NSString *student; //
@property (nonatomic, copy) NSString *status; //
@property (nonatomic, copy) NSString *statusName; //
@property (nonatomic, copy) NSString *num; //班级人数

+ (ClassModel *)initWithDic:(NSDictionary *)dic;

@end
