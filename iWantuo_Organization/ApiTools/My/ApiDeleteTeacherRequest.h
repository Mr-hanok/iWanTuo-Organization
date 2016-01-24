//
//  ApiDeleteTeacherRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiDeleteTeacherRequest : APIRequest

- (void)setApiParamsWithTeacherId:(NSString *)teacherId ;

@end
