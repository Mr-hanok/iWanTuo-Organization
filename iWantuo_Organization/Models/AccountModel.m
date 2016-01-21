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
//    copy.loginAccounts = [self.loginAccounts copyWithZone:zone];
//    copy.patriarchName = [self.patriarchName copyWithZone:zone];
//    copy.phone = [self.phone copyWithZone:zone];
//    copy.sex = [self.sex copyWithZone:zone];
//    copy.statusName = [self.statusName copyWithZone:zone];
//    copy.status = [self.status copyWithZone:zone];
//    copy.address = [self.address copyWithZone:zone];
//    copy.age = [self.age copyWithZone:zone];
//    copy.createDate = [self.createDate copyWithZone:zone];
    
    copy.isLogin = [self.isLogin copyWithZone:zone];
    copy.accountsType = [self.accountsType copyWithZone:zone];
    return copy;
}


+ (AccountModel *)initWithDict:(NSDictionary *)dict {
    AccountModel *account = [[AccountModel alloc] init];
    if (account) {
        account.userId = [ValueUtils stringFromObject:[dict objectForKey:@"id"]];
        account.location = [ValueUtils stringFromObject:[dict objectForKey:@"location"]];
        account.locationName = [ValueUtils stringFromObject:[dict objectForKey:@"locationName"]];
        account.bairro = [ValueUtils stringFromObject:[dict objectForKey:@"bairro"]];
        account.bairroName = [ValueUtils stringFromObject:[dict objectForKey:@"bairroName"]];
        account.address = [ValueUtils stringFromObject:[dict objectForKey:@"address"]];
        account.loginAccounts = [ValueUtils stringFromObject:[dict objectForKey:@"loginAccounts"]];
        account.email = [ValueUtils stringFromObject:[dict objectForKey:@"email"]];
        account.organizatioType = [ValueUtils stringFromObject:[dict objectForKey:@"organizatioType"]];
        account.organizatioTypeName = [ValueUtils stringFromObject:[dict objectForKey:@"organizatioTypeName"]];
        account.organizationAbbreviation = [ValueUtils stringFromObject:[dict objectForKey:@"organizationAbbreviation"]];
        account.organization = [ValueUtils stringFromObject:[dict objectForKey:@"organization"]];
        account.organizationContacts = [ValueUtils stringFromObject:[dict objectForKey:@"organizationContacts"]];
        account.idCardImage = [ValueUtils stringFromObject:[dict objectForKey:@"idCardImage"]];
        account.businessLicenseImage = [ValueUtils stringFromObject:[dict objectForKey:@"businessLicenseImage"]];
        account.coordinateX = [ValueUtils stringFromObject:[dict objectForKey:@"coordinateX"]];
        account.coordinateY = [ValueUtils stringFromObject:[dict objectForKey:@"coordinateY"]];
        account.phone = [ValueUtils stringFromObject:[dict objectForKey:@"phone"]];
        account.idCard = [ValueUtils stringFromObject:[dict objectForKey:@"idCard"]];
        account.businessLicense = [ValueUtils stringFromObject:[dict objectForKey:@"businessLicense"]];
        account.createDate = [ValueUtils stringFromObject:[dict objectForKey:@"createDate"]];
        account.updateDate = [ValueUtils stringFromObject:[dict objectForKey:@"updateDate"]];
        account.check = [ValueUtils stringFromObject:[dict objectForKey:@"check"]];
        account.checkName = [ValueUtils stringFromObject:[dict objectForKey:@"checkName"]];
        account.attestation = [ValueUtils stringFromObject:[dict objectForKey:@"attestation"]];
        account.attestationName = [ValueUtils stringFromObject:[dict objectForKey:@"attestationName"]];
        account.warranty = [ValueUtils stringFromObject:[dict objectForKey:@"warranty"]];
        account.warrantyName = [ValueUtils stringFromObject:[dict objectForKey:@"warrantyName"]];
        account.introduce = [ValueUtils stringFromObject:[dict objectForKey:@"introduce"]];
        account.label = [ValueUtils stringFromObject:[dict objectForKey:@"label"]];
        account.photoAlbum = [ValueUtils stringFromObject:[dict objectForKey:@"photoAlbum"]];
        account.cost = [ValueUtils stringFromObject:[dict objectForKey:@"cost"]];
        account.orderNum = [ValueUtils stringFromObject:[dict objectForKey:@"orderNum"]];
        account.evaluate = [ValueUtils stringFromObject:[dict objectForKey:@"evaluate"]];
        account.evaluateNum = [ValueUtils stringFromObject:[dict objectForKey:@"evaluateNum"]];
        account.subject = [ValueUtils stringFromObject:[dict objectForKey:@"subject"]];
        account.teacher = [ValueUtils stringFromObject:[dict objectForKey:@"teacher"]];
        account.headPortrait = [ValueUtils stringFromObject:[dict objectForKey:@"headPortrait"]];
        account.type = [ValueUtils stringFromObject:[dict objectForKey:@"type"]];
    }
    return account;
}

@end

#pragma mark  -  老师模型
@implementation TeacherAccountModel



@end