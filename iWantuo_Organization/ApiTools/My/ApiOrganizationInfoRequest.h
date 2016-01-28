//
//  ApiOrganizationInfoRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  查询机构信息接口
 */
@interface ApiOrganizationInfoRequest : APIRequest

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts
                         currentLogin:(NSString *)currentLogin;
@end
