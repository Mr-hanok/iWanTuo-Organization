//
//  UploadManager.h
//  DoctorYL
//
//  Created by 张玺 on 15/3/17.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadManager : NSObject

+ (UploadManager *)sharedInstance;

- (void)uploadFileWithFilePath:(NSString *)filePath
                       success:(void (^)(NSString *fileUrl, NSString * serverUrl, NSString * message))success
                       failure:(void (^)(NSString * message))failure;

@end
