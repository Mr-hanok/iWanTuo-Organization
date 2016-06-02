//
//  ApiAddBookRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiAddBookRequest.h"

@implementation ApiAddBookRequest

- (NSString *)urlAction {
    return AddBookAction;
}

- (void)setApiParamsWithOrganizationId:(NSString *)Id {
    
    [self.params setValue:Id forKey:@"Id"];
}

@end
