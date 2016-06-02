//
//  SharSdkManager.h
//  StudyChina
//
//  Created by 月 吴 on 15/10/27.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharSdkManager : NSObject
//+ (void)ShareEventClicked:(UIView *)view content:(NSString *)content url:(NSString *)url;

+ (void)ShareEventClicked:(UIView *)view content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl;
@end
