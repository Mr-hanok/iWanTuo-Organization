//
//  ApiLoginRequest.h
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  登录接口
 */
@interface ApiLoginRequest : APIRequest

- (void)setApiParamsWithLoginAccount:(NSString *)loginAccount
                            Password:(NSString *)Password;
@end
