//
//  ApiRegisterRequest.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  机构注册
 */
@interface ApiRegisterRequest : APIRequest

-(void)setApiParamsWithLoginAccount:(NSString *)loginAccounts
                           password:(NSString *)password
                            address:(NSString *)address
                              email:(NSString *)email
           organizationAbbreviation:(NSString *)organizationAbbreviation
                       organization:(NSString *)organization
               organizationContacts:(NSString *)organizationContacts
                       locationName:(NSString *)locationName
                           location:(NSString *)location
                             bairro:(NSString *)bairro
                         bairroName:(NSString *)bairroName
                    organizatioType:(NSString *)organizatioType
                organizatioTypeName:(NSString *)organizatioTypeName
                        idCardImage:(NSString *)idCardImage
                              phone:(NSString *)phone;
@end
