//
//  FeedBackRequest.m
//  iStudentHosting
//
//  Created by Lisa on 16/1/28.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FeedBackRequest.h"

@implementation FeedBackRequest


- (NSString *)urlAction {
    return kMineFeedBackAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithDic:(NSDictionary *)dic
{
    [self.params setObject:[AccountManager sharedInstance].account.loginAccounts forKey:@"loginAccounts"];
    [self.params setObject:dic[@"feedbackDetails"] forKey:@"feedbackDetails"];
    
}
@end
