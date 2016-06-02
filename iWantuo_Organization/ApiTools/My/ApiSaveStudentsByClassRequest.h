//
//  ApiSaveStudentsByClassRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 * 添加学生进班级
 */
@interface ApiSaveStudentsByClassRequest : APIRequest

- (void)setApiParamsWithStudentIds:(NSString *)studentIds classId:(NSString *)classId login:login;

@end
