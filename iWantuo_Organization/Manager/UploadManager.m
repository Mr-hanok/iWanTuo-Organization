//
//  UploadManager.m
//  DoctorYL
//
//  Created by 张玺 on 15/3/17.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "UploadManager.h"
#import "UploadApiRequest.h"
//#import "HUDManager.h"

@interface UploadManager()<APIRequestDelegate>

@property(nonatomic, strong) UploadApiRequest *uploadApi;
@property(nonatomic, strong) void (^success)(NSString *fileUrl, NSString * serverUrl, NSString * message);
@property(nonatomic, strong) void (^failure)(NSString * message);

@end

@implementation UploadManager

static UploadManager *sharedInstance = nil;
#pragma mark Singleton Model
+ (UploadManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UploadManager alloc]init];
        sharedInstance.uploadApi = [[UploadApiRequest alloc] initWithDelegate:sharedInstance];
    });
    return sharedInstance;
}

- (void)uploadFileWithFilePath:(NSString *)filePath
                       success:(void (^)(NSString *fileUrl, NSString * serverUrl, NSString * message))success
                       failure:(void (^)(NSString * message))failure {
    self.success = success;
    self.failure = failure;
    [self.uploadApi setApiParamsWithFilePath:filePath];
    [APIClient execute:self.uploadApi];

}

#pragma mark - APIRequestDelegate

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    if (sr.success) {
        if (self.uploadApi == api) {
            int status = [sr.dic[@"status"] intValue];
            if (status == 0) {
                NSString *fileUrl = sr.dic[@"filePath"];
               // NSString *serverUrl = [AccountManager sharedInstance].imageBaseUrl;
                NSString *serverUrl = @"";
//                serverUrl = [@"" stringByAppendingPathComponent:serverUrl];
                NSString *message = sr.dic[@"message"];
                self.success(fileUrl,serverUrl,message);
            } else {
                NSString *message = sr.dic[@"message"];
                self.failure(message);
            }
        }
    }
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr
{
    NSString *message = sr.msg;
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    self.failure(message);
}

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    self.failure(kDefaultNetWorkErrorString);
}

@end
