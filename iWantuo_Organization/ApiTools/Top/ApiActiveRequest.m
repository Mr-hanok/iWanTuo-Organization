//
//  ApiActiveRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiActiveRequest.h"

@implementation ApiActiveRequest

- (NSString *)urlAction {
    return TopActiveAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


@end
