//
//  ApiUpdateStudentRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiUpdateStudentRequest.h"

@implementation ApiUpdateStudentRequest

- (NSString *)urlAction {
    return UpdateStudentInfoAction;
}

- (ApiAccessType)accessType {
    return kApiAccessPost;
}

- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}


- (void)setApiParmsWithStudentId:(NSString *)studentId
                            name:(NSString *)name
                          school:(NSString *)school
                           grade:(NSString *)grade
                   loginAccounts:(NSString *)loginAccounts
                     patriarchId:(NSString *)patriarchId
                       patriarch:(NSString *)patriarch
                        kinsfolk:(NSString *)kinsfolk
                           phone:(NSString *)phone
                             sex:(NSString *)sex
            organizationAccounts:(NSString *)organizationAccounts
                      locationId:(NSString *)locationId
                        location:(NSString *)location
                        bairroId:(NSString *)bairroId
                          bairro:(NSString *)bairro
{
    [self.params setObject:organizationAccounts forKey:@"organizationAccounts"];
    [self.params setObject:studentId forKey:@"studentId"];
    [self.params setObject:name forKey:@"name"];
    [self.params setObject:school forKey:@"school"];
    [self.params setObject:grade forKey:@"grade"];
    [self.params setObject:loginAccounts forKey:@"loginAccounts"];
    [self.params setObject:patriarchId forKey:@"patriarchId"];
    [self.params setObject:patriarch forKey:@"patriarch"];
    [self.params setObject:kinsfolk forKey:@"kinsfolk"];
    [self.params setObject:phone forKey:@"phone"];
    [self.params setObject:sex forKey:@"sex"];
    [self.params setObject:locationId forKey:@"locationId"];
    [self.params setObject:location forKey:@"location"];
    [self.params setObject:bairroId forKey:@"bairroId"];
    [self.params setObject:bairro forKey:@"bairro"];
}

@end
