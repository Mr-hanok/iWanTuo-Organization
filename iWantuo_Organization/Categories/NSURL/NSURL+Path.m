//
//  NSURL+Path.m
//  DoctorYL
//
//  Created by 陈腾飞 on 15/8/24.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "NSURL+Path.h"

@implementation NSURL (Path)

+ (NSURL *)pathWithResourceFile:(NSString *)filename {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [NSBundle mainBundle].resourcePath, filename];
    return [NSURL URLWithString:path];
}

+ (NSURL *)pathWithTempFile:(NSString *)filename {
    NSString *path = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), filename];
    return [NSURL URLWithString:path];
}

+ (NSURL *)pathWithDocumentFile:(NSString *)filename {
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), filename];
    return [NSURL URLWithString:path];
}

+ (NSURL *)pathWithCachesFile:(NSString *)filename {
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), filename];
    return [NSURL URLWithString:path];
}

+ (NSURL *)pathWithPreferencesFile:(NSString *)filename {
    NSString *path = [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), filename];
    return [NSURL URLWithString:path];
}

@end
