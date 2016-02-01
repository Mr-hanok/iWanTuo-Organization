//
//  CancelAttentionHandler.h
//  StudyChina
//
//  Created by 月 吴 on 15/10/14.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancelAttentionHandler : NSObject
+ (CancelAttentionHandler *)sharedInstance;

- (void)cancelAttentionWithOrgId:(NSString *)orgId
                         success:(void (^)(NSString *result))success
                         failure:(void (^)(NSString *message))failure;
@end
