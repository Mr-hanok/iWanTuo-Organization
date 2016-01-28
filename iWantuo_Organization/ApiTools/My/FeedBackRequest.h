//
//  FeedBackRequest.h
//  iStudentHosting
//
//  Created by Lisa on 16/1/28.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  意见反馈接口
 */
@interface FeedBackRequest : APIRequest
- (void)setApiParmsWithDic:(NSDictionary *)dic;
@end
