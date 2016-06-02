//
//  ApiSendPhoneMessage.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSendPhoneMessage.h"

@implementation ApiSendPhoneMessage

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    if ([self.type isEqualToString:@"1"]) {
        return SendPhoneMessageToFind;
    }
    return SendPhoneMessage;
}

- (void)setApiParamsWithPhone:(NSString *)phone{
    [self.params setValue:phone forKey:@"phone"];
}
@end
