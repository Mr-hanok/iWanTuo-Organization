//
//  ApiPatriarchListRequest.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiPatriarchListRequest.h"

@implementation ApiPatriarchListRequest
- (NSString *)urlAction {
    return PatriarchListAction;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts page:(NSString *)page{
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];

}
@end
