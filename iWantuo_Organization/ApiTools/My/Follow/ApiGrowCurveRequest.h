//
//  ApiGrowCurveRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiGrowCurveRequest : APIRequest

- (void)setApiParamesWithStudentId:(NSString *)studentId createDate:(NSString *)createDate;

@end
