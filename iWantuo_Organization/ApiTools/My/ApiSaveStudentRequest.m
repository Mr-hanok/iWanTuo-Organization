//
//  ApiSaveStudentRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSaveStudentRequest.h"

@implementation ApiSaveStudentRequest


- (NSString *)urlAction {
    return SaveStudentAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithName:(NSString *)name
                      school:(NSString *)school
                       grade:(NSString *)grade
               loginAccounts:(NSString *)loginAccounts
                   patriarch:(NSString *)patriarch
                       phone:(NSString *)phone
                         sex:(NSString *)sex
        organizationAccounts:(NSString *)organizationAccounts
                  createDate:(NSString *)createDate
                  locationId:(NSString *)locationId
                    location:(NSString *)location
                    bairroId:(NSString *)bairroId
                      bairro:(NSString *)bairro
                    kinsfolk:(NSString *)kinsfolk {
    
    [self.params setValue:name forKey:@"name"];
    [self.params setValue:school forKey:@"school"];
    [self.params setValue:grade forKey:@"grade"];
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];//家长帐号
    [self.params setValue:locationId forKey:@"locationId"]; //所在市id
    [self.params setValue:patriarch forKey:@"patriarch"];  //学生家长 父亲,母亲
    [self.params setValue:phone forKey:@"phone"];    //其他联系电话
    [self.params setValue:sex forKey:@"sex"];  //1 男 2女
    [self.params setValue:organizationAccounts forKey:@"organizationAccounts"];//机构帐号
    [self.params setValue:createDate forKey:@"createDate"]; //入托时间 时间戳 年月日 必须
    [self.params setValue:location forKey:@"location"];//所在市
    [self.params setValue:bairroId forKey:@"bairroId"];//所在区id
    [self.params setValue:bairro forKey:@"bairro"]; //所在区
    [self.params setValue:kinsfolk forKey:@"kinsfolk"]; //亲属关系
}

@end
