//
//  NSString+Validation.h
//  FaBestCare
//
//  Created by CallMe周琦 on 14/12/12.
//  Copyright (c) 2014年 CallMe周琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

/// 验证手机号
-(BOOL)validateMobile:(NSString* )mobileNumber;

/// 验证纯数字
- (BOOL)textFieldreplacementString:(NSString *)string;



@end
