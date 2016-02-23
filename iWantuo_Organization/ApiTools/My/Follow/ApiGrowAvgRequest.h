//
//  ApiGrowAvgRequest.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiGrowAvgRequest : APIRequest

- (void)setApiParamesWithStudentId:(NSString *)studentId createDate:(NSString *)createDate;

@end
