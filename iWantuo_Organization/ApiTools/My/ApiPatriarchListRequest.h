//
//  ApiPatriarchListRequest.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"

@interface ApiPatriarchListRequest : APIRequest

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts page:(NSString *)page;

@end
