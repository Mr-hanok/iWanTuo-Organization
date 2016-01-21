//
//  ApiSaveStudentRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiSaveStudentRequest : APIRequest

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
                    kinsfolk:(NSString *)kinsfolk;

@end
