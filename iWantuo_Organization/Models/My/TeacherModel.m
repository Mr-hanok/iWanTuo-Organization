//
//  TeacherModel.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel


+ (TeacherModel *)initWithDic:(NSDictionary *)dic {
    TeacherModel *model = [[TeacherModel alloc] init];
    
    model.teacherId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.loginAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"loginAccounts"]];
    model.organizationAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAccounts"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.phone = [ValueUtils stringFromObject:[dic objectForKey:@"phone"]];
    model.teacherName = [ValueUtils stringFromObject:[dic objectForKey:@"name"]];
    model.passWord = [ValueUtils stringFromObject:[dic objectForKey:@"passWord"]];

    return model;
}



@end
