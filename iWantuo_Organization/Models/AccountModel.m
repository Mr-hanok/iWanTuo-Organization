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
    copy.location = [self.location copyWithZone:zone];
    copy.locationName = [self.locationName copyWithZone:zone];
    copy.bairroName = [self.bairroName copyWithZone:zone];
    copy.address = [self.address copyWithZone:zone];
    copy.loginAccounts = [self.loginAccounts copyWithZone:zone];
    copy.email = [self.email copyWithZone:zone];
    copy.organizatioType = [self.organizatioType copyWithZone:zone];
    copy.organizatioTypeName = [self.organizatioTypeName copyWithZone:zone];
    copy.organizationAbbreviation = [self.organizationAbbreviation copyWithZone:zone];
    copy.organization = [self.organization copyWithZone:zone];
    copy.organizationContacts = [self.organizationContacts copyWithZone:zone];
    copy.idCardImage = [self.idCardImage copyWithZone:zone];
    copy.businessLicenseImage = [self.businessLicenseImage copyWithZone:zone];
    copy.coordinateX = [self.coordinateX copyWithZone:zone];
    copy.coordinateY = [self.coordinateY copyWithZone:zone];
    copy.phone = [self.phone copyWithZone:zone];
    copy.idCard = [self.idCard copyWithZone:zone];
    copy.businessLicense = [self.businessLicense copyWithZone:zone];
    copy.createDate = [self.createDate copyWithZone:zone];
    copy.updateDate = [self.updateDate copyWithZone:zone];
    copy.check = [self.check copyWithZone:zone];
    copy.checkName = [self.checkName copyWithZone:zone];
    copy.attestation = [self.attestation copyWithZone:zone];
    copy.attestationName = [self.attestationName copyWithZone:zone];
    copy.warranty = [self.warranty copyWithZone:zone];
    copy.warrantyName = [self.warrantyName copyWithZone:zone];
    copy.introduce = [self.introduce copyWithZone:zone];
    copy.label = [self.label copyWithZone:zone];
    copy.photoAlbum = [self.photoAlbum copyWithZone:zone];
    copy.cost = [self.cost copyWithZone:zone];
    copy.orderNum = [self.orderNum copyWithZone:zone];
    copy.evaluate = [self.evaluate copyWithZone:zone];
    copy.evaluateNum = [self.evaluateNum copyWithZone:zone];
    copy.subject = [self.subject copyWithZone:zone];
    copy.teacher = [self.teacher copyWithZone:zone];
    copy.headPortrait = [self.headPortrait copyWithZone:zone];
    copy.type = [self.type copyWithZone:zone];
    
    copy.organizationAccounts = [self.organizationAccounts copyWithZone:zone];
    copy.statusName = [self.statusName copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    
    copy.isLogin = [self.isLogin copyWithZone:zone];
    copy.accountsType = [self.accountsType copyWithZone:zone];
    return copy;
}


+ (AccountModel *)initWithDict:(NSDictionary *)dict accountType:(NSString *)accountType{
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
        
        account.organizationAccounts = [ValueUtils stringFromObject:[dict objectForKey:@"organizationAccounts"]];
        account.name = [ValueUtils stringFromObject:[dict objectForKey:@"name"]];
        account.statusName = [ValueUtils stringFromObject:[dict objectForKey:@"statusName"]];
        
        account.accountsType = [ValueUtils stringFromObject:accountType];
    }
    return account;
}

@end

