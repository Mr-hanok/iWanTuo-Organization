//
//  AccountManager.m
//  DoctorYL
//
//  Created by 张玺 on 14/12/16.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "AccountManager.h"
#import "ApiRequest.h"

@interface AccountManager ()


@end

@implementation AccountManager

static AccountManager *sharedInstance;
#pragma mark Singleton Model
+ (AccountManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AccountManager alloc]init];
        sharedInstance.account = [[AccountModel alloc] init];
        sharedInstance.imageBaseUrl = SERVER_FILE_PRODUCT;
        sharedInstance.locationId = @"";
        sharedInstance.locationX = @"";
        sharedInstance.locationY = @"";
        sharedInstance.addressArray = [NSMutableArray array];
        [sharedInstance loadAccountInfoFromDisk];
        
    });
    return sharedInstance;
}


#pragma mark - Save user info

- (void)saveAccountInfoToDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    AccountModel *account = [[AccountModel alloc]init];
    
    [ud setValue:self.account.location forKey:@"location"];
    [ud setValue:self.account.locationName forKey:@"locationName"];
    [ud setValue:self.account.bairro forKey:@"bairro"];
    [ud setValue:self.account.bairroName forKey:@"bairroName"];
    [ud setValue:self.account.address forKey:@"address"];
    [ud setValue:self.account.loginAccounts forKey:@"loginAccounts"];
    [ud setValue:self.account.email forKey:@"email"];
    [ud setValue:self.account.organizatioType forKey:@"organizatioType"];
    [ud setValue:self.account.organizatioTypeName forKey:@"organizatioTypeName"];
    [ud setValue:self.account.organizationAbbreviation forKey:@"organizationAbbreviation"];
    [ud setValue:self.account.organization forKey:@"organization"];
    [ud setValue:self.account.organizationContacts forKey:@"organizationContacts"];
    [ud setValue:self.account.idCardImage forKey:@"idCardImage"];
    [ud setValue:self.account.businessLicenseImage forKey:@"businessLicenseImage"];
    [ud setValue:self.account.coordinateX forKey:@"coordinateX"];
    [ud setValue:self.account.coordinateY forKey:@"coordinateY"];
    [ud setValue:self.account.phone forKey:@"phone"];
    [ud setValue:self.account.idCard forKey:@"idCard"];
    [ud setValue:self.account.businessLicense forKey:@"businessLicense"];
    [ud setValue:self.account.createDate forKey:@"createDate"];
    [ud setValue:self.account.updateDate forKey:@"updateDate"];
    [ud setValue:self.account.check forKey:@"check"];
    [ud setValue:self.account.checkName forKey:@"checkName"];
    [ud setValue:self.account.attestation forKey:@"attestation"];
    [ud setValue:self.account.attestationName forKey:@"attestationName"];
    [ud setValue:self.account.warranty forKey:@"warranty"];
    [ud setValue:self.account.warrantyName forKey:@"warrantyName"];
    [ud setValue:self.account.introduce forKey:@"introduce"];
    [ud setValue:self.account.label forKey:@"label"];
    [ud setValue:self.account.photoAlbum forKey:@"photoAlbum"];
    [ud setValue:self.account.cost forKey:@"cost"];
    [ud setValue:self.account.orderNum forKey:@"orderNum"];
    [ud setValue:self.account.evaluate forKey:@"evaluate"];
    [ud setValue:self.account.evaluateNum forKey:@"evaluateNum"];
    [ud setValue:self.account.subject forKey:@"subject"];
    [ud setValue:self.account.teacher forKey:@"teacher"];
    [ud setValue:self.account.headPortrait forKey:@"headPortrait"];
    [ud setValue:self.account.type forKey:@"type"];
    
    [ud setValue:self.account.pathName forKey:@"pathName"];

    
    [ud setValue:self.account.organizationAccounts forKey:@"organizationAccounts"];
    [ud setValue:self.account.name forKey:@"name"];
    [ud setValue:self.account.statusName forKey:@"statusName"];

    [ud setValue:self.locationId forKey:@"locationId"];
    [ud setValue:self.locationX forKey:@"locationX"];
    [ud setValue:self.locationY forKey:@"locationY"];
    [ud setValue:self.account.isLogin forKey:@"isLogin"];
    [ud setValue:self.account.accountsType forKey:@"accountsType"];

    [ud synchronize];
}

- (void)loadAccountInfoFromDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    self.account.userId = [ValueUtils stringFromObject:[ud objectForKey:@"id"]];
    self.account.location = [ValueUtils stringFromObject:[ud objectForKey:@"location"]];
    self.account.locationName = [ValueUtils stringFromObject:[ud objectForKey:@"locationName"]];
    self.account.bairro = [ValueUtils stringFromObject:[ud objectForKey:@"bairro"]];
    self.account.bairroName = [ValueUtils stringFromObject:[ud objectForKey:@"bairroName"]];
    self.account.address = [ValueUtils stringFromObject:[ud objectForKey:@"address"]];
    self.account.loginAccounts = [ValueUtils stringFromObject:[ud objectForKey:@"loginAccounts"]];
    self.account.email = [ValueUtils stringFromObject:[ud objectForKey:@"email"]];
    self.account.organizatioType = [ValueUtils stringFromObject:[ud objectForKey:@"organizatioType"]];
    self.account.organizatioTypeName = [ValueUtils stringFromObject:[ud objectForKey:@"organizatioTypeName"]];
    self.account.organizationAbbreviation = [ValueUtils stringFromObject:[ud objectForKey:@"organizationAbbreviation"]];
    self.account.organization = [ValueUtils stringFromObject:[ud objectForKey:@"organization"]];
    self.account.organizationContacts = [ValueUtils stringFromObject:[ud objectForKey:@"organizationContacts"]];
    self.account.idCardImage = [ValueUtils stringFromObject:[ud objectForKey:@"idCardImage"]];
    self.account.businessLicenseImage = [ValueUtils stringFromObject:[ud objectForKey:@"businessLicenseImage"]];
    self.account.coordinateX = [ValueUtils stringFromObject:[ud objectForKey:@"coordinateX"]];
    self.account.coordinateY = [ValueUtils stringFromObject:[ud objectForKey:@"coordinateY"]];
    self.account.phone = [ValueUtils stringFromObject:[ud objectForKey:@"phone"]];
    self.account.idCard = [ValueUtils stringFromObject:[ud objectForKey:@"idCard"]];
    self.account.businessLicense = [ValueUtils stringFromObject:[ud objectForKey:@"businessLicense"]];
    self.account.createDate = [ValueUtils stringFromObject:[ud objectForKey:@"createDate"]];
    self.account.updateDate = [ValueUtils stringFromObject:[ud objectForKey:@"updateDate"]];
    self.account.check = [ValueUtils stringFromObject:[ud objectForKey:@"check"]];
    self.account.checkName = [ValueUtils stringFromObject:[ud objectForKey:@"checkName"]];
    self.account.attestation = [ValueUtils stringFromObject:[ud objectForKey:@"attestation"]];
    self.account.attestationName = [ValueUtils stringFromObject:[ud objectForKey:@"attestationName"]];
    self.account.warranty = [ValueUtils stringFromObject:[ud objectForKey:@"warranty"]];
    self.account.warrantyName = [ValueUtils stringFromObject:[ud objectForKey:@"warrantyName"]];
    self.account.introduce = [ValueUtils stringFromObject:[ud objectForKey:@"introduce"]];
    self.account.label = [ValueUtils stringFromObject:[ud objectForKey:@"label"]];
    self.account.photoAlbum = [ValueUtils stringFromObject:[ud objectForKey:@"photoAlbum"]];
    self.account.cost = [ValueUtils stringFromObject:[ud objectForKey:@"cost"]];
    self.account.orderNum = [ValueUtils stringFromObject:[ud objectForKey:@"orderNum"]];
    self.account.evaluate = [ValueUtils stringFromObject:[ud objectForKey:@"evaluate"]];
    self.account.evaluateNum = [ValueUtils stringFromObject:[ud objectForKey:@"evaluateNum"]];
    self.account.subject = [ValueUtils stringFromObject:[ud objectForKey:@"subject"]];
    self.account.teacher = [ValueUtils stringFromObject:[ud objectForKey:@"teacher"]];
    self.account.headPortrait = [ValueUtils stringFromObject:[ud objectForKey:@"headPortrait"]];
    self.account.type = [ValueUtils stringFromObject:[ud objectForKey:@"type"]];
    
    self.account.pathName = [ValueUtils stringFromObject:[ud objectForKey:@"pathName"]];
    
    self.account.organizationAccounts = [ValueUtils stringFromObject:[ud objectForKey:@"organizationAccounts"]];
    self.account.name = [ValueUtils stringFromObject:[ud objectForKey:@"name"]];
    self.account.statusName = [ValueUtils stringFromObject:[ud objectForKey:@"statusName"]];
    
    
    self.account.accountsType = [ValueUtils stringFromObject:[ud objectForKey:@"accountsType"]];
    self.account.isLogin = [ValueUtils stringFromObject:[ud objectForKey:@"isLogin"]];
    self.locationId = [ValueUtils stringFromObject:[ud objectForKey:@"locationId"]];
    self.locationX = [ValueUtils stringFromObject:[ud objectForKey:@"locationX"]];
    self.locationY = [ValueUtils stringFromObject:[ud objectForKey:@"locationY"]];
}



#pragma mark - get/set方法

- (BOOL)isLogin {
    return [self.account.isLogin isEqualToString:@"yes"];
}



@end
