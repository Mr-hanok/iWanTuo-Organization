//
//  ApiUpdateStudentRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  修改学生信息
 */
@interface ApiUpdateStudentRequest : APIRequest
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
                           login:(NSString *)login
                        schoolId:(NSString *)schoolId;
@end
