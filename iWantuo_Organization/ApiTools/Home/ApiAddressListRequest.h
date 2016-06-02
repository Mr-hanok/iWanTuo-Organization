//
//  ApiAddressListRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiAddressListRequest : APIRequest

- (void)setApiParamsWithParentId:(NSString *)parentId;

@end
