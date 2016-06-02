//
//  ApiDeleteStudentsByClassRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  删除班级里学生
 */
@interface ApiDeleteStudentsByClassRequest : APIRequest

- (void)setApiParamsWithStudentIds:(NSString *)studentIds classId:(NSString *)classId login:(NSString *)login;

@end
