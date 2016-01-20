//
//  CityInfoModel.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfoModel : NSObject

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *parentId; //区所属市的id
@property (nonatomic, copy) NSString *name; //名字
@property (nonatomic, copy) NSString *type; //类型 1为城市
@property (nonatomic, copy) NSString *status; //1可用
@property (nonatomic, copy) NSString *statusName;

+ (CityInfoModel *)initWithDic :(NSDictionary *)dic;

@end
