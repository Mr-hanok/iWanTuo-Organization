//
//  CommentModel.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+ (CommentModel *)initWithDic:(NSDictionary *)dic {
    CommentModel *model = [[CommentModel alloc] init];
    model.commentId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.organizationAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAccounts"]];
    model.evaluate = [ValueUtils stringFromObject:[dic objectForKey:@"evaluate"]];
    model.evaluatePerson = [ValueUtils stringFromObject:[dic objectForKey:@"evaluatePerson"]];
    model.evaluateDetails = [ValueUtils stringFromObject:[dic objectForKey:@"evaluateDetails"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    model.headPortrait = [ValueUtils stringFromObject:[dic objectForKey:@"headPortrait"]];
    return model;
}
@end
