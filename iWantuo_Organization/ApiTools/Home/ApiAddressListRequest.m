//
//  ApiAddressListRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiAddressListRequest.h"

@implementation ApiAddressListRequest
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}

- (NSString *)urlAction {
    return CityAreaList;
}

- (void)setApiParamsWithParentId:(NSString *)parentId {

    [self.params setValue:parentId forKey:@"parentId"];
    [self.params setValue:@"1" forKey:@"Type"];
}
@end
