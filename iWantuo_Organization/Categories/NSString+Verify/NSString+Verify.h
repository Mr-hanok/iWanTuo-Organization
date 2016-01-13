//
//  NSStringVerify.h
//  RegisterModule
//
//  Created by 吴月 on 14-12-8.
//  Copyright (c) 2014年 chenTengFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

/**
*  邮箱验证
*
*  @param email email字符串
*
*  @return 是邮箱地址YES
*/
+ (BOOL)tf_isValidateEmail:(NSString *)email;

/**
 *  手机号码验证
 *
 *  @param mobileNum 手机号字符串
 *
 *  @return 是手机号YES
 */
+ (BOOL)tf_isMobileNumber:(NSString *)mobileNum;


/**
 *  @brief  简单手机号验证
 *
 *  @param mobileNum 手机号字符串
 *
 *  @return 是手机号YES
 */
+ (BOOL)tf_isSimpleMobileNumber:(NSString *)mobileNum;
@end