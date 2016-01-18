//
//  ApiAuthenCode.h
//  iStudentHosting
//
//  Created by yuntai on 16/1/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  验证码
 */
@interface ApiAuthenCode : APIRequest

-(void)setApiParamsWithPhoneNum:(NSString *)phone;
@end
