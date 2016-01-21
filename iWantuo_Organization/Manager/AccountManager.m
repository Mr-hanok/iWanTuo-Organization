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
    
    [ud setValue:account.userId forKey:@"id"];
    [ud setValue:account.address forKey:@"address"];
//    [ud setValue:account.age forKey:@"age"];
//    [ud setValue:account.createDate forKey:@"createDate"];
//    [ud setValue:account.loginAccounts forKey:@"loginAccounts"];
//    [ud setValue:account.patriarchName forKey:@"patriarchName"];
//    [ud setValue:account.phone forKey:@"phone"];
//    [ud setValue:account.sex forKey:@"sex"];
//    [ud setValue:account.status forKey:@"status"];
//    [ud setValue:account.statusName forKey:@"statusName"];
//    [ud setValue:self.locationId forKey:@"locationId"];
//    [ud setValue:self.locationX forKey:@"locationX"];
//    [ud setValue:self.locationY forKey:@"locationY"];
    [ud setValue:account.isLogin forKey:@"isLogin"];

    [ud synchronize];
}

- (void)loadAccountInfoFromDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    AccountModel *account = [[AccountModel alloc]init];
    
    account.userId = [ValueUtils stringFromObject:[ud objectForKey:@"id"]];
//    account.address = [ValueUtils stringFromObject:[ud objectForKey:@"address"]];
//    account.age = [ValueUtils stringFromObject:[ud objectForKey:@"age"]];
//    account.createDate = [ValueUtils stringFromObject:[ud objectForKey:@"createDate"]];
//    account.loginAccounts = [ValueUtils stringFromObject:[ud objectForKey:@"loginAccounts"]];
//    account.patriarchName = [ValueUtils stringFromObject:[ud objectForKey:@"patriarchName"]];
//    account.phone = [ValueUtils stringFromObject:[ud objectForKey:@"phone"]];
//    account.sex = [ValueUtils stringFromObject:[ud objectForKey:@"sex"]];
//    account.status = [ValueUtils stringFromObject:[ud objectForKey:@"status"]];
//    account.statusName = [ValueUtils stringFromObject:[ud objectForKey:@"statusName"]];
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
