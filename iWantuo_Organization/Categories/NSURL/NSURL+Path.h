//
//  NSURL+Path.h
//  DoctorYL
//
//  Created by 陈腾飞 on 15/8/24.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

/* 沙盒中的文件类型:
 Documents: 存储用户的设置, 用户需要保存的数据
 (如果使用iCloud服务,苹果会把documents文件夹中所有的数据都上传到iCloud服务器, iCloud空间有限, 不要在这个文件夹存储 视频, 音频, 体积大的文件)
 
 Library/Caches: 缓存文件夹, 存储系统/用户的一些缓存文件
 比如text/图片/视频/音频..  ,清除缓存就是删除这个文件夹
 
 Library/Preferences: 是给开发者使用的偏好设置文件夹, 用来存储应用执行需要的一些数据(是不是第一次开机..)
 
 tmp: 存储临时文件, 在版本更新的时候会被删掉所有内容
 
 应用程序的可执行文件(.app): 包含这个应用程序执行的所有代码,资源,基本设置. (不能修改)
 */

/**
 *  @brief  获取系统沙盒路径
 */

#import <Foundation/Foundation.h>

@interface NSURL (Path)

+ (NSURL *)pathWithResourceFile:(NSString *)filename;

+ (NSURL *)pathWithTempFile:(NSString *)filename;

+ (NSURL *)pathWithDocumentFile:(NSString *)filename;

+ (NSURL *)pathWithCachesFile:(NSString *)filename;

+ (NSURL *)pathWithPreferencesFile:(NSString *)filename;

@end
