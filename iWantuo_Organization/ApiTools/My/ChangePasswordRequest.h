//
//  ChangePasswordRequest.h
//  iStudentHosting
//
//  Created by Lisa on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  修改密码
 */
@interface ChangePasswordRequest : APIRequest
- (void)setApiParmsWithDic:(NSDictionary *)dic;
@end
