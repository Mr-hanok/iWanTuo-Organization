//
//  ActivityModel.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *location;//位置
@property (nonatomic, copy) NSString *activityName;//活动名称
@property (nonatomic, copy) NSString *createDate;//创建时间
@property (nonatomic, copy) NSString *thumbnailPath;//缩略图地址
@property (nonatomic, copy) NSString *largePath;//详细图地址

+ (ActivityModel *)initWithDic:(NSDictionary *)dic;
@end
