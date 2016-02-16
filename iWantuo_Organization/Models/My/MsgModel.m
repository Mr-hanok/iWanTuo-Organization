//
//  MsgModel.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MsgModel.h"

@implementation MsgModel

+ (MsgModel *)initWithDic:(NSDictionary *)dic {
    MsgModel *model = [[MsgModel alloc] init];
    
    model.msgId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.push_login_accounts = [ValueUtils stringFromObject:[dic objectForKey:@"push_login_accounts"]];
    model.login_accounts = [ValueUtils stringFromObject:[dic objectForKey:@"login_accounts"]];
    model.create_date = [ValueUtils stringFromObject:[dic objectForKey:@"create_date"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.status_name = [ValueUtils stringFromObject:[dic objectForKey:@"status_name"]];
    model.push_details = [ValueUtils stringFromObject:[dic objectForKey:@"push_details"]];
    model.push_name = [ValueUtils stringFromObject:[dic objectForKey:@"push_name"]];
    model.push_type = [ValueUtils stringFromObject:[dic objectForKey:@"push_type"]];
    
    return model;
}

@end

