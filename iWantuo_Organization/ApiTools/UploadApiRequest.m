//
//  UploadApiRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "UploadApiRequest.h"

@implementation UploadApiRequest
- (ApiAccessType)accessType
{
    return kApiAccessUpload;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return UploadImageApi;
}

- (void)setApiParamsWithFilePath:(NSString *)filePath{
    self.filePath = filePath;


}

@end
