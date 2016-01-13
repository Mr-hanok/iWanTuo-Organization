//
//  NSString+Validation.m
//  FaBestCare
//
//  Created by CallMe周琦 on 14/12/12.
//  Copyright (c) 2014年 CallMe周琦. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+Validation.h"
#define NUMBERS @"0123456789\n"

@implementation NSString (Validation)

#pragma mark - 验证手机号
-(BOOL)validateMobile:(NSString* )mobileNumber
{
    if ([mobileNumber length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", nil) message:NSLocalizedString(@"请输入手机号码", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSString *regex = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNumber];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码!" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}
#pragma mark - 验证纯数字
- (BOOL)textFieldreplacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        return NO;
    }
    return YES;
}

@end
