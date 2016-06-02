//
//  BaseViewController.m
//  DoctorYL
//
//  Created by zhangxi on 14/12/5.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstLoad = YES;
    
    self.view.backgroundColor = kBGColor;
    [self.navigationController.navigationBar setBarTintColor:kNavigationColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:(UIBarStyleBlack)];
    [self.navigationController.navigationBar setTintColor:kNavigationColor];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}];
    [self setBackBtn];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kNavigationColor};
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:20];
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

-(void)setBackBtn {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationItem.backBarButtonItem = backItem;
    self.navigationItem.backBarButtonItem = backItem;
    self.tabBarController.navigationItem.backBarButtonItem = backItem;
}

-(void)setBackBtnEventHandler:(void (^)(id sender))handler {
    UIImage *image = [UIImage imageNamed:@"backImage"];
    UIImage *image_h = [UIImage imageNamed:@"backImage"];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    NSString* backTitle = @"返回";
    CGSize titleSize = [backTitle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
    btn.frame = CGRectMake(0, 0, image.size.width + ceilf(titleSize.width) + 10, MAX(image.size.height,ceilf(titleSize.height)));
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image_h forState:UIControlStateHighlighted];
    [btn setImage:image_h forState:UIControlStateSelected];
    
    [btn setTitle:backTitle forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0., -15., 0., 0.);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0., -25., 0., 0.);
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    
    if (self.tabBarController == nil) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
       // self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

-(void)setLeftBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

- (void)setLeftBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

-(void)setRightBtn:(NSString *)btnTitle eventHandler:(void (^)(id sender))handler
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    //btn.titleLabel.textColor = kNavigationColor;
    [btn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        //self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    }
}

-(void)setRightBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 30, 44);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        //self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

-(void)setRightBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

- (void)setCenterTitle:(NSString *)title {
    
    UILabel* lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 21)];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = title;
    if (self.tabBarController == nil) {
        [self.navigationItem.titleView addSubview:lable];
    } else {
        self.tabBarController.navigationItem.titleView = lable;
    }
}

-(void)setCenterBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarController == nil) {
        [self.navigationItem.titleView addSubview:btn];
    } else {
        self.tabBarController.navigationItem.titleView = btn;
        
    }
}

- (void)deleteLeftBarItem {
    if (self.tabBarController == nil) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)deleteRightBarItem {
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)deleteCenterView {
    if (self.tabBarController == nil) {
        self.navigationItem.titleView = nil;
    } else {
        self.tabBarController.navigationItem.titleView = nil;
    }
}
@end
