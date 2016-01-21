//
//  PatriarchModel.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "PatriarchModel.h"

@implementation PatriarchModel

+ (PatriarchModel *)initWithDic:(NSDictionary *)dic {
    PatriarchModel *model = [[PatriarchModel alloc] init];
    
    model.patriarchId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.loginAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"loginAccounts"]];
    model.phone = [ValueUtils stringFromObject:[dic objectForKey:@"phone"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    model.patriarchName = [ValueUtils stringFromObject:[dic objectForKey:@"patriarchName"]];
    model.address = [ValueUtils stringFromObject:[dic objectForKey:@"address"]];
    model.sex = [ValueUtils stringFromObject:[dic objectForKey:@"sex"]];
    model.age = [ValueUtils stringFromObject:[dic objectForKey:@"age"]];
    model.nickName = [ValueUtils stringFromObject:[dic objectForKey:@"nickName"]];
    model.headPortrait = [ValueUtils stringFromObject:[dic objectForKey:@"headPortrait"]];

    return model;
}

@end
