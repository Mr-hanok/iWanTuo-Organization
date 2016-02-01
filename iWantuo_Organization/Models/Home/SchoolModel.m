//
//  SchoolModel.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel


+ (SchoolModel *)initWithDic:(NSDictionary *)dic {
    SchoolModel *model = [[SchoolModel alloc] init];
    
    model.schoolId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.location = [ValueUtils stringFromObject:[dic objectForKey:@"location"]];
    model.locationName = [ValueUtils stringFromObject:[dic objectForKey:@"locationName"]];
    model.bairro = [ValueUtils stringFromObject:[dic objectForKey:@"bairro"]];
    model.bairroName = [ValueUtils stringFromObject:[dic objectForKey:@"bairroName"]];
    model.address = [ValueUtils stringFromObject:[dic objectForKey:@"address"]];
    model.email = [ValueUtils stringFromObject:[dic objectForKey:@"email"]];
    model.schoolName = [ValueUtils stringFromObject:[dic objectForKey:@"schoolName"]];
    model.schoolContacts = [ValueUtils stringFromObject:[dic objectForKey:@"schoolContacts"]];
    model.coordinateX = [ValueUtils stringFromObject:[dic objectForKey:@"coordinateX"]];
    model.coordinateY = [ValueUtils stringFromObject:[dic objectForKey:@"coordinateY"]];
    model.phone = [ValueUtils stringFromObject:[dic objectForKey:@"phone"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.updateDate = [ValueUtils stringFromObject:[dic objectForKey:@"updateDate"]];
    model.status = [ValueUtils stringFromObject:[dic objectForKey:@"status"]];
    model.statusName = [ValueUtils stringFromObject:[dic objectForKey:@"statusName"]];
    return model;
}

@end
