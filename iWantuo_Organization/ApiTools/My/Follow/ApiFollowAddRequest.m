//
//  ApiFollowAddRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiFollowAddRequest.h"

@implementation ApiFollowAddRequest
- (NSString *)urlAction {
    return FollowAddRequest;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithCreateDate:(NSString *)createDate
                         studentId:(NSString *)studentId
              organizationAccounts:(NSString *)organizationAccounts
                         signIn:(NSString *)signIn
                         signInImage:(NSString *)signInImage
                            status:(NSString *)status
                        statusName:(NSString *)statusName
                      signInPerson:(NSString *)signinPerson{
    
    
    [self.params setValue:createDate forKey:@"createDate"];
    [self.params setValue:studentId forKey:@"studentId"];
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setValue:signIn forKey:@"signIn"];
    [self.params setValue:signInImage forKey:@"signInImage"];
    [self.params setValue:status forKey:@"status"];
    [self.params setValue:statusName forKey:@"statusName"];
    [self.params setValue:signinPerson forKey:@"signinPerson"];


    
}

@end
