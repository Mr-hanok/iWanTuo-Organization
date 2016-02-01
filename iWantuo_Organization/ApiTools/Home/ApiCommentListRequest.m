//
//  ApiCommentListRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiCommentListRequest.h"

@implementation ApiCommentListRequest

- (NSString *)urlAction {
    return CommentListAction;
    
}

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamesWithPage:(NSString *)page organizationAccounts:(NSString *)organizationAccounts {
    [self.params setObject:kRequestDataRows forKey:@"rows"];
    [self.params setObject:page forKey:@"page"];
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
}

@end
