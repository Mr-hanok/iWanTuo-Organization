//
//  FollowModel.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowModel.h"

@implementation FollowModel
+ (FollowModel *)initWithDic:(NSDictionary *)dic{
    
    FollowModel *model = [[FollowModel alloc] init];
    if (dic == nil || [dic isKindOfClass:[NSNull class]]) {
        return nil;
    }
     model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.kid = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.organizationAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAccounts"]];
    model.studentId = [ValueUtils stringFromObject:[dic objectForKey:@"studentId"]];
    model.signIn = [ValueUtils stringFromObject:[dic objectForKey:@"signIn"]];
    model.signInImage = [ValueUtils stringFromObject:[dic objectForKey:@"signInImage"]];
    model.leave = [ValueUtils stringFromObject:[dic objectForKey:@"leave"]];
    model.leaveImage = [ValueUtils stringFromObject:[dic objectForKey:@"leaveImage"]];
    model.workStatus = [ValueUtils stringFromObject:[dic objectForKey:@"workStatus"]];
    model.workStatusName = [ValueUtils stringFromObject:[dic objectForKey:@"workStatusName"]];
    model.behavior = [ValueUtils stringFromObject:[dic objectForKey:@"behavior"]];
    model.study = [ValueUtils stringFromObject:[dic objectForKey:@"study"]];
    model.grade = [ValueUtils stringFromObject:[dic objectForKey:@"grade"]];
    model.subject = [ValueUtils stringFromObject:[dic objectForKey:@"subject"]];
    model.subjectName = [ValueUtils stringFromObject:[dic objectForKey:@"subjectName"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    model.note = [ValueUtils stringFromObject:[dic objectForKey:@"note"]];
    
    model.signinDate = [ValueUtils stringFromObject:[dic objectForKey:@"signinDate"]];
    model.signinPerson = [ValueUtils stringFromObject:[dic objectForKey:@"signinPerson"]];
    model.leaveDate = [ValueUtils stringFromObject:[dic objectForKey:@"leaveDate"]];
    model.leavePerson = [ValueUtils stringFromObject:[dic objectForKey:@"leavePerson"]];
    model.summaryPerson = [ValueUtils stringFromObject:[dic objectForKey:@"summaryPerson"]];
    model.summaryDate = [ValueUtils stringFromObject:[dic objectForKey:@"summaryDate"]];
    
        
    return model;

}
@end
