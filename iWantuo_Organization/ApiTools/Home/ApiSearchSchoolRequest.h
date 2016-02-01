//
//  ApiSearchSchoolRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiSearchSchoolRequest : APIRequest

-(void)setApiParamsWithLocation:(NSString *)location schoolName:(NSString *)schoolName page:(NSString *)page locationX:(NSString *)locationX locationY:(NSString *)locationY;

@end
