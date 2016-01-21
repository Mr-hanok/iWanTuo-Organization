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
    AccountModel *account = [[AccountModel alloc]init];
    
    [ud setValue:account.location forKey:@"location"];
    [ud setValue:account.locationName forKey:@"locationName"];
    [ud setValue:account.bairro forKey:@"bairro"];
    [ud setValue:account.bairroName forKey:@"bairroName"];
    [ud setValue:account.address forKey:@"address"];
    [ud setValue:account.loginAccounts forKey:@"loginAccounts"];
    [ud setValue:account.email forKey:@"email"];
    [ud setValue:account.organizatioType forKey:@"organizatioType"];
    [ud setValue:account.organizatioTypeName forKey:@"organizatioTypeName"];
    [ud setValue:account.organizationAbbreviation forKey:@"organizationAbbreviation"];
    [ud setValue:account.organization forKey:@"organization"];
    [ud setValue:account.organizationContacts forKey:@"organizationContacts"];
    [ud setValue:account.idCardImage forKey:@"idCardImage"];
    [ud setValue:account.businessLicenseImage forKey:@"businessLicenseImage"];
    [ud setValue:account.coordinateX forKey:@"coordinateX"];
    [ud setValue:account.coordinateY forKey:@"coordinateY"];
    [ud setValue:account.phone forKey:@"phone"];
    [ud setValue:account.idCard forKey:@"idCard"];
    [ud setValue:account.businessLicense forKey:@"businessLicense"];
    [ud setValue:account.createDate forKey:@"createDate"];
    [ud setValue:account.updateDate forKey:@"updateDate"];
    [ud setValue:account.check forKey:@"check"];
    [ud setValue:account.checkName forKey:@"checkName"];
    [ud setValue:account.attestation forKey:@"attestation"];
    [ud setValue:account.attestationName forKey:@"attestationName"];
    [ud setValue:account.warranty forKey:@"warranty"];
    [ud setValue:account.warrantyName forKey:@"warrantyName"];
    [ud setValue:account.introduce forKey:@"introduce"];
    [ud setValue:account.label forKey:@"label"];
    [ud setValue:account.photoAlbum forKey:@"photoAlbum"];
    [ud setValue:account.cost forKey:@"cost"];
    [ud setValue:account.orderNum forKey:@"orderNum"];
    [ud setValue:account.evaluate forKey:@"evaluate"];
    [ud setValue:account.evaluateNum forKey:@"evaluateNum"];
    [ud setValue:account.subject forKey:@"subject"];
    [ud setValue:account.teacher forKey:@"teacher"];
    [ud setValue:account.headPortrait forKey:@"headPortrait"];
    [ud setValue:account.type forKey:@"type"];
    
    [ud setValue:account.organizationAccounts forKey:@"organizationAccounts"];
    [ud setValue:account.name forKey:@"name"];
    [ud setValue:account.statusName forKey:@"statusName"];

    [ud setValue:self.locationId forKey:@"locationId"];
    [ud setValue:self.locationX forKey:@"locationX"];
    [ud setValue:self.locationY forKey:@"locationY"];
    [ud setValue:account.isLogin forKey:@"isLogin"];
    [ud setValue:account.accountsType forKey:@"accountsType"];

    [ud synchronize];
}

- (void)loadAccountInfoFromDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    AccountModel *account = [[AccountModel alloc]init];
    
    account.userId = [ValueUtils stringFromObject:[ud objectForKey:@"id"]];
    account.location = [ValueUtils stringFromObject:[ud objectForKey:@"location"]];
    account.locationName = [ValueUtils stringFromObject:[ud objectForKey:@"locationName"]];
    account.bairro = [ValueUtils stringFromObject:[ud objectForKey:@"bairro"]];
    account.bairroName = [ValueUtils stringFromObject:[ud objectForKey:@"bairroName"]];
    account.address = [ValueUtils stringFromObject:[ud objectForKey:@"address"]];
    account.loginAccounts = [ValueUtils stringFromObject:[ud objectForKey:@"loginAccounts"]];
    account.email = [ValueUtils stringFromObject:[ud objectForKey:@"email"]];
    account.organizatioType = [ValueUtils stringFromObject:[ud objectForKey:@"organizatioType"]];
    account.organizatioTypeName = [ValueUtils stringFromObject:[ud objectForKey:@"organizatioTypeName"]];
    account.organizationAbbreviation = [ValueUtils stringFromObject:[ud objectForKey:@"organizationAbbreviation"]];
    account.organization = [ValueUtils stringFromObject:[ud objectForKey:@"organization"]];
    account.organizationContacts = [ValueUtils stringFromObject:[ud objectForKey:@"organizationContacts"]];
    account.idCardImage = [ValueUtils stringFromObject:[ud objectForKey:@"idCardImage"]];
    account.businessLicenseImage = [ValueUtils stringFromObject:[ud objectForKey:@"businessLicenseImage"]];
    account.coordinateX = [ValueUtils stringFromObject:[ud objectForKey:@"coordinateX"]];
    account.coordinateY = [ValueUtils stringFromObject:[ud objectForKey:@"coordinateY"]];
    account.phone = [ValueUtils stringFromObject:[ud objectForKey:@"phone"]];
    account.idCard = [ValueUtils stringFromObject:[ud objectForKey:@"idCard"]];
    account.businessLicense = [ValueUtils stringFromObject:[ud objectForKey:@"businessLicense"]];
    account.createDate = [ValueUtils stringFromObject:[ud objectForKey:@"createDate"]];
    account.updateDate = [ValueUtils stringFromObject:[ud objectForKey:@"updateDate"]];
    account.check = [ValueUtils stringFromObject:[ud objectForKey:@"check"]];
    account.checkName = [ValueUtils stringFromObject:[ud objectForKey:@"checkName"]];
    account.attestation = [ValueUtils stringFromObject:[ud objectForKey:@"attestation"]];
    account.attestationName = [ValueUtils stringFromObject:[ud objectForKey:@"attestationName"]];
    account.warranty = [ValueUtils stringFromObject:[ud objectForKey:@"warranty"]];
    account.warrantyName = [ValueUtils stringFromObject:[ud objectForKey:@"warrantyName"]];
    account.introduce = [ValueUtils stringFromObject:[ud objectForKey:@"introduce"]];
    account.label = [ValueUtils stringFromObject:[ud objectForKey:@"label"]];
    account.photoAlbum = [ValueUtils stringFromObject:[ud objectForKey:@"photoAlbum"]];
    account.cost = [ValueUtils stringFromObject:[ud objectForKey:@"cost"]];
    account.orderNum = [ValueUtils stringFromObject:[ud objectForKey:@"orderNum"]];
    account.evaluate = [ValueUtils stringFromObject:[ud objectForKey:@"evaluate"]];
    account.evaluateNum = [ValueUtils stringFromObject:[ud objectForKey:@"evaluateNum"]];
    account.subject = [ValueUtils stringFromObject:[ud objectForKey:@"subject"]];
    account.teacher = [ValueUtils stringFromObject:[ud objectForKey:@"teacher"]];
    account.headPortrait = [ValueUtils stringFromObject:[ud objectForKey:@"headPortrait"]];
    account.type = [ValueUtils stringFromObject:[ud objectForKey:@"type"]];
    
    account.organizationAccounts = [ValueUtils stringFromObject:[ud objectForKey:@"organizationAccounts"]];
    account.name = [ValueUtils stringFromObject:[ud objectForKey:@"name"]];
    account.statusName = [ValueUtils stringFromObject:[ud objectForKey:@"statusName"]];
    
    
    account.accountsType = [ValueUtils stringFromObject:[ud objectForKey:@"accountsType"]];
    account.isLogin = [ValueUtils stringFromObject:[ud objectForKey:@"isLogin"]];
    self.locationId = [ValueUtils stringFromObject:[ud objectForKey:@"locationId"]];
    self.locationX = [ValueUtils stringFromObject:[ud objectForKey:@"locationX"]];
    self.locationY = [ValueUtils stringFromObject:[ud objectForKey:@"locationY"]];
}



#pragma mark - get/set方法

- (BOOL)isLogin {
    return [self.account.isLogin isEqualToString:@"yes"];
}



@end
