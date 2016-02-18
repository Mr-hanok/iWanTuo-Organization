//
//  AccountManager.h
//  DoctorYL
//
//  Created by 张玺 on 14/12/16.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface AccountManager : NSObject

@property (nonatomic, strong) AccountModel *account;
@property (nonatomic, readonly) NSString *uuid;
@property (nonatomic, strong) NSString *imageBaseUrl;

@property (nonatomic, readonly) BOOL isLogin;

@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *locationX; //用户当前位置坐标
@property (nonatomic, strong) NSString *locationY;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSString *deviceToken;





+ (AccountManager *)sharedInstance;

- (void)saveAccountInfoToDisk;
- (void)loadAccountInfoFromDisk;

@end
