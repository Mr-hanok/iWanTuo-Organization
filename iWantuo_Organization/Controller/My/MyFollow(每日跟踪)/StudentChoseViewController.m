//
//  StudentChoseViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "StudentChoseViewController.h"
#import "StudentChoseCell.h"

@interface StudentChoseViewController ()

@end

@implementation StudentChoseViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inistalSearch];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪选择学生"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪选择学生"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myTypeCell = @"StudentChoseCell";
    
    StudentChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:myTypeCell];
    if (!cell) {
        cell = [StudentChoseCell shareStudentChoseCell];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeightText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - event response
#pragma mark - private methods
- (void)inistalSearch{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 30, 25)];
    iv.image = [UIImage imageNamed:@"home_glass"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    tf.placeholder = @"选择学生";
    tf.leftView = iv;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.layer.cornerRadius = 5;
    tf.layer.masksToBounds = YES;
    tf.layer.borderWidth = 1.f;
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    tf.layer.borderColor = kNavigationColor.CGColor;
    
    self.navigationItem.titleView =tf;
    
}

@end
