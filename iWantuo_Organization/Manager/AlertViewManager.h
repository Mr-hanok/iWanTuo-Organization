//
//  AlertViewManager.h
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/28.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewManager : NSObject

+ (void)showAlertViewWithMessage:(NSString *)message;

+ (void)showAlertViewSuccessedMessage:(NSString *)message handlerBlock:(void(^)())handlerBlock;

/**
 *  @brief  通用消息提醒方法
 *
 *  @param title        标题
 *  @param message      消息
 *  @param cancelTitle  取消按钮文字
 *  @param confirmTitle 确认按钮文字
 *  @param handlerBlock 确认执行的block
 */
+ (void)showAlertViewWithTitle:(NSString *)title
                       Message:(NSString *)message
                   cancelTitle:(NSString *)cancelTitle
                  confirmTitle:(NSString *)confirmTitle
                  handlerBlock:(void(^)())handlerBlock;

+ (void)showAlertViewLogOutHandlerBlock:(void(^)())handlerBlock;

+ (void)showAlertViewMessage:(NSString *)message handlerBlock:(void(^)())handlerBlock;

@end
