//
//  ColorMacro.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#ifndef StudyChina_ColorMacro_h
#define StudyChina_ColorMacro_h

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define kRandomColor \
[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#endif

#define kBGColor            [UIColor colorWithString:@"#eaedec"]    //灰色背景
#define kOtherBgColor       [UIColor colorWithString:@"#efeff4"]    //浅灰色背景
#define kNavigationColor    [UIColor colorWithString:@"#fca31e"]    //Navigation背景#720000  --
#define kClearColor         [UIColor clearColor]  //透明颜色
#define kGrayColor          [UIColor colorWithString:@"#666666"]    //按钮title灰色