//
//  UIImage+Camera.h
//  DoctorYL
//
//  Created by chenTengfei on 15/6/28.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Camera)

/**
 *  @brief  将目标图片方向调整为向上
 *
 *  @param aImage 目标图片
 *
 *  @return 结果图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;

@end
