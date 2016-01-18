//
//  SubmitInfoViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SubmitInfoViewController.h"

@interface SubmitInfoViewController ()

@end

@implementation SubmitInfoViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交资料";
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
