//
//  ApiFollowChangeRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiFollowChangeRequest.h"

@implementation ApiFollowChangeRequest
- (NSString *)urlAction {
    return FollowChangeRequest;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithId:(NSString *)kid
                     leave:(NSString *)leave
                leaveImage:(NSString *)leaveImage
                workStatus:(NSString *)workStatus
            workStatusName:(NSString *)workStatusName
                  behavior:(NSString *)behavior
                     study:(NSString *)study
                     grade:(NSString *)grade
                   subject:(NSString *)subject
               subjectName:(NSString *)subjectName
                    status:(NSString *)status
                statusName:(NSString *)statusName
                    signIn:(NSString *)signIn
               signInImage:(NSString *)signInImage
                      note:(NSString *)note
             summaryPerson:(NSString *)summaryPerson
               leavePerson:(NSString *)leavePerson
                   loginin:(NSString *)loginin
{
    [self.params setValue:kid forKey:@"Id"];
    [self.params setValue:leave forKey:@"leave"];
    [self.params setValue:leaveImage forKey:@"leaveImage"];
    [self.params setValue:workStatus forKey:@"workStatus"];
    [self.params setValue:workStatusName forKey:@"workStatusName"];
    [self.params setValue:behavior forKey:@"behavior"];
    [self.params setValue:study forKey:@"study"];
    [self.params setValue:grade forKey:@"grade"];
    [self.params setValue:subject forKey:@"subject"];
    [self.params setValue:subjectName forKey:@"subjectName"];
    [self.params setValue:status forKey:@"status"];
    [self.params setValue:statusName forKey:@"statusName"];
    
    [self.params setValue:signIn forKey:@"signIn"];
    [self.params setValue:signInImage forKey:@"signInImage"];
    [self.params setValue:note forKey:@"note"];
    [self.params setValue:summaryPerson forKey:@"summaryPerson"];
    [self.params setValue:leavePerson forKey:@"leavePerson"];
    [self.params setValue:loginin forKey:@"loginin"];
    
}

@end
