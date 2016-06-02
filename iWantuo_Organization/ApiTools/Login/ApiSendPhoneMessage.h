//
//  ApiSendPhoneMessage.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiSendPhoneMessage : APIRequest
@property (nonatomic, copy) NSString *type;
/**
 *  获取短信验证码
 */
- (void)setApiParamsWithPhone:(NSString *)phone;
@end
