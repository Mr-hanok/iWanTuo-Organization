//
//  AttentionHandler.h
//  StudyChina
//
//  Created by 月 吴 on 15/10/13.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionHandler : NSObject
+ (AttentionHandler *)sharedInstance;

- (void)attentionWithOrgId:(NSString *)orgId
                   success:(void (^)(NSString *result))success
                   failure:(void (^)(NSString *message))failure;
@end
