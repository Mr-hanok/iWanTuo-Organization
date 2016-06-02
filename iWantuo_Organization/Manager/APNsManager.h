//
//  APNsManager.h
//  DoctorYL
//
//  Created by 张玺 on 15/1/13.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeTuiSdk.h"


@interface APNsManager : NSObject

@property (assign, nonatomic) int lastPayloadIndex;
@property (assign, nonatomic) SdkStatus sdkStatus;
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *deviceToken;

+ (APNsManager *)sharedInstance;

- (void)registerDeviceToken:(NSString *)deviceToken;

- (void)startSdk;

- (void)stopSdk;

@end
