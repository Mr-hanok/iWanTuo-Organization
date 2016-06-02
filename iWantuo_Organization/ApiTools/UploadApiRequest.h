//
//  UploadApiRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  上传图片
 */
@interface UploadApiRequest : APIRequest

- (void)setApiParamsWithFilePath:(NSString *)filePath;
@end
