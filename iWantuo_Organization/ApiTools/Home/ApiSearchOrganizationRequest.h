//
//  ApiSearchOrganizationRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiSearchOrganizationRequest : APIRequest

-(void)setApiParamsWithLocation:(NSString *)location
                         bairro:(NSString *)bairro
                   organization:(NSString *)organization
                           page:(NSString *)page
                      locationX:(NSString *)locationX
                      locationY:(NSString *)locationY
                       distance:(NSString *)distance
                           Type:(NSString *)Type
                           rows:(NSString *)rows;

@end
