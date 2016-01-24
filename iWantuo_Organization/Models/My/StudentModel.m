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
    return model;
}
@end
