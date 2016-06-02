//
//  APIClient.m
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/27.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "APIClient.h"
#import "AFNetworking.h"

@implementation APIClient

#pragma mark - Singleton Model
+ (APIClient *)sharedInstance {
    static APIClient *apiClient;
    static dispatch_once_t onceInit;
    //保证里面的代码只执行一次
    dispatch_once(&onceInit, ^{
        apiClient = [[self alloc] init];
    });
    return apiClient;
}


+ (void)executeGetRequestWithApi:(APIRequest *)api {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = api.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:api.fullUrl parameters:api.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@: %@", api.urlAction,responseObject);
        NSDictionary *outDic = nil;
        switch (api.resultFormat) {
            case kApiResultXml:
                NSLog(@"xml格式数据，无法解析");
                break;  
            case kApiResultJson:
                outDic = (NSDictionary *)responseObject;
                break;
            default:
                NSLog(@"未知的格式数据，无法解析");
                break;
        }
        [api callBackFinishedWithDictionary:outDic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [api callBackFailed:error];
    }];
    
}

+ (void)executePostRequestWithApi:(APIRequest *)api {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = api.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:api.fullUrl parameters:api.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *outDic = nil;
        switch (api.resultFormat) {
            case kApiResultXml:
                NSLog(@"xml格式数据，无法解析");
                break;
            case kApiResultJson:
                outDic = (NSDictionary *)responseObject;
                break;
            default:
                NSLog(@"未知的格式数据，无法解析");
                break;
        }
        [api callBackFinishedWithDictionary:outDic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [api callBackFailed:error];
    }];
}

+ (void)executeUploadRequestWithApi:(APIRequest *)api {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = api.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:api.fullUrl parameters:api.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *err = nil;
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:api.filePath] name:@"file" error:&err];
        if (err) {
            NSLog(@"上传错误:%@",err);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@: %@", api.urlAction,responseObject);
        NSDictionary *outDic = nil;
        switch (api.resultFormat) {
            case kApiResultXml:
                NSLog(@"xml格式数据，无法解析");
                break;
            case kApiResultJson:
                outDic = (NSDictionary *)responseObject;
                break;
            default:
                NSLog(@"未知的格式数据，无法解析");
                break;
        }
        [api callBackFinishedWithDictionary:outDic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [api callBackFailed:error];
    }];
    
}

+ (void)executeDownloadRequestWithApi:(APIRequest *)api {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:api.filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSArray *arr = [api.filePath componentsSeparatedByString:@"/"];
        return [documentsDirectoryURL URLByAppendingPathComponent:[arr lastObject]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            [api downloadFailedCallBack:error];
        } else {
            NSLog(@"File downloaded to: %@", filePath);
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:[filePath absoluteString] forKey:api.filePath];
            [ud synchronize];
            [api downloadSuccessedCallBack:[filePath absoluteString]];
        }
    }];
    [downloadTask resume];
    
}

+ (void)executeUploadMutilRequestWithApi:(APIRequest *)api {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = api.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:api.fullUrl parameters:api.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < api.filePathArray.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:[api.filePathArray objectAtIndex:i]], 0.6);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%d", i] fileName:[NSString stringWithFormat:@"image%d.jpg",i] mimeType:@"image/jpeg"];//[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[api.filePathArray objectAtIndex:i]]]
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DDLogInfo(@"%@: %@", api.urlAction,responseObject);
        NSDictionary *outDic = nil;
        switch (api.resultFormat) {
            case kApiResultXml:
                //                DDLogError(@"xml格式数据，无法解析");
                break;
            case kApiResultJson:
                outDic = (NSDictionary *)responseObject;
                break;
            default:
                //                DDLogError(@"未知的格式数据，无法解析");
                break;
        }
        [api callBackFinishedWithDictionary:outDic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [api callBackFailed:error];
    }];
    
}

+ (void)executeUploadHeadImageRequestWithApi:(APIRequest *)api {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = api.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:api.fullUrl parameters:api.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *err = nil;
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:api.filePath] name:@"Filedata" error:&err];
        if (err) {
            //            DDLogInfo(@"上传错误:%@",err);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DDLogInfo(@"%@: %@", api.urlAction,responseObject);
        NSDictionary *outDic = nil;
        switch (api.resultFormat) {
            case kApiResultXml:
                //                DDLogError(@"xml格式数据，无法解析");
                break;
            case kApiResultJson:
                outDic = (NSDictionary *)responseObject;
                break;
            default:
                //                DDLogError(@"未知的格式数据，无法解析");
                break;
        }
        [api callBackFinishedWithDictionary:outDic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [api callBackFailed:error];
    }];
    
}

+ (void)execute:(APIRequest *)api
{
    NSLog(@"api.fullUrl: %@", api.fullUrl);
    NSLog(@"api.params: %@", api.params);
    switch (api.accessType) {
        case kApiAccessGet:
            [APIClient executeGetRequestWithApi:api];
            break;
        case kApiAccessDownload:
            [APIClient executeDownloadRequestWithApi:api];
            break;
        case kApiAccessUpload:
            [APIClient executeUploadRequestWithApi:api];
            break;
        case kApiAccessPost:
            [APIClient executePostRequestWithApi:api];
            break;
        case kApiAccessMultiUpload:
            [APIClient executeUploadMutilRequestWithApi:api];
            break;
        case kApiAccessUploadHeadimage:
            [APIClient executeUploadHeadImageRequestWithApi:api];
            break;
        default:
            break;
    }
}

@end
