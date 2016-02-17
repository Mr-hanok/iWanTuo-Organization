//
//  ApiEditTeacherRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  编辑辅导员接口
 */
@interface ApiEditTeacherRequest : APIRequest

- (void)setApiParamsWithTeacherId:(NSString *)teacherId
                             name:(NSString *)name
                            phone:(NSString *)phone;
@end
