//
//  UIView+Image.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Image)

/**
 *  @brief  将View转换为图片
 *
 *  @param view 目标View
 *
 *  @return 结果Image
 */
+ (UIImage *)getImageFromView:(UIView *)view;

@end
