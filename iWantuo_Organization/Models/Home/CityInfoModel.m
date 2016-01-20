//
//  CityInfoModel.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "CityInfoModel.h"

@implementation CityInfoModel


+ (CityInfoModel *)initWithDic :(NSDictionary *)dic {
    CityInfoModel *model = [[CityInfoModel alloc] init];
    
    model.cityId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.parentId = [ValueUtils stringFromObject:[dic objectForKey:@"parentId"]];
    model.name = [ValueUtils stringFromObject:[dic objectForKey:@"name"]];
    model.type = [ValueUtils stringFromObject:[dic objectForKey:@"type"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    
    return model;
}
@end
