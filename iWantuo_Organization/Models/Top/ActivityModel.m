//
//  ActivityModel.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel


+ (ActivityModel *)initWithDic:(NSDictionary *)dic {
    ActivityModel *model = [[ActivityModel alloc] init];
    
    model.activityId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.location = [ValueUtils stringFromObject:[dic objectForKey:@"location"]];
    model.activityName = [ValueUtils stringFromObject:[dic objectForKey:@"activityName"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.thumbnailPath = [ValueUtils stringFromObject:[dic objectForKey:@"thumbnailPath"]];
    model.largePath = [ValueUtils stringFromObject:[dic objectForKey:@"largePath"]];
    
    return model;
}

@end
