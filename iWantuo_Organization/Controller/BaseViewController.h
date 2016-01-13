//
//  BaseViewController.h
//  DoctorYL
//
//  Created by zhangxi on 14/12/5.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL isFirstLoad;

- (void)setBackBtn;

- (void)setBackBtnEventHandler:(void (^)(id sender))handler;

- (void)setLeftBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler;

- (void)setLeftBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler;

- (void)setRightBtn:(NSString *)btnTitle eventHandler:(void (^)(id sender))handler;

- (void)setRightBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler;

- (void)setRightBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler;

- (void)setCenterTitle:(NSString *)title;

- (void)setCenterBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler;

- (void)deleteLeftBarItem;

- (void)deleteRightBarItem;

- (void)deleteCenterView;
@end





