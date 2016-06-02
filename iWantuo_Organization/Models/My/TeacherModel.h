//
//  TeacherModel.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModel : NSObject

@property (nonatomic, copy) NSString *teacherId; //
@property (nonatomic, copy) NSString *loginAccounts; //
@property (nonatomic, copy) NSString *organizationAccounts; //
@property (nonatomic, copy) NSString *status; //
@property (nonatomic, copy) NSString *statusName; //
@property (nonatomic, copy) NSString *createDate; //
@property (nonatomic, copy) NSString *phone; //
@property (nonatomic, copy) NSString *teacherName; //
@property (nonatomic, copy) NSString *passWord; //

+ (TeacherModel *)initWithDic:(NSDictionary *)dic;

@end
