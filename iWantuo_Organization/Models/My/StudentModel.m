//
//  StudentModel.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel


+ (StudentModel *)initWithDic:(NSDictionary *)dic
{
    StudentModel *model = [[StudentModel alloc] init];
    model.Id = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.studentId = [ValueUtils stringFromObject:[dic objectForKey:@"studentId"]];
    model.classId = [ValueUtils stringFromObject:[dic objectForKey:@"classId"]];
    model.name = [ValueUtils stringFromObject:[dic objectForKey:@"name"]];
    
    
    model.organizationAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAccounts"]];
    model.school = [ValueUtils stringFromObject:[dic objectForKey:@"school"]];
    model.grade = [ValueUtils stringFromObject:[dic objectForKey:@"grade"]];
    model.loginAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"loginAccounts"]];
    model.beginDate = [ValueUtils stringFromObject:[dic objectForKey:@"beginDate"]];
    model.sex = [ValueUtils stringFromObject:[dic objectForKey:@"sex"]];
    model.isDelete = NO;
    model.isAdd = NO;
    return model;
}

@end
