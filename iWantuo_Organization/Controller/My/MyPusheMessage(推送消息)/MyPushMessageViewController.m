//
//  MyPushMessageViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyPushMessageViewController.h"

@interface MyPushMessageViewController ()

@end

@implementation MyPushMessageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推送消息";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - 协议名


#pragma mark - event response


#pragma mark - private methods

@end
