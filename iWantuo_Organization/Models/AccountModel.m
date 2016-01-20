//
//  AccountModel.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    
    AccountModel *copy = [[[self class] allocWithZone:zone] init];
    copy.userId = [self.userId copyWithZone:zone];
    copy.loginAccounts = [self.loginAccounts copyWithZone:zone];
    copy.patriarchName = [self.patriarchName copyWithZone:zone];
    copy.phone = [self.phone copyWithZone:zone];
    copy.sex = [self.sex copyWithZone:zone];
    copy.statusName = [self.statusName copyWithZone:zone];
    copy.status = [self.status copyWithZone:zone];
    copy.address = [self.address copyWithZone:zone];
    copy.age = [self.age copyWithZone:zone];
    copy.createDate = [self.createDate copyWithZone:zone];
    copy.isLogin = [self.isLogin copyWithZone:zone];
    
    return copy;
}


+ (AccountModel *)initWithDict:(NSDictionary *)dict {
    AccountModel *account = [[AccountModel alloc] init];
    if (account) {
        account.userId = [ValueUtils stringFromObject:[dict objectForKey:@"id"]];
        account.address = [ValueUtils stringFromObject:[dict objectForKey:@"address"]];
        account.age = [ValueUtils stringFromObject:[dict objectForKey:@"age"]];
        account.createDate = [ValueUtils stringFromObject:[dict objectForKey:@"createDate"]];
        account.loginAccounts = [ValueUtils stringFromObject:[dict objectForKey:@"loginAccounts"]];
        account.patriarchName = [ValueUtils stringFromObject:[dict objectForKey:@"patriarchName"]];
        account.phone = [ValueUtils stringFromObject:[dict objectForKey:@"phone"]];
        account.sex = [ValueUtils stringFromObject:[dict objectForKey:@"sex"]];
        account.status = [ValueUtils stringFromObject:[dict objectForKey:@"status"]];
        account.statusName = [ValueUtils stringFromObject:[dict objectForKey:@"statusName"]];
    }
    return account;
}

@end
