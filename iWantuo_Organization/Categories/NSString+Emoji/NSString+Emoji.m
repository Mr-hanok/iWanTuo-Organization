//
//  NSString+Emoji.m
//  DoctorYL
//
//  Created by 月 吴 on 15/12/8.
//  Copyright © 2015年 yuntai. All rights reserved.
//

#import "NSString+Emoji.h"

@implementation NSString (Emoji)

/**
 *  获取系统表情中的特殊空白字符, 此特殊字符无法用LOG输出, 写入文件也是0字节的内容
 *  但是它既不是nil, 也不是 [NSNull null], 也不是@""
 */
+ (NSString *)specialBlankCharacter {
    NSString *character = @"😊";
    character = [character substringToIndex:1];
    return character;
}

@end
