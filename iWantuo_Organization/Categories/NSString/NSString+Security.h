//
//  NSString+Security.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/29.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Security)

/**
 *  @brief  获取32位md5加密
 *
 *  @return 加密后字符串
 */
- (NSString *) md5;

/**
 *  @brief  生成唯一的字符串
 *
 *  @return 唯一字符串
 */
+ (NSString*) uniqueString;

/**
 *  @brief  使用UTF8格式编码
 *
 *  @return 编码候字符串
 */
- (NSString*) urlEncodedString;

/**
 *  @brief  使用UTF8解码
 *
 *  @return 解码候的字符串
 */
- (NSString*) urlDecodedString;
@end
