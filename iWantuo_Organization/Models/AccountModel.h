//
//  AccountModel.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
//accountsType = 2;
//cId = "";
//createDate = "2016-01-16 16:15:34.0";
//deviceToken = "";
//id = 3;
//loginAccounts = 18210890192;
//password = 120217;
//status = 2;
//statusName = "";
//updateDate = "2016-01-16 16:15:37.0";
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *loginAccounts;
@property (nonatomic, copy) NSString *patriarchName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, strong) NSString *isLogin;

+ (AccountModel *)initWithDict:(NSDictionary *)dict;

@end
