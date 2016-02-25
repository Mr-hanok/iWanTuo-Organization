//
//  ApiDeleteClassRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  删除班级
 */
@interface ApiDeleteClassRequest : APIRequest

- (void)setApiParamsWithClassId:(NSString *)classId login:(NSString *)login;

@end
