//
//  ApiFindPassWord.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  找回密码
 */
@interface ApiFindPassWord : APIRequest

- (void)setApiParamsWithLoginAccount:(NSString *)loginAccounts
                            Password:(NSString *)Password;
@end
