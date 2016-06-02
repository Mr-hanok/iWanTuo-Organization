//
//  ApiFindPassWord.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiFindPassWord.h"

@implementation ApiFindPassWord

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return FindPassword;
}

-(void)setApiParamsWithLoginAccount:(NSString *)loginAccount Password:(NSString *)Password{
    [self.params setValue:loginAccount forKey:@"loginAccounts"];
    [self.params setValue:Password forKey:@"newPassword"];
}

@end
