//
//  ApiLoginOutRequest.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiLoginOutRequest.h"

@implementation ApiLoginOutRequest
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return LoginQuitAction;
}

-(void)setApiParamsWithPhoneNum:(NSString *)phone{
    [self.params setValue:phone forKey:@"loginAccount"];
    
}

@end
