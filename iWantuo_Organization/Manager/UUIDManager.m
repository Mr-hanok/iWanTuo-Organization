//
//  UUIDManager.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/3/9.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "UUIDManager.h"
#import "SSKeychain.h"

@implementation UUIDManager

+ (NSString *)deviceUUID {
    // 1.从钥匙串获取UUID，注意修改bundleID
    NSString *uuid = [SSKeychain passwordForService:@"com.uniomx.iwantuoOrganization" account:@"UUID"];
    // 2.如果本地没有则生成，并且保存到钥匙串
    if (uuid == nil || [uuid isEqualToString:@""]) {
        uuid = [NSUUID UUID].UUIDString;
        [SSKeychain setPassword:uuid forService:@"com.uniomx.iwantuoOrganization" account:@"UUID"];
    }
    return uuid;
}

@end
