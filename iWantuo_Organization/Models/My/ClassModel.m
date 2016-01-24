//
//  ClassModel.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel


+ (ClassModel *)initWithDic:(NSDictionary *)dic {
    ClassModel *model = [[ClassModel alloc] init];

    model.classId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.organizationAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAccounts"]];
    model.organizationClass = [ValueUtils stringFromObject:[dic objectForKey:@"organizationClass"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.subject = [ValueUtils stringFromObject:[dic objectForKey:@"subject"]];
    model.student = [ValueUtils stringFromObject:[dic objectForKey:@"student"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    model.num = [ValueUtils stringFromObject:[dic objectForKey:@"num"]];
    
    return model;
}

@end
