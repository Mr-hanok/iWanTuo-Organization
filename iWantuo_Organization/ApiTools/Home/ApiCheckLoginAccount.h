//
//  ApiCheckLoginAccount.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/3/9.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiCheckLoginAccount : APIRequest

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts;

@end
